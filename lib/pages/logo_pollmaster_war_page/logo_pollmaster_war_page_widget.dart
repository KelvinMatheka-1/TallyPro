import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logo_pollmaster_war_page_model.dart';
export 'logo_pollmaster_war_page_model.dart';

class LogoPollmasterWarPageWidget extends StatefulWidget {
  const LogoPollmasterWarPageWidget({super.key});

  static String routeName = 'LogoPollmasterWarPage';
  static String routePath = '/logoPollmasterWarPage';

  @override
  State<LogoPollmasterWarPageWidget> createState() =>
      _LogoPollmasterWarPageWidgetState();
}

class _LogoPollmasterWarPageWidgetState
    extends State<LogoPollmasterWarPageWidget> {
  late LogoPollmasterWarPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _searchFilter = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogoPollmasterWarPageModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              // Squircle Brand Badge
              Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.how_to_vote_rounded,
                  color: theme.primaryBackground,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 10.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tally',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Pro',
                      style: GoogleFonts.readexPro(
                        color: theme.primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: theme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'ADMIN',
                  style: GoogleFonts.inter(
                    color: theme.primary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            // Live Status Badge
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: const Color(0x1902CA79),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0x4D02CA79),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF02CA79),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    'LIVE TALLY',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF02CA79),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6.0),

            // Theme Mode Toggle (Dark / Light)
            IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                color: theme.primaryText,
                size: 20.0,
              ),
              tooltip: Theme.of(context).brightness == Brightness.dark
                  ? 'Switch to Light Mode'
                  : 'Switch to Dark Mode',
              onPressed: () {
                final isDark =
                    Theme.of(context).brightness == Brightness.dark;
                MyApp.of(context).setThemeMode(
                    isDark ? ThemeMode.light : ThemeMode.dark);
              },
            ),

            // Logout Action
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: theme.secondaryText,
                size: 20.0,
              ),
              tooltip: 'Sign Out',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogCtx) => AlertDialog(
                    backgroundColor: theme.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    title: Text(
                      'Sign Out',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to sign out of the Admin Dashboard?',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogCtx, false),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: theme.secondaryText),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(dialogCtx, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE65454),
                          elevation: 0.0,
                        ),
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signOut();
                  GoRouter.of(context).clearRedirectLocation();
                  if (context.mounted) {
                    context.pushNamedAuth(
                        SigninCopyWidget.routeName, context.mounted);
                  }
                }
              },
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Greeting & Command Header
                Text(
                  'Election Command Center',
                  style: GoogleFonts.readexPro(
                    color: theme.primaryText,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Real-time statutory tallies & Form 34A audit',
                  style: GoogleFonts.inter(
                    color: theme.secondaryText,
                    fontSize: 13.0,
                  ),
                ),

                const SizedBox(height: 20.0),

                // Hero KPI Overview Cards
                FutureBuilder<List<WarRoomCandidateTotalsViewRow>>(
                  future: WarRoomCandidateTotalsViewTable().queryRows(
                    queryFn: (q) => q.order('total_votes', ascending: false),
                  ),
                  builder: (context, totalsSnapshot) {
                    final candidates = totalsSnapshot.data ?? [];
                    final totalVotesCast = candidates.fold<int>(
                      0,
                      (sum, c) => sum + (c.totalVotes ?? 0),
                    );
                    final leadingCandidate =
                        candidates.isNotEmpty ? candidates.first : null;

                    return FutureBuilder<List<WarRoomStreamResultsViewRow>>(
                      future: WarRoomStreamResultsViewTable().queryRows(
                        queryFn: (q) => q.order('stream_status'),
                      ),
                      builder: (context, streamsSnapshot) {
                        final streams = streamsSnapshot.data ?? [];
                        final totalStreams = streams.length;
                        final lockedStreams = streams
                            .where((s) => s.streamStatus == 'LOCKED_SUBMITTED')
                            .length;
                        final reportingPct = totalStreams > 0
                            ? ((lockedStreams / totalStreams) * 100)
                                .toStringAsFixed(1)
                            : '0.0';

                        return Column(
                          children: [
                            // Big Hero Card (like Image 1 & 2)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(22.0),
                              decoration: BoxDecoration(
                                color: theme.secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: theme.alternate,
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 16.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'TOTAL AGGREGATED VOTES',
                                        style: GoogleFonts.inter(
                                          color: theme.secondaryText,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0x1902CA79),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Text(
                                          '$reportingPct% Reported',
                                          style: GoogleFonts.inter(
                                            color: const Color(0xFF02CA79),
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        totalVotesCast.toString(),
                                        style: GoogleFonts.readexPro(
                                          color: theme.primaryText,
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        'ballots',
                                        style: GoogleFonts.inter(
                                          color: theme.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  // Nested Sub-Stats Grid
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: theme.primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Leading Candidate',
                                                style: GoogleFonts.inter(
                                                  color: theme.secondaryText,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                leadingCandidate?.candidateName !=
                                                        null
                                                    ? leadingCandidate!
                                                        .candidateName!
                                                        .split(' ')
                                                        .take(2)
                                                        .join(' ')
                                                    : '—',
                                                style: GoogleFonts.readexPro(
                                                  color: theme.primaryText,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: theme.primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Streams Locked',
                                                style: GoogleFonts.inter(
                                                  color: theme.secondaryText,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                '$lockedStreams / $totalStreams',
                                                style: GoogleFonts.readexPro(
                                                  color: theme.primaryText,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 28.0),

                // Section 1: Candidate Leaderboard
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Candidate Tally Standings',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Live Count',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                FutureBuilder<List<WarRoomCandidateTotalsViewRow>>(
                  future: WarRoomCandidateTotalsViewTable().queryRows(
                    queryFn: (q) => q.order('total_votes', ascending: false),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SizedBox(
                            width: 32.0,
                            height: 32.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.primary,
                              ),
                              strokeWidth: 2.5,
                            ),
                          ),
                        ),
                      );
                    }

                    final candidateList = snapshot.data!;
                    if (candidateList.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'No candidate tally entries yet.',
                            style: GoogleFonts.inter(
                              color: theme.secondaryText,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      );
                    }

                    final totalVotesSum = candidateList.fold<int>(
                      0,
                      (sum, c) => sum + (c.totalVotes ?? 0),
                    );

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: candidateList.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10.0),
                      itemBuilder: (context, index) {
                        final candidate = candidateList[index];
                        final votes = candidate.totalVotes ?? 0;
                        final percentage = totalVotesSum > 0
                            ? (votes / totalVotesSum) * 100
                            : 0.0;

                        Color rankColor;
                        String rankLabel;
                        if (index == 0) {
                          rankColor = const Color(0xFFFFD700);
                          rankLabel = '🥇 Leader';
                        } else if (index == 1) {
                          rankColor = const Color(0xFFC0C0C0);
                          rankLabel = '🥈 2nd';
                        } else if (index == 2) {
                          rankColor = const Color(0xFFCD7F32);
                          rankLabel = '🥉 3rd';
                        } else {
                          rankColor = theme.secondaryText;
                          rankLabel = '#${index + 1}';
                        }

                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: index == 0
                                  ? theme.primary.withValues(alpha: 0.4)
                                  : theme.alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Rank badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.primaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      rankLabel,
                                      style: GoogleFonts.inter(
                                        color: rankColor,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),

                                  // Candidate Name
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          candidate.candidateName ??
                                              'Candidate',
                                          style: GoogleFonts.readexPro(
                                            color: theme.primaryText,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          candidate.partyName ??
                                              candidate.partyAcronym ??
                                              'Party',
                                          style: GoogleFonts.inter(
                                            color: theme.secondaryText,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Votes & Percentage
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$votes votes',
                                        style: GoogleFonts.readexPro(
                                          color: theme.primaryText,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${percentage.toStringAsFixed(1)}%',
                                        style: GoogleFonts.inter(
                                          color: theme.primary,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12.0),

                              // Progress Bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: LinearProgressIndicator(
                                  value: totalVotesSum > 0
                                      ? (votes / totalVotesSum).clamp(0.0, 1.0)
                                      : 0.0,
                                  minHeight: 6.0,
                                  backgroundColor: theme.primaryBackground,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    index == 0
                                        ? theme.primary
                                        : (index == 1
                                            ? const Color(0xFF02CA79)
                                            : const Color(0xFFFB8C10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 28.0),

                // Section 2: Polling Stream Transmissions & Form 34A Feed
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stream Transmissions & Form 34A',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                // Search Filter for Polling Streams
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _searchFilter = val.trim().toLowerCase();
                    });
                  },
                  style: GoogleFonts.inter(
                    color: theme.primaryText,
                    fontSize: 13.5,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search center, stream, ward, or agent...',
                    hintStyle: GoogleFonts.inter(
                      color: theme.secondaryText,
                      fontSize: 13.0,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: theme.primary,
                      size: 18.0,
                    ),
                    filled: true,
                    fillColor: theme.secondaryBackground,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 14.0,
                    ),
                  ),
                ),

                const SizedBox(height: 14.0),

                // Audit List FutureBuilder
                FutureBuilder<List<WarRoomStreamResultsViewRow>>(
                  future: WarRoomStreamResultsViewTable().queryRows(
                    queryFn: (q) => q.order('stream_status'),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SizedBox(
                            width: 32.0,
                            height: 32.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.primary,
                              ),
                              strokeWidth: 2.5,
                            ),
                          ),
                        ),
                      );
                    }

                    var streamList = snapshot.data!;
                    if (_searchFilter.isNotEmpty) {
                      streamList = streamList.where((s) {
                        final center = (s.centerName ?? '').toLowerCase();
                        final stream = (s.streamName ?? '').toLowerCase();
                        final ward = (s.wardName ?? '').toLowerCase();
                        final agent = (s.agentName ?? '').toLowerCase();
                        return center.contains(_searchFilter) ||
                            stream.contains(_searchFilter) ||
                            ward.contains(_searchFilter) ||
                            agent.contains(_searchFilter);
                      }).toList();
                    }

                    if (streamList.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _searchFilter.isEmpty
                                ? 'No polling streams registered.'
                                : 'No streams match "$_searchFilter".',
                            style: GoogleFonts.inter(
                              color: theme.secondaryText,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: streamList.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10.0),
                      itemBuilder: (context, index) {
                        final row = streamList[index];
                        final isLocked =
                            row.streamStatus == 'LOCKED_SUBMITTED';
                        final isPresent =
                            row.streamStatus == 'AGENT_PRESENT';

                        Color statusColor;
                        String statusLabel;
                        if (isLocked) {
                          statusColor = const Color(0xFF02CA79);
                          statusLabel = 'Form 34A Transmitted';
                        } else if (isPresent) {
                          statusColor = const Color(0xFFFFD939);
                          statusLabel = 'Agent Present';
                        } else {
                          statusColor = const Color(0xFFFB8C10);
                          statusLabel = 'Pending';
                        }

                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: isLocked
                                  ? const Color(0x3302CA79)
                                  : theme.alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${row.centerName ?? 'Center'} • ${row.streamName ?? 'Stream'}',
                                          style: GoogleFonts.readexPro(
                                            color: theme.primaryText,
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          '${row.wardName ?? 'Ward'}, ${row.constituencyName ?? 'Constituency'}',
                                          style: GoogleFonts.inter(
                                            color: theme.secondaryText,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9.0,
                                      vertical: 3.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          statusColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      statusLabel,
                                      style: GoogleFonts.inter(
                                        color: statusColor,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12.0),

                              Row(
                                children: [
                                  Icon(
                                    Icons.person_pin_rounded,
                                    size: 15.0,
                                    color: theme.primary,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Agent: ',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    row.agentName ?? 'Unassigned',
                                    style: GoogleFonts.inter(
                                      color: theme.primaryText,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (row.agentPhone != null &&
                                      row.agentPhone!.isNotEmpty) ...[
                                    const SizedBox(width: 6.0),
                                    Text(
                                      '(${row.agentPhone})',
                                      style: GoogleFonts.inter(
                                        color: theme.secondaryText,
                                        fontSize: 11.5,
                                      ),
                                    ),
                                  ],
                                  const Spacer(),
                                  if (row.form34aUrl != null &&
                                      row.form34aUrl!.isNotEmpty)
                                    SizedBox(
                                      height: 28.0,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return Dialog(
                                                backgroundColor:
                                                    theme.secondaryBackground,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Form 34A Preview',
                                                            style: GoogleFonts
                                                                .readexPro(
                                                              color: theme
                                                                  .primaryText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons
                                                                    .close_rounded),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    ctx),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 12.0),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        child: Image.network(
                                                          row.form34aUrl!,
                                                          fit: BoxFit.contain,
                                                          loadingBuilder: (context,
                                                              child, progress) {
                                                            if (progress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: theme
                                                                    .primary,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.photo_library_rounded,
                                          size: 14.0,
                                          color: theme.primary,
                                        ),
                                        label: Text(
                                          'Form 34A',
                                          style: GoogleFonts.inter(
                                            color: theme.primary,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          backgroundColor:
                                              theme.primary.withValues(alpha: 0.12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
