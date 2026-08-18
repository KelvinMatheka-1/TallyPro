import '../database.dart';

class ConstituenciesTable extends SupabaseTable<ConstituenciesRow> {
  @override
  String get tableName => 'constituencies';

  @override
  ConstituenciesRow createRow(Map<String, dynamic> data) =>
      ConstituenciesRow(data);
}

class ConstituenciesRow extends SupabaseDataRow {
  ConstituenciesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConstituenciesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get countyId => getField<String>('county_id');
  set countyId(String? value) => setField<String>('county_id', value);

  String get code => getField<String>('code')!;
  set code(String value) => setField<String>('code', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
