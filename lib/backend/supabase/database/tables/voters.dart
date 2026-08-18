import '../database.dart';

class VotersTable extends SupabaseTable<VotersRow> {
  @override
  String get tableName => 'voters';

  @override
  VotersRow createRow(Map<String, dynamic> data) => VotersRow(data);
}

class VotersRow extends SupabaseDataRow {
  VotersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VotersTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String get nationalId => getField<String>('national_id')!;
  set nationalId(String value) => setField<String>('national_id', value);

  String get fullName => getField<String>('full_name')!;
  set fullName(String value) => setField<String>('full_name', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  bool? get hasVoted => getField<bool>('has_voted');
  set hasVoted(bool? value) => setField<bool>('has_voted', value);

  DateTime? get votedAt => getField<DateTime>('voted_at');
  set votedAt(DateTime? value) => setField<DateTime>('voted_at', value);

  String? get markedByAgentId => getField<String>('marked_by_agent_id');
  set markedByAgentId(String? value) =>
      setField<String>('marked_by_agent_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
