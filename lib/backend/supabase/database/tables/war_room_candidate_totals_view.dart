import '../database.dart';

class WarRoomCandidateTotalsViewTable
    extends SupabaseTable<WarRoomCandidateTotalsViewRow> {
  @override
  String get tableName => 'war_room_candidate_totals_view';

  @override
  WarRoomCandidateTotalsViewRow createRow(Map<String, dynamic> data) =>
      WarRoomCandidateTotalsViewRow(data);
}

class WarRoomCandidateTotalsViewRow extends SupabaseDataRow {
  WarRoomCandidateTotalsViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WarRoomCandidateTotalsViewTable();

  String? get candidateId => getField<String>('candidate_id');
  set candidateId(String? value) => setField<String>('candidate_id', value);

  String? get candidateName => getField<String>('candidate_name');
  set candidateName(String? value) => setField<String>('candidate_name', value);

  String? get partyName => getField<String>('party_name');
  set partyName(String? value) => setField<String>('party_name', value);

  String? get partyAcronym => getField<String>('party_acronym');
  set partyAcronym(String? value) => setField<String>('party_acronym', value);

  int? get ballotOrder => getField<int>('ballot_order');
  set ballotOrder(int? value) => setField<int>('ballot_order', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  int? get totalVotes => getField<int>('total_votes');
  set totalVotes(int? value) => setField<int>('total_votes', value);

  int? get totalVotesAllCandidates =>
      getField<int>('total_votes_all_candidates');
  set totalVotesAllCandidates(int? value) =>
      setField<int>('total_votes_all_candidates', value);

  double? get votePercentage => getField<double>('vote_percentage');
  set votePercentage(double? value) =>
      setField<double>('vote_percentage', value);

  int? get rankNumber => getField<int>('rank_number');
  set rankNumber(int? value) => setField<int>('rank_number', value);

  String? get rankLabel => getField<String>('rank_label');
  set rankLabel(String? value) => setField<String>('rank_label', value);
}
