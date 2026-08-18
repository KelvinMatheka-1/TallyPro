import '../database.dart';

class PollingStreamsTable extends SupabaseTable<PollingStreamsRow> {
  @override
  String get tableName => 'polling_streams';

  @override
  PollingStreamsRow createRow(Map<String, dynamic> data) =>
      PollingStreamsRow(data);
}

class PollingStreamsRow extends SupabaseDataRow {
  PollingStreamsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PollingStreamsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get pollingCenterId => getField<String>('polling_center_id');
  set pollingCenterId(String? value) =>
      setField<String>('polling_center_id', value);

  String get streamName => getField<String>('stream_name')!;
  set streamName(String value) => setField<String>('stream_name', value);

  int? get registeredVoters => getField<int>('registered_voters');
  set registeredVoters(int? value) => setField<int>('registered_voters', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
