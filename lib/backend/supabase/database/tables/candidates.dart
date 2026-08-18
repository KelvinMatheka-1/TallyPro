import '../database.dart';

class CandidatesTable extends SupabaseTable<CandidatesRow> {
  @override
  String get tableName => 'candidates';

  @override
  CandidatesRow createRow(Map<String, dynamic> data) => CandidatesRow(data);
}

class CandidatesRow extends SupabaseDataRow {
  CandidatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CandidatesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get partyName => getField<String>('party_name')!;
  set partyName(String value) => setField<String>('party_name', value);

  String get partyAcronym => getField<String>('party_acronym')!;
  set partyAcronym(String value) => setField<String>('party_acronym', value);

  int get ballotOrder => getField<int>('ballot_order')!;
  set ballotOrder(int value) => setField<int>('ballot_order', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
