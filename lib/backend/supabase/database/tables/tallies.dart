import '../database.dart';

class TalliesTable extends SupabaseTable<TalliesRow> {
  @override
  String get tableName => 'tallies';

  @override
  TalliesRow createRow(Map<String, dynamic> data) => TalliesRow(data);
}

class TalliesRow extends SupabaseDataRow {
  TalliesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TalliesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String? get candidateId => getField<String>('candidate_id');
  set candidateId(String? value) => setField<String>('candidate_id', value);

  String? get agentId => getField<String>('agent_id');
  set agentId(String? value) => setField<String>('agent_id', value);

  int? get votesCount => getField<int>('votes_count');
  set votesCount(int? value) => setField<int>('votes_count', value);

  DateTime? get submittedAt => getField<DateTime>('submitted_at');
  set submittedAt(DateTime? value) => setField<DateTime>('submitted_at', value);
}
