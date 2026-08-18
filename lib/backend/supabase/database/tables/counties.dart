import '../database.dart';

class CountiesTable extends SupabaseTable<CountiesRow> {
  @override
  String get tableName => 'counties';

  @override
  CountiesRow createRow(Map<String, dynamic> data) => CountiesRow(data);
}

class CountiesRow extends SupabaseDataRow {
  CountiesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CountiesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get code => getField<String>('code')!;
  set code(String value) => setField<String>('code', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
