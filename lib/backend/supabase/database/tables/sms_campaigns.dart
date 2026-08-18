import '../database.dart';

class SmsCampaignsTable extends SupabaseTable<SmsCampaignsRow> {
  @override
  String get tableName => 'sms_campaigns';

  @override
  SmsCampaignsRow createRow(Map<String, dynamic> data) => SmsCampaignsRow(data);
}

class SmsCampaignsRow extends SupabaseDataRow {
  SmsCampaignsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SmsCampaignsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String get messageTemplate => getField<String>('message_template')!;
  set messageTemplate(String value) =>
      setField<String>('message_template', value);

  String? get targetWardId => getField<String>('target_ward_id');
  set targetWardId(String? value) => setField<String>('target_ward_id', value);

  String? get targetCenterId => getField<String>('target_center_id');
  set targetCenterId(String? value) =>
      setField<String>('target_center_id', value);

  String? get senderId => getField<String>('sender_id');
  set senderId(String? value) => setField<String>('sender_id', value);

  int? get totalRecipients => getField<int>('total_recipients');
  set totalRecipients(int? value) => setField<int>('total_recipients', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
