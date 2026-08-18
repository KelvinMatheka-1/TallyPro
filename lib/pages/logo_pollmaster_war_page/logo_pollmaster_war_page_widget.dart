import '/backend/supabase/supabase.dart';
import '/components/audit_row2_widget.dart';
import '/components/leaderboard_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logo_pollmaster_war_page_model.dart';
export 'logo_pollmaster_war_page_model.dart';

/// +-------------------------------------------------------------------------------------------------+
/// |  [Logo] POLLMASTER WAR ROOM COMMAND CENTER                [Machakos
/// County]       [Admin Logout]|
/// +-------------------------------------------------------------------------------------------------+
/// |  📊 LIVE CANDIDATE LEADERBOARD (Real-Time Aggregation)
///                        |
/// |
///                        |
/// |  ┌─────────────────────┐ ┌─────────────────────┐ ┌─────────────────────┐
/// ┌─────────────────────┐|
/// |  | 🥇 1st Place        | | 🥈 2nd Place        | | 🥉 3rd Place        |
/// | 4th Place           ||
/// |  | Hon.
///
/// Peter Musyoka  | | Dr. Grace Kavata    | | Eng. David Mwangi   | |
/// Boniface Kaloki     ||
/// |  | CCMB                | | URP                 | | NCC                 |
/// | IND                 ||
/// |  | 342 Votes (51.2%)   | | 215 Votes (32.1%)   | | 89 Votes (13.3%)    |
/// | 24 Votes (3.4%)     ||
/// |  └─────────────────────┘ └─────────────────────┘ └─────────────────────┘
/// └─────────────────────┘|
/// +-------------------------------------------------------------------------------------------------+
/// |  📍 POLLING STREAMS & FORM 34A TRANSMISSION AUDIT TABLE
///                        |
/// |
///                        |
/// |  Station / Stream       | Ward            | Assigned Agent  | Status
///   | Form 34A Photo     |
/// |
/// ───────────────────────┼─────────────────┼─────────────────┼──────────────┼───────────────────
/// |
/// |  Machakos Pri - Stream 1| Machakos Central| John Mutua      | 🟢 LOCKED
///   | [🔍 View Form 34A] |
/// |  Machakos Pri - Stream 2| Machakos Central| Unassigned      | ⚪ PENDING
///  | —                  |
/// |  Mlolongo Pri - Stream 1| Syokimau        | Agent 3         | 🟡 CHECKED
/// IN| —                  |
/// +-------------------------------------------------------------------------------------------------+
/// |  QUICK ACTIONS
///                        |
/// |  [ 💸 Open M-Pesa Payout Center ]            [ ✉️ Launch Bulk SMS
/// Campaign ]                    |
/// +-------------------------------------------------------------------------------------------------+
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A1C1E),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Karibu,',
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontStyle,
                                            ),
                                            color: Color(0xFFFDFDFD),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Admin',
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .override(
                                              font: GoogleFonts.outfit(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .displaySmall
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFFFB9710),
                                              fontSize: 36.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/letter-a.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Container(
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ' Candidate Leaderboard',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FutureBuilder<
                                      List<WarRoomCandidateTotalsViewRow>>(
                                    future: WarRoomCandidateTotalsViewTable()
                                        .queryRows(
                                      queryFn: (q) => q.order('total_votes'),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<WarRoomCandidateTotalsViewRow>
                                          listViewWarRoomCandidateTotalsViewRowList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewWarRoomCandidateTotalsViewRowList
                                                .length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewWarRoomCandidateTotalsViewRow =
                                              listViewWarRoomCandidateTotalsViewRowList[
                                                  listViewIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 5.0),
                                            child: LeaderboardCardWidget(
                                              key: Key(
                                                  'Keypmi_${listViewIndex}_of_${listViewWarRoomCandidateTotalsViewRowList.length}'),
                                              tone: Color(0xFFFFD700),
                                              name:
                                                  listViewWarRoomCandidateTotalsViewRow
                                                      .candidateName,
                                              party:
                                                  listViewWarRoomCandidateTotalsViewRow
                                                      .partyName,
                                              votes:
                                                  '${listViewWarRoomCandidateTotalsViewRow.totalVotes?.toString()} votes',
                                              percent:
                                                  listViewWarRoomCandidateTotalsViewRow
                                                      .votePercentage,
                                              partyName:
                                                  listViewWarRoomCandidateTotalsViewRow
                                                      .partyName!,
                                              rankLabel:
                                                  listViewWarRoomCandidateTotalsViewRow
                                                      .rankLabel!,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.place_rounded,
                                        color: Color(0xFF60CBEE),
                                        size: 24.0,
                                      ),
                                      Text(
                                        'Stream Tranmission audit',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Station / Stream',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Assigned Agent',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Status',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 16.0)),
                                      ),
                                    ],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 8.0, 16.0, 8.0),
                                                  child: Container(),
                                                ),
                                                FutureBuilder<
                                                    List<
                                                        WarRoomStreamResultsViewRow>>(
                                                  future:
                                                      WarRoomStreamResultsViewTable()
                                                          .queryRows(
                                                    queryFn: (q) => q
                                                        .order('stream_status'),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<WarRoomStreamResultsViewRow>
                                                        listViewWarRoomStreamResultsViewRowList =
                                                        snapshot.data!;

                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          listViewWarRoomStreamResultsViewRowList
                                                              .length,
                                                      itemBuilder: (context,
                                                          listViewIndex) {
                                                        final listViewWarRoomStreamResultsViewRow =
                                                            listViewWarRoomStreamResultsViewRowList[
                                                                listViewIndex];
                                                        return AuditRow2Widget(
                                                          key: Key(
                                                              'Keyjcn_${listViewIndex}_of_${listViewWarRoomStreamResultsViewRowList.length}'),
                                                          station:
                                                              '${listViewWarRoomStreamResultsViewRow.centerName} ${listViewWarRoomStreamResultsViewRow.streamName}',
                                                          ward:
                                                              '${listViewWarRoomStreamResultsViewRow.wardName}',
                                                          agent:
                                                              listViewWarRoomStreamResultsViewRow
                                                                  .agentName,
                                                          statusColor: () {
                                                            if (listViewWarRoomStreamResultsViewRow
                                                                    .streamStatus ==
                                                                'LOCKED_SUBMITTED') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .success;
                                                            } else if (listViewWarRoomStreamResultsViewRow
                                                                    .streamStatus ==
                                                                'AGENT_PRESENT') {
                                                              return Color(
                                                                  0xFFFFD939);
                                                            } else {
                                                              return Color(
                                                                  0xFFFF0D0D);
                                                            }
                                                          }(),
                                                          status: () {
                                                            if (listViewWarRoomStreamResultsViewRow
                                                                    .streamStatus ==
                                                                'LOCKED_SUBMITTED') {
                                                              return 'Form 34A Received';
                                                            } else if (listViewWarRoomStreamResultsViewRow
                                                                    .streamStatus ==
                                                                'AGENT_PRESENT') {
                                                              return 'Agent Active';
                                                            } else {
                                                              return 'Pending Agent';
                                                            }
                                                          }(),
                                                          hasPhoto: true,
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                120.0, 0.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(
                                    DisbursementmanagerpageColumnScrollablePageWidget
                                        .routeName);
                              },
                              text: 'Dsburse page',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF60CBEE),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
