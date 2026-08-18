import '../database.dart';

class PollingCentersTable extends SupabaseTable<PollingCentersRow> {
  @override
  String get tableName => 'polling_centers';

  @override
  PollingCentersRow createRow(Map<String, dynamic> data) =>
      PollingCentersRow(data);
}

class PollingCentersRow extends SupabaseDataRow {
  PollingCentersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PollingCentersTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get wardId => getField<String>('ward_id');
  set wardId(String? value) => setField<String>('ward_id', value);

  String get code => getField<String>('code')!;
  set code(String value) => setField<String>('code', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  double? get latitude => getField<double>('latitude');
  set latitude(double? value) => setField<double>('latitude', value);

  double? get longitude => getField<double>('longitude');
  set longitude(double? value) => setField<double>('longitude', value);

  int? get geofenceRadiusMeters => getField<int>('geofence_radius_meters');
  set geofenceRadiusMeters(int? value) =>
      setField<int>('geofence_radius_meters', value);

  int? get totalRegisteredVoters => getField<int>('total_registered_voters');
  set totalRegisteredVoters(int? value) =>
      setField<int>('total_registered_voters', value);
}
