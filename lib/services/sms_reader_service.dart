import 'package:telephony/telephony.dart';
import 'sms_parser_service.dart';

class SmsReaderService {
  static final _telephony = Telephony.instance;

  static Future<bool> requestPermission() async {
    final granted = await _telephony.requestSmsPermissions;
    return granted ?? false;
  }

  static Future<List<SmsMessage>> readBankSms() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) return [];
    final cutoffMs = DateTime.now()
        .subtract(const Duration(days: 30))
        .millisecondsSinceEpoch;
    final messages = await _telephony.getInboxSms(
      columns: [
        SmsColumn.ID,
        SmsColumn.ADDRESS,
        SmsColumn.BODY,
        SmsColumn.DATE
      ],
      filter: SmsFilter.where(SmsColumn.DATE)
          .greaterThanOrEqualTo(cutoffMs.toString()),
      sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
    );
    return messages
        .where((sms) => SmsParserService.isKnownBankSender(sms.address ?? ''))
        .toList();
  }
}
