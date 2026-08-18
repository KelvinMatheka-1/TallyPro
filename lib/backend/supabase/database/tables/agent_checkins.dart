import '../database.dart';

class AgentCheckinsTable extends SupabaseTable<AgentCheckinsRow> {
  @override
  String get tableName => 'agent_checkins';

  @override
  AgentCheckinsRow createRow(Map<String, dynamic> data) =>
      AgentCheckinsRow(data);
}

class AgentCheckinsRow extends SupabaseDataRow {
  AgentCheckinsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AgentCheckinsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get agentId => getField<String>('agent_id');
  set agentId(String? value) => setField<String>('agent_id', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  double get latitude => getField<double>('latitude')!;
  set latitude(double value) => setField<double>('latitude', value);

  double get longitude => getField<double>('longitude')!;
  set longitude(double value) => setField<double>('longitude', value);

  bool? get isWithinGeofence => getField<bool>('is_within_geofence');
  set isWithinGeofence(bool? value) =>
      setField<bool>('is_within_geofence', value);

  DateTime? get checkedInAt => getField<DateTime>('checked_in_at');
  set checkedInAt(DateTime? value) =>
      setField<DateTime>('checked_in_at', value);
}
