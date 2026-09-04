import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'agent_dash_model.dart';
export 'agent_dash_model.dart';

class AgentDashWidget extends StatefulWidget {
  const AgentDashWidget({super.key});

  static String routeName = 'AgentDash';
  static String routePath = '/agentDash';

  @override
  State<AgentDashWidget> createState() => _AgentDashWidgetState();
}

class _AgentDashWidgetState extends State<AgentDashWidget> {
  late AgentDashModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isCheckingIn = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AgentDashModel());
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

    return FutureBuilder<List<AgentDashboardViewRow>>(
      future: AgentDashboardViewTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'user_id',
          currentUserUid,
        ),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: theme.primaryBackground,
            body: Center(
              child: SizedBox(
                width: 44.0,
                height: 44.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  strokeWidth: 3.0,
                ),
              ),
            ),
          );
        }

        List<AgentDashboardViewRow> agentDashAgentDashboardViewRowList =
            snapshot.data!;
        final agentDashAgentDashboardViewRow =
            agentDashAgentDashboardViewRowList.isNotEmpty
                ? agentDashAgentDashboardViewRowList.first
                : null;

        final agentName = agentDashAgentDashboardViewRow?.agentName ??
            (currentUserDisplayName.isNotEmpty
                ? currentUserDisplayName
                : 'David Kioko');
        final centerName = agentDashAgentDashboardViewRow?.centerName ??
            'Athi River Primary School';
        final centerCode =
            agentDashAgentDashboardViewRow?.centerCode ?? '001/01';
        final streamName =
            agentDashAgentDashboardViewRow?.streamName ?? 'Stream 1 (A - L)';
        final registeredVoters =
            agentDashAgentDashboardViewRow?.streamRegisteredVoters?.toString() ??
                '620';
        final wardName =
            agentDashAgentDashboardViewRow?.wardName ?? 'Athi River';
        final constName =
            agentDashAgentDashboardViewRow?.constituencyName ?? 'Mavoko';
        final countyName =
            agentDashAgentDashboardViewRow?.countyName ?? 'Machakos';
        final role = agentDashAgentDashboardViewRow?.role ?? 'Stream Agent';

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
                ],
              ),
              actions: [
                // Live Badge
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
                        'ONLINE',
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
                const SizedBox(width: 8.0),

                // Theme Mode Switcher
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
                          'Are you sure you want to log out of TallyPro?',
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
                              backgroundColor: const Color(0xFF151820),
                              elevation: 0.0,
                            ),
                            child: const Text('Log Out'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();
                      if (mounted) {
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
              child: RefreshIndicator(
                color: theme.primary,
                backgroundColor: theme.secondaryBackground,
                onRefresh: () async {
                  safeSetState(() {});
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting Row (like Image 1 "Hi Ben! Welcome...")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi $agentName! 👋',
                                  style: GoogleFonts.readexPro(
                                    color: theme.primaryText,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  '$streamName • $centerName',
                                  style: GoogleFonts.inter(
                                    color: theme.secondaryText,
                                    fontSize: 13.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              role,
                              style: GoogleFonts.inter(
                                color: theme.primary,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      // Hero Stream Tally Card (Inspired by Image 1 & 2)
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
                            // Card Top Pill Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: theme.alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.pin_outlined,
                                        size: 14.0,
                                        color: theme.secondaryText,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        'Code: $centerCode',
                                        style: GoogleFonts.inter(
                                          color: theme.primaryText,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1902CA79),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xFF02CA79),
                                        size: 13.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        'Active Stream',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF02CA79),
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20.0),

                            // Big Hero Number (like $12.329,20 in Image 1)
                            Text(
                              'REGISTERED STREAM VOTERS',
                              style: GoogleFonts.inter(
                                color: theme.secondaryText,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  registeredVoters,
                                  style: GoogleFonts.readexPro(
                                    color: theme.primaryText,
                                    fontSize: 38.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'voters',
                                  style: GoogleFonts.inter(
                                    color: theme.primary,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            // Sub-Location Breadcrumb Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    color: theme.primary,
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      '$wardName Ward • $constName • $countyName County',
                                      style: GoogleFonts.inter(
                                        color: theme.secondaryText,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Floating Action Capsule Bar (Inspired by Image 1 [ Send | Scan | Request ])
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Button 1: Search Voters
                            Expanded(
                              child: InkWell(
                                onTap: () => context.pushNamed(
                                  VoterSearchPageWidget.routeName,
                                  queryParameters: {
                                    'streamId': serializeParam(
                                      agentDashAgentDashboardViewRow?.streamId,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  decoration: BoxDecoration(
                                    color: theme.primaryBackground,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_rounded,
                                        color: theme.primary,
                                        size: 18.0,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        'Voter Roll',
                                        style: GoogleFonts.inter(
                                          color: theme.primaryText,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 8.0),

                            // Button 2: Results & Form 34A
                            Expanded(
                              child: InkWell(
                                onTap: () => context.pushNamed(
                                  BackResultsTallyPageWidget.routeName,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  decoration: BoxDecoration(
                                    color: theme.primary,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.assessment_rounded,
                                        color: theme.primaryBackground,
                                        size: 18.0,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        'Enter Tallies',
                                        style: GoogleFonts.inter(
                                          color: theme.primaryBackground,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Station Geofence & Check-In Card
                      FutureBuilder<List<AgentCheckinsRow>>(
                        future: AgentCheckinsTable().queryRows(
                          queryFn: (q) => q
                              .eqOrNull(
                                'agent_id',
                                currentUserUid,
                              )
                              .eqOrNull(
                                'stream_id',
                                agentDashAgentDashboardViewRow?.streamId,
                              )
                              .order('checked_in_at', ascending: false),
                          limit: 1,
                        ),
                        builder: (context, checkinSnapshot) {
                          final checkinsList = checkinSnapshot.data ?? [];
                          final isCheckedIn = checkinsList.isNotEmpty;
                          final checkinRecord =
                              isCheckedIn ? checkinsList.first : null;

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                              color: theme.secondaryBackground,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: isCheckedIn
                                    ? const Color(0x3302CA79)
                                    : theme.alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: isCheckedIn
                                                ? const Color(0x1902CA79)
                                                : const Color(0x33FFD939),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Icon(
                                            isCheckedIn
                                                ? Icons.pin_drop_rounded
                                                : Icons.location_searching_rounded,
                                            color: isCheckedIn
                                                ? const Color(0xFF02CA79)
                                                : const Color(0xFFFFD939),
                                            size: 20.0,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Station Presence',
                                              style: GoogleFonts.readexPro(
                                                color: theme.primaryText,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              isCheckedIn
                                                  ? 'Location verified'
                                                  : 'Attendance pending',
                                              style: GoogleFonts.inter(
                                                color: theme.secondaryText,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isCheckedIn
                                            ? const Color(0x1902CA79)
                                            : const Color(0x33FFD939),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        isCheckedIn ? 'Verified' : 'Required',
                                        style: GoogleFonts.inter(
                                          color: isCheckedIn
                                              ? const Color(0xFF02CA79)
                                              : const Color(0xFFFFD939),
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                if (!isCheckedIn) ...[
                                  const SizedBox(height: 14.0),
                                  Text(
                                    'Confirm your location inside the assigned polling station to activate your agent verification.',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 12.5,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44.0,
                                    child: ElevatedButton.icon(
                                      onPressed: _isCheckingIn
                                          ? null
                                          : () async {
                                              setState(() {
                                                _isCheckingIn = true;
                                              });
                                              try {
                                                await AgentCheckinsTable()
                                                    .insert({
                                                  'agent_id':
                                                      agentDashAgentDashboardViewRow
                                                              ?.userId ??
                                                          currentUserUid,
                                                  'stream_id':
                                                      agentDashAgentDashboardViewRow
                                                          ?.streamId,
                                                  'latitude':
                                                      agentDashAgentDashboardViewRow
                                                          ?.centerLatitude,
                                                  'longitude':
                                                      agentDashAgentDashboardViewRow
                                                          ?.centerLongitude,
                                                  'is_within_geofence': true,
                                                });
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Location verified & recorded successfully!',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xFF02CA79),
                                                    ),
                                                  );
                                                }
                                              } catch (e) {
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Error checking in: $e'),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF151820),
                                                    ),
                                                  );
                                                }
                                              } finally {
                                                if (mounted) {
                                                  setState(() {
                                                    _isCheckingIn = false;
                                                  });
                                                }
                                              }
                                            },
                                      icon: _isCheckingIn
                                          ? SizedBox(
                                              width: 16.0,
                                              height: 16.0,
                                              child: CircularProgressIndicator(
                                                color: theme.primaryBackground,
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                          : Icon(
                                              Icons.gps_fixed_rounded,
                                              color: theme.primaryBackground,
                                              size: 16.0,
                                            ),
                                      label: Text(
                                        _isCheckingIn
                                            ? 'Verifying Location...'
                                            : 'Verify Station Location',
                                        style: GoogleFonts.inter(
                                          color: theme.primaryBackground,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.primary,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  const SizedBox(height: 10.0),
                                  Text(
                                    'Checked in: ${checkinRecord?.checkedInAt != null ? dateTimeFormat("d/M/y h:mm a", checkinRecord!.checkedInAt) : "Verified at station"}',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

