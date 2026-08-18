import '../database.dart';

class ProfilesTable extends SupabaseTable<ProfilesRow> {
  @override
  String get tableName => 'profiles';

  @override
  ProfilesRow createRow(Map<String, dynamic> data) => ProfilesRow(data);
}

class ProfilesRow extends SupabaseDataRow {
  ProfilesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfilesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get fullName => getField<String>('full_name');
  set fullName(String? value) => setField<String>('full_name', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  String? get nationalId => getField<String>('national_id');
  set nationalId(String? value) => setField<String>('national_id', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  String? get assignedConstituencyId =>
      getField<String>('assigned_constituency_id');
  set assignedConstituencyId(String? value) =>
      setField<String>('assigned_constituency_id', value);

  String? get assignedWardId => getField<String>('assigned_ward_id');
  set assignedWardId(String? value) =>
      setField<String>('assigned_ward_id', value);

  String? get assignedStreamId => getField<String>('assigned_stream_id');
  set assignedStreamId(String? value) =>
      setField<String>('assigned_stream_id', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
