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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFF60CBEE),
                  ),
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
                : 'David Kioko (Athi River Agent)');
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
              backgroundColor: theme.secondaryBackground,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              shape: Border(
                bottom: BorderSide(
                  color: theme.alternate,
                  width: 1.0,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand Logo
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF60CBEE),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.how_to_vote_rounded,
                          color: Color(0xFF12151C),
                          size: 20.0,
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
                                color: const Color(0xFF60CBEE),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // User Profile & Logout
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0x1960CBEE),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color(0x3360CBEE),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7.0,
                              height: 7.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF02CA79),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              'LIVE',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF60CBEE),
                                fontSize: 11.0,
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
                      const SizedBox(width: 4.0),
                      IconButton(
                        tooltip: 'Log out',
                        icon: Icon(
                          Icons.logout_rounded,
                          color: theme.error,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (dialogCtx) => AlertDialog(
                              backgroundColor: theme.secondaryBackground,
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
                                  onPressed: () =>
                                      Navigator.pop(dialogCtx, false),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: theme.secondaryText),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(dialogCtx, true),
                                  child: const Text(
                                    'Log Out',
                                    style: TextStyle(
                                      color: Color(0xFFE65454),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                    ],
                  ),
                ],
              ),
            ),
            body: SafeArea(
              top: true,
              child: RefreshIndicator(
                color: const Color(0xFF60CBEE),
                backgroundColor: theme.secondaryBackground,
                onRefresh: () async {
                  safeSetState(() {});
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Agent Welcome Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: const Color(0x1960CBEE),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0x3360CBEE),
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  color: Color(0xFF60CBEE),
                                  size: 28.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Karibu,',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    agentName,
                                    style: GoogleFonts.readexPro(
                                      color: theme.primaryText,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0x1460CBEE),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Text(
                                      role,
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF60CBEE),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Assigned Polling Station Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_city_rounded,
                                      color: Color(0xFF60CBEE),
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      'Assigned Polling Station',
                                      style: GoogleFonts.readexPro(
                                        color: theme.primaryText,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.primaryBackground,
                                    borderRadius: BorderRadius.circular(6.0),
                                    border: Border.all(
                                      color: theme.alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Code: $centerCode',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12.0),

                            // Center Name
                            Text(
                              centerName,
                              style: GoogleFonts.inter(
                                color: theme.primaryText,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 6.0),

                            // Region hierarchy
                            Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  color: theme.secondaryText,
                                  size: 14.0,
                                ),
                                const SizedBox(width: 4.0),
                                Expanded(
                                  child: Text(
                                    '$wardName Ward • $constName • $countyName County',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14.0),
                            Divider(color: theme.alternate, height: 1.0),
                            const SizedBox(height: 14.0),

                            // Stream & Registered Voters Row
                            Row(
                              children: [
                                // Stream Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: theme.primaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: theme.alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.ballot_outlined,
                                              color: Color(0xFF60CBEE),
                                              size: 15.0,
                                            ),
                                            const SizedBox(width: 6.0),
                                            Text(
                                              'Stream',
                                              style: GoogleFonts.inter(
                                                color: theme.secondaryText,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          streamName,
                                          style: GoogleFonts.readexPro(
                                            color: theme.primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Registered Voters Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: theme.primaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: theme.alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.people_alt_outlined,
                                              color: Color(0xFF60CBEE),
                                              size: 15.0,
                                            ),
                                            const SizedBox(width: 6.0),
                                            Text(
                                              'Reg. Voters',
                                              style: GoogleFonts.inter(
                                                color: theme.secondaryText,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          registeredVoters,
                                          style: GoogleFonts.readexPro(
                                            color: const Color(0xFF60CBEE),
                                            fontSize: 16.0,
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

                      const SizedBox(height: 16.0),

                      // Station Check-In Status Card
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
                              borderRadius: BorderRadius.circular(16.0),
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
                                        Icon(
                                          Icons.pin_drop_rounded,
                                          color: isCheckedIn
                                              ? const Color(0xFF02CA79)
                                              : const Color(0xFFFB8C10),
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          'Station Check-In',
                                          style: GoogleFonts.readexPro(
                                            color: theme.primaryText,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                                            : const Color(0x19FB8C10),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: isCheckedIn
                                              ? const Color(0x4D02CA79)
                                              : const Color(0x4DFB8C10),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isCheckedIn
                                                ? Icons.check_circle_rounded
                                                : Icons.access_time_rounded,
                                            color: isCheckedIn
                                                ? const Color(0xFF02CA79)
                                                : const Color(0xFFFB8C10),
                                            size: 13.0,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            isCheckedIn
                                                ? 'Verified & Present'
                                                : 'Check-In Pending',
                                            style: GoogleFonts.inter(
                                              color: isCheckedIn
                                                  ? const Color(0xFF02CA79)
                                                  : const Color(0xFFFB8C10),
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12.0),

                                if (isCheckedIn) ...[
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0x0C02CA79),
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: const Color(0x2602CA79),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.verified_rounded,
                                          color: Color(0xFF02CA79),
                                          size: 18.0,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Presence verified at station',
                                                style: GoogleFonts.inter(
                                                  color: theme.primaryText,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                'Checked in: ${checkinRecord?.checkedInAt != null ? dateTimeFormat("d/M/y h:mm a", checkinRecord!.checkedInAt) : "Verified"}',
                                                style: GoogleFonts.inter(
                                                  color: theme.secondaryText,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    'You must confirm your location at the assigned polling station to record attendance.',
                                    style: GoogleFonts.inter(
                                      color: theme.secondaryText,
                                      fontSize: 13.0,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 46.0,
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
                                                    SnackBar(
                                                      content: Row(
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color:
                                                                Colors.white,
                                                            size: 18.0,
                                                          ),
                                                          SizedBox(width: 8.0),
                                                          Text(
                                                            'Location verified & recorded successfully!',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF02CA79),
                                                      duration:
                                                          const Duration(
                                                              milliseconds:
                                                                  3500),
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
                                                              0xFFE65454),
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
                                          ? const SizedBox(
                                              width: 18.0,
                                              height: 18.0,
                                              child:
                                                  CircularProgressIndicator(
                                                color: Color(0xFF12151C),
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.gps_fixed_rounded,
                                              color: Color(0xFF12151C),
                                              size: 18.0,
                                            ),
                                      label: Text(
                                        _isCheckingIn
                                            ? 'Verifying Location...'
                                            : 'Verify Location & Check-In',
                                        style: GoogleFonts.readexPro(
                                          color: const Color(0xFF12151C),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF60CBEE),
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16.0),

                      // Section Title
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 10.0),
                        child: Text(
                          'Agent Actions',
                          style: GoogleFonts.readexPro(
                            color: theme.primaryText,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Action 1: Voter Search & Roll
                      InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: () async {
                          context.pushNamed(
                            VoterSearchPageWidget.routeName,
                            queryParameters: {
                              'streamId': serializeParam(
                                agentDashAgentDashboardViewRow?.streamId,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: theme.alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x1960CBEE),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: const Icon(
                                  Icons.person_search_rounded,
                                  color: Color(0xFF60CBEE),
                                  size: 24.0,
                                ),
                              ),
                              const SizedBox(width: 14.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Voter Search & Roll',
                                      style: GoogleFonts.readexPro(
                                        color: theme.primaryText,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      'Look up voters & track stream turnout',
                                      style: GoogleFonts.inter(
                                        color: theme.secondaryText,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 34.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFF60CBEE),
                                  size: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12.0),

                      // Action 2: Results & Tally Entry
                      InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: () async {
                          context.pushNamed(
                            BackResultsTallyPageWidget.routeName,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            color: theme.secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: theme.alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x1960CBEE),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: const Icon(
                                  Icons.fact_check_rounded,
                                  color: Color(0xFF60CBEE),
                                  size: 24.0,
                                ),
                              ),
                              const SizedBox(width: 14.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Results & Tally Entry',
                                      style: GoogleFonts.readexPro(
                                        color: theme.primaryText,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      'Enter counts & upload statutory forms',
                                      style: GoogleFonts.inter(
                                        color: theme.secondaryText,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 34.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0xFF60CBEE),
                                  size: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40.0),
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
