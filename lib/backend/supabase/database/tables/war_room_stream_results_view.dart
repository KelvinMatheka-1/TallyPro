import '../database.dart';

class WarRoomStreamResultsViewTable
    extends SupabaseTable<WarRoomStreamResultsViewRow> {
  @override
  String get tableName => 'war_room_stream_results_view';

  @override
  WarRoomStreamResultsViewRow createRow(Map<String, dynamic> data) =>
      WarRoomStreamResultsViewRow(data);
}

class WarRoomStreamResultsViewRow extends SupabaseDataRow {
  WarRoomStreamResultsViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WarRoomStreamResultsViewTable();

  String? get streamId => getField<String>('stream_id');
  set streamId(String? value) => setField<String>('stream_id', value);

  String? get streamName => getField<String>('stream_name');
  set streamName(String? value) => setField<String>('stream_name', value);

  int? get registeredVoters => getField<int>('registered_voters');
  set registeredVoters(int? value) => setField<int>('registered_voters', value);

  String? get centerName => getField<String>('center_name');
  set centerName(String? value) => setField<String>('center_name', value);

  String? get wardName => getField<String>('ward_name');
  set wardName(String? value) => setField<String>('ward_name', value);

  String? get constituencyName => getField<String>('constituency_name');
  set constituencyName(String? value) =>
      setField<String>('constituency_name', value);

  String? get agentName => getField<String>('agent_name');
  set agentName(String? value) => setField<String>('agent_name', value);

  String? get agentPhone => getField<String>('agent_phone');
  set agentPhone(String? value) => setField<String>('agent_phone', value);

  String? get form34aUrl => getField<String>('form_34a_url');
  set form34aUrl(String? value) => setField<String>('form_34a_url', value);

  int? get totalValidVotes => getField<int>('total_valid_votes');
  set totalValidVotes(int? value) => setField<int>('total_valid_votes', value);

  int? get rejectedVotes => getField<int>('rejected_votes');
  set rejectedVotes(int? value) => setField<int>('rejected_votes', value);

  bool? get isVerified => getField<bool>('is_verified');
  set isVerified(bool? value) => setField<bool>('is_verified', value);

  DateTime? get formSubmittedAt => getField<DateTime>('form_submitted_at');
  set formSubmittedAt(DateTime? value) =>
      setField<DateTime>('form_submitted_at', value);

  String? get streamStatus => getField<String>('stream_status');
  set streamStatus(String? value) => setField<String>('stream_status', value);
}
