import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/logger.dart';

@injectable
class GroqAISource {
  final SupabaseClient _supabase;
  GroqAISource(this._supabase);

  // ── System prompt for expense extraction ─────────
  static const _extractionPrompt = '''
You are a financial data extractor for an Indian expense tracker app.
Analyze the user's message and determine their intent.
Return ONLY a valid JSON object. No explanation. No markdown. No preamble.

Rules:
- intent: exactly one of "expense", "question", "greeting", or "other"
- If intent is "expense", extract the details:
  - amount: positive number in INR. If user says 2k return 2000.
  - category: exactly one of: Food | Transport | Shopping | Bills | Health | Entertainment | Education | Investment | Other
  - date: today | yesterday | DD-MM-YYYY (default today if not mentioned)
  - description: 3-6 word label in sentence case
  - confidence: 0.0 to 1.0
  - is_recurring: true only if user says monthly, every month, EMI, subscription

Output format for expense:
{
  "intent": "expense",
  "has_expense": true,
  "amount": 450,
  "category": "Food",
  "description": "Swiggy dinner order",
  "date": "today",
  "confidence": 0.97,
  "is_recurring": false
}

If no expense (like a question or greeting): 
{ 
  "intent": "question", 
  "has_expense": false 
}
''';

  static const String _conversationPrompt = '''
You are FinTrack AI, a personal finance assistant for an Indian user.

You have been given the user's REAL financial data below.
Use ONLY this data to answer. Never invent numbers. Never estimate
or project beyond what the data shows unless the user explicitly
asks for a projection.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HARD RULES — NEVER BREAK THESE:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RULE 1 — BALANCE:
  balance_remaining = monthlyIncome - totalSpentThisMonth
  Always use this formula. No other formula for balance.
  Example: income=15000, spent=12300 → balance=2700

RULE 2 — NEVER HALLUCINATE:
  Only use numbers from the FINANCIAL DATA section below.
  Never calculate a projected amount higher than monthlyIncome.
  If spending_pace > income, say 'you are spending faster than
  your income — on track to overspend this month'.

RULE 3 — PROJECTION ONLY WHEN ASKED:
  Only give month-end projections if the user explicitly asks
  'will I overspend', 'project my spend', 'how much will I spend'.
  For questions like 'what is my balance' or 'how much left' →
  use RULE 1 only. No projections.

RULE 4 — IF PROJECTION NEEDED:
  spending_pace = totalSpentThisMonth / daysElapsed
  projected_total = spending_pace × daysInMonth
  IF projected_total > monthlyIncome:
    Say: 'At this rate you may overspend. You have only
    ₹X remaining from salary.'
  NEVER say projected_total as if it is a budget or goal.

RULE 5 — CATEGORIES:
  Only mention categories that appear in the data below.
  Do not invent categories or amounts.

RULE 6 — TONE:
  Friendly, warm, 2-4 sentences max. Use ₹ symbol always.
  Never say 'projected month-end total' in a confusing way.
  Use plain language: 'you have ₹X left this month'.
''';

  Future<String> answerQuestion(
      String userQuestion, String financialContext) async {
    final token = _supabase.auth.currentSession?.accessToken;
    if (token == null) return 'Please log in to get answers.';

    try {
      final response = await _supabase.functions.invoke(
        'groq-proxy',
        body: {
          'task': 'conversation',
          'model': AppConstants.groqFastModel,
          'max_tokens': 300,
          'temperature': 0.1,
          'messages': [
            {'role': 'system', 'content': _conversationPrompt},
            {
              'role': 'user',
              'content': '$financialContext\n\nUser question: $userQuestion'
            },
          ],
        },
      );
      return response.data['choices'][0]['message']['content'] as String;
    } catch (e) {
      AppLogger.e('GroqAISource', 'answerQuestion failed', e);
      return 'Sorry, I could not fetch your data right now. Please try again.';
    }
  }

  Future<Map<String, dynamic>> extractExpense(String userText) async {
    final token = _supabase.auth.currentSession?.accessToken;
    if (token == null) {
      return {'has_expense': false, 'error': 'not_authenticated'};
    }

    try {
      print('[GroqAISource] Calling groq-proxy edge function');
      final response = await _supabase.functions.invoke(
        'groq-proxy',
        body: {
          'model': AppConstants.groqFastModel,
          'max_tokens': 256,
          'temperature': 0.1,
          'messages': [
            {'role': 'system', 'content': _extractionPrompt},
            {'role': 'user', 'content': userText},
          ],
        },
      );

      final content =
          response.data['choices'][0]['message']['content'] as String;
      return _parseJsonSafe(content);
    } on FunctionException catch (e, stackTrace) {
      AppLogger.e('GroqAISource', 'Groq request failed', e);
      print('[GroqAISource] Status: ${e.status}');
      print('[GroqAISource] Response body: ${e.details}');
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'context': 'groq_extract_function_error',
          'user_text_length': userText.length.toString(),
          'status_code': e.status.toString(),
        }),
      );
      if (e.status == 429) {
        return {'has_expense': false, 'error': 'rate_limited'};
      }
      return {'has_expense': false, 'error': 'api_error'};
    } catch (e, stackTrace) {
      AppLogger.e('GroqAISource', 'Unexpected error', e);
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'context': 'groq_extract_unexpected',
          'user_text_length': userText.length.toString(),
        }),
      );
      return {'has_expense': false, 'error': 'unexpected'};
    }
  }

  // ── System prompt for receipt scanning (vision) ─────────
  static const _receiptScanPrompt = '''
You are a receipt scanner for an Indian expense tracker app.
Extract expense information from the receipt image.
Return ONLY a valid JSON object. No explanation. No markdown. No preamble.

Rules:
- amount: total amount paid in INR (look for Total, Grand Total, Amount Due)
- merchant: business name on receipt (2-4 words max)
- date: date on receipt as DD-MM-YYYY, or today if not visible
- description: merchant + what was bought, 3-6 words, sentence case
- category: exactly one of: Food | Transport | Shopping | Bills |
  Health | Entertainment | Education | Investment | Other
- confidence: 0.0 to 1.0

If the image is NOT a receipt or amount cannot be read:
{ "has_expense": false, "error": "not_a_receipt" }

Output format:
{
  "has_expense": true,
  "amount": 847.50,
  "merchant": "Reliance Fresh",
  "description": "Reliance Fresh grocery shopping",
  "date": "today",
  "category": "Food",
  "confidence": 0.93,
  "is_recurring": false
}
''';

  Future<Map<String, dynamic>> scanReceipt(String base64Image) async {
    final token = _supabase.auth.currentSession?.accessToken;
    if (token == null) {
      return {'has_expense': false, 'error': 'not_authenticated'};
    }
    try {
      final response = await _supabase.functions.invoke(
        'groq-proxy',
        body: {
          'task': 'scan_receipt',
          'model': 'meta-llama/llama-4-scout-17b-16e-instruct',
          'max_tokens': 512,
          'temperature': 0.1,
          'messages': [
            {'role': 'system', 'content': _receiptScanPrompt},
            {
              'role': 'user',
              'content': [
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                    'detail': 'high',
                  },
                },
                {
                  'type': 'text',
                  'text': 'Extract the expense from this receipt.',
                },
              ],
            },
          ],
        },
      );
      final content =
          response.data['choices'][0]['message']['content'] as String;
      return _parseJsonSafe(content);
    } on FunctionException catch (e, stackTrace) {
      AppLogger.e('GroqAISource', 'Receipt scan failed', e);
      await Sentry.captureException(e,
          stackTrace: stackTrace,
          hint: Hint.withMap({'context': 'groq_receipt_scan'}));
      if (e.status == 429) {
        return {'has_expense': false, 'error': 'rate_limited'};
      }
      return {'has_expense': false, 'error': 'api_error'};
    } catch (e, stackTrace) {
      await Sentry.captureException(e,
          stackTrace: stackTrace,
          hint: Hint.withMap({'context': 'groq_receipt_unexpected'}));
      return {'has_expense': false, 'error': 'unexpected'};
    }
  }

  Map<String, dynamic> _parseJsonSafe(String raw) {
    try {
      final cleaned = raw.replaceAll(RegExp(r'```json|```'), '').trim();
      return jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'context': 'groq_parse_failed',
          'raw_content': raw,
        }),
      );
      return {'has_expense': false, 'error': 'parse_failed'};
    }
  }
}
