import 'package:telephony/telephony.dart';
import 'auto_categorise_service.dart';

class ParsedSmsTransaction {
  final String smsId;
  final String sender;
  final String rawBody;
  final double amount;
  final String merchant;
  final String description;
  final String category;
  final DateTime date;
  const ParsedSmsTransaction(
      {required this.smsId,
      required this.sender,
      required this.rawBody,
      required this.amount,
      required this.merchant,
      required this.description,
      required this.category,
      required this.date});
}

class SmsParserService {
  static const _knownSenders = [
    'HDFCBK',
    'HDFCBANK',
    'HDFCCC',
    'ICICIB',
    'ICICIBANK',
    'ICICIPAY',
    'SBIINB',
    'SBIPSG',
    'SBIUPI',
    'YONOSBI',
    'AXISBK',
    'AXISBANK',
    'KOTAKB',
    'KOTAK',
    'INDBNK',
    'INDUSBK',
    'YESBK',
    'YESBANK',
    'PYTMBNK',
    'PAYTM',
    'PAYTMUPI',
    'PHONEPE',
    'GPAY',
    'GOOGLEPAY',
    'AMZPAY',
    'AMAZONPAY',
    'BHIMUPI',
    'NPCIUPI',
  ];

  static bool isKnownBankSender(String sender) {
    final upper = sender.toUpperCase().replaceAll('-', '');
    return _knownSenders.any((s) => upper.contains(s));
  }

  static ParsedSmsTransaction? parse(SmsMessage sms) {
    final body = sms.body ?? '';
    if (!_isDebit(body)) return null;
    final amount = _extractAmount(body);
    if (amount == null || amount <= 0) return null;
    final merchant = _extractMerchant(body);
    return ParsedSmsTransaction(
      smsId: sms.id.toString(),
      sender: sms.address ?? '',
      rawBody: body,
      amount: amount,
      merchant: merchant,
      description: '$merchant payment',
      category: AutoCategoriseService.categorise(merchant),
      date: sms.date != null
          ? DateTime.fromMillisecondsSinceEpoch(sms.date!)
          : DateTime.now(),
    );
  }

  static double? _extractAmount(String body) {
    final patterns = [
      RegExp(r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)', caseSensitive: false),
      RegExp(
          r'debited\s+(?:by|for|with|of)\s+(?:Rs\.?|INR|₹)?\s*([\d,]+(?:\.\d{1,2})?)',
          caseSensitive: false),
    ];
    for (final p in patterns) {
      final m = p.firstMatch(body);
      if (m != null) {
        return double.tryParse(m.group(1)!.replaceAll(',', ''));
      }
    }
    return null;
  }

  static bool _isDebit(String body) {
    final l = body.toLowerCase();
    final hasDebit = l.contains('debited') ||
        l.contains('paid') ||
        l.contains('sent') ||
        l.contains('purchase') ||
        l.contains('payment of');
    final isCredit = l.contains('credited') ||
        l.contains('received') ||
        l.contains('refund') ||
        l.contains('cashback');
    return hasDebit && !isCredit;
  }

  static String _extractMerchant(String body) {
    final p = RegExp(
        r'(?:to|at|towards|for)\s+([A-Z][A-Za-z0-9\s&\.]{2,30}?)(?:\s+on|\s+via|\s+Ref|\.|\s*$)',
        caseSensitive: false);
    final m = p.firstMatch(body);
    if (m != null) {
      final raw = m.group(1)!.trim();
      return raw.length > 30 ? raw.substring(0, 30) : raw;
    }
    return 'Bank Transaction';
  }
}
