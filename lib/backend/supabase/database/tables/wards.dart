import '../database.dart';

class WardsTable extends SupabaseTable<WardsRow> {
  @override
  String get tableName => 'wards';

  @override
  WardsRow createRow(Map<String, dynamic> data) => WardsRow(data);
}

class WardsRow extends SupabaseDataRow {
  WardsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WardsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get constituencyId => getField<String>('constituency_id');
  set constituencyId(String? value) =>
      setField<String>('constituency_id', value);

  String get code => getField<String>('code')!;
  set code(String value) => setField<String>('code', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);
}
