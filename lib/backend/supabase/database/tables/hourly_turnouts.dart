import '../database.dart';

class HourlyTurnoutsTable extends SupabaseTable<HourlyTurnoutsRow> {
  @override
  String get tableName => 'hourly_turnouts';

  @override
  HourlyTurnoutsRow createRow(Map<String, dynamic> data) =>
      HourlyTurnoutsRow(data);
}

class HourlyTurnoutsRow extends SupabaseDataRow {
  HourlyTurnoutsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => HourlyTurnoutsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String? get agentId => getField<String>('agent_id');
  set agentId(String? value) => setField<String>('agent_id', value);

  String get hourSlot => getField<String>('hour_slot')!;
  set hourSlot(String value) => setField<String>('hour_slot', value);

  int get cumulativeVotedCount => getField<int>('cumulative_voted_count')!;
  set cumulativeVotedCount(int value) =>
      setField<int>('cumulative_voted_count', value);

  DateTime? get submittedAt => getField<DateTime>('submitted_at');
  set submittedAt(DateTime? value) => setField<DateTime>('submitted_at', value);
}
