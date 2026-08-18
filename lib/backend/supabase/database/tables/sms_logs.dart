import '../database.dart';

class SmsLogsTable extends SupabaseTable<SmsLogsRow> {
  @override
  String get tableName => 'sms_logs';

  @override
  SmsLogsRow createRow(Map<String, dynamic> data) => SmsLogsRow(data);
}

class SmsLogsRow extends SupabaseDataRow {
  SmsLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SmsLogsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get campaignId => getField<String>('campaign_id');
  set campaignId(String? value) => setField<String>('campaign_id', value);

  String get recipientPhone => getField<String>('recipient_phone')!;
  set recipientPhone(String value) =>
      setField<String>('recipient_phone', value);

  String get messageBody => getField<String>('message_body')!;
  set messageBody(String value) => setField<String>('message_body', value);

  String get senderId => getField<String>('sender_id')!;
  set senderId(String value) => setField<String>('sender_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get gatewayMessageId => getField<String>('gateway_message_id');
  set gatewayMessageId(String? value) =>
      setField<String>('gateway_message_id', value);

  double? get cost => getField<double>('cost');
  set cost(double? value) => setField<double>('cost', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
