import '../database.dart';

class DisbursementsTable extends SupabaseTable<DisbursementsRow> {
  @override
  String get tableName => 'disbursements';

  @override
  DisbursementsRow createRow(Map<String, dynamic> data) =>
      DisbursementsRow(data);
}

class DisbursementsRow extends SupabaseDataRow {
  DisbursementsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DisbursementsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get recipientPhone => getField<String>('recipient_phone')!;
  set recipientPhone(String value) =>
      setField<String>('recipient_phone', value);

  String? get recipientName => getField<String>('recipient_name');
  set recipientName(String? value) => setField<String>('recipient_name', value);

  String get category => getField<String>('category')!;
  set category(String value) => setField<String>('category', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get batchId => getField<String>('batch_id');
  set batchId(String? value) => setField<String>('batch_id', value);

  String? get mpesaConversationId => getField<String>('mpesa_conversation_id');
  set mpesaConversationId(String? value) =>
      setField<String>('mpesa_conversation_id', value);

  String? get mpesaOriginatorConversationId =>
      getField<String>('mpesa_originator_conversation_id');
  set mpesaOriginatorConversationId(String? value) =>
      setField<String>('mpesa_originator_conversation_id', value);

  String? get mpesaReceiptNumber => getField<String>('mpesa_receipt_number');
  set mpesaReceiptNumber(String? value) =>
      setField<String>('mpesa_receipt_number', value);

  String? get failureReason => getField<String>('failure_reason');
  set failureReason(String? value) => setField<String>('failure_reason', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
