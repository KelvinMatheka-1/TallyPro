import '../database.dart';

class AgentDashboardViewTable extends SupabaseTable<AgentDashboardViewRow> {
  @override
  String get tableName => 'agent_dashboard_view';

  @override
  AgentDashboardViewRow createRow(Map<String, dynamic> data) =>
      AgentDashboardViewRow(data);
}

class AgentDashboardViewRow extends SupabaseDataRow {
  AgentDashboardViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AgentDashboardViewTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get agentName => getField<String>('agent_name');
  set agentName(String? value) => setField<String>('agent_name', value);

  String? get agentPhone => getField<String>('agent_phone');
  set agentPhone(String? value) => setField<String>('agent_phone', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String? get streamName => getField<String>('stream_name');
  set streamName(String? value) => setField<String>('stream_name', value);

  int? get streamRegisteredVoters => getField<int>('stream_registered_voters');
  set streamRegisteredVoters(int? value) =>
      setField<int>('stream_registered_voters', value);

  String? get centerId => getField<String>('center_id');
  set centerId(String? value) => setField<String>('center_id', value);

  String? get centerCode => getField<String>('center_code');
  set centerCode(String? value) => setField<String>('center_code', value);

  String? get centerName => getField<String>('center_name');
  set centerName(String? value) => setField<String>('center_name', value);

  double? get centerLatitude => getField<double>('center_latitude');
  set centerLatitude(double? value) =>
      setField<double>('center_latitude', value);

  double? get centerLongitude => getField<double>('center_longitude');
  set centerLongitude(double? value) =>
      setField<double>('center_longitude', value);

  int? get geofenceRadiusMeters => getField<int>('geofence_radius_meters');
  set geofenceRadiusMeters(int? value) =>
      setField<int>('geofence_radius_meters', value);

  String? get wardId => getField<String>('ward_id');
  set wardId(String? value) => setField<String>('ward_id', value);

  String? get wardName => getField<String>('ward_name');
  set wardName(String? value) => setField<String>('ward_name', value);

  String? get constituencyId => getField<String>('constituency_id');
  set constituencyId(String? value) =>
      setField<String>('constituency_id', value);

  String? get constituencyName => getField<String>('constituency_name');
  set constituencyName(String? value) =>
      setField<String>('constituency_name', value);

  String? get countyId => getField<String>('county_id');
  set countyId(String? value) => setField<String>('county_id', value);

  String? get countyName => getField<String>('county_name');
  set countyName(String? value) => setField<String>('county_name', value);
}
