// Archived: Replaced local pattern matching with Groq AI intent extraction — 2026-03-08
// Pure Dart — no imports needed. Zero API cost.

enum ChatIntent {
  expense, // user is logging an expense
  question, // user is asking about their finances
  greeting, // hi, hello, hey
  outOfScope, // completely off-topic
}

class ChatIntentClassifier {
  static ChatIntent classify(String text) {
    final t = text.toLowerCase().trim();
    if (t.isEmpty) return ChatIntent.expense;

    // ── Greeting check ────────────────────────────────────
    if (_matchesAny(t, [
      'hi',
      'hello',
      'hey',
      'hii',
      'helo',
      'good morning',
      'good evening',
      'sup',
      'yo',
      'namaste',
    ])) return ChatIntent.greeting;

    // ── Question check — strong signals ───────────────────
    // Any of these words almost certainly means a question
    if (_matchesAny(t, [
      'how much', 'how many', 'how are', 'how do',
      'what is', 'what are', 'what was', 'what were',
      'tell me', 'show me', 'give me', 'can you',
      'balance', 'left', 'remaining', 'available',
      'total', 'summary', 'overview', 'report',
      'budget', 'limit', 'over budget', 'under budget',
      'saving', 'savings',
      'salary', 'income', 'earning',
      'most', 'least', 'highest', 'lowest', 'top',
      'analysis', 'analyse', 'analyze',
      'advice', 'suggest', 'tip', 'recommend',
      'am i', 'am i on track', 'doing well', 'doing good',
      'afford', 'can i buy', 'should i',
      '?', // ends with question mark
    ])) return ChatIntent.question;

    // ── Expense signal — strong indicators ────────────────
    if (_matchesAny(t, [
      'spent',
      'spend',
      'paid',
      'pay',
      'bought',
      'buy',
      'purchased',
      'ordered',
      'got',
      'took',
      'used',
      'swiped',
      'transferred',
      'sent money',
      'cash',
      'emi',
      'bill',
      'recharge',
      'subscription',
      'rupees',
      'rs ',
      '₹',
    ])) {
      // BUT only if it also has a number
      if (RegExp(r'\d').hasMatch(t)) return ChatIntent.expense;
      // Has expense words but no number — treat as question
      return ChatIntent.question;
    }

    // ── Number-only messages (e.g. '450 swiggy') ─────────
    if (RegExp(r'^\d').hasMatch(t)) return ChatIntent.expense;

    // ── Default: treat as question if uncertain ───────────
    // Better to over-answer than give 'no expense found'
    return ChatIntent.question;
  }

  static bool _matchesAny(String text, List<String> keywords) =>
      keywords.any((k) => text.contains(k));
}
