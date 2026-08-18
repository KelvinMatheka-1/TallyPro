import '../database.dart';

class StatutoryFormsTable extends SupabaseTable<StatutoryFormsRow> {
  @override
  String get tableName => 'statutory_forms';

  @override
  StatutoryFormsRow createRow(Map<String, dynamic> data) =>
      StatutoryFormsRow(data);
}

class StatutoryFormsRow extends SupabaseDataRow {
  StatutoryFormsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StatutoryFormsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String? get agentId => getField<String>('agent_id');
  set agentId(String? value) => setField<String>('agent_id', value);

  String? get formType => getField<String>('form_type');
  set formType(String? value) => setField<String>('form_type', value);

  String get imageUrl => getField<String>('image_url')!;
  set imageUrl(String value) => setField<String>('image_url', value);

  int get totalValidVotes => getField<int>('total_valid_votes')!;
  set totalValidVotes(int value) => setField<int>('total_valid_votes', value);

  int? get rejectedVotes => getField<int>('rejected_votes');
  set rejectedVotes(int? value) => setField<int>('rejected_votes', value);

  int? get disputedVotes => getField<int>('disputed_votes');
  set disputedVotes(int? value) => setField<int>('disputed_votes', value);

  bool? get isVerified => getField<bool>('is_verified');
  set isVerified(bool? value) => setField<bool>('is_verified', value);

  DateTime? get submittedAt => getField<DateTime>('submitted_at');
  set submittedAt(DateTime? value) => setField<DateTime>('submitted_at', value);
}
