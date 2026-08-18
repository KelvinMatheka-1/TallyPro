import '/backend/supabase/supabase.dart';
import '/components/disbursement_row_widget.dart';
import '/components/table_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'disbursementmanagerpage_column_scrollable_page_model.dart';
export 'disbursementmanagerpage_column_scrollable_page_model.dart';

/// ▼ Page (DisbursementManagerPage)
///   ▼ Column (Scrollable: ON, Padding: 24)
///     ├─ Row (Back Button + Page Title)
///     │
///     ├─ Row (3 Financial KPI Cards)
///     │   ├─ Container (Total Disbursed)
///     │   ├─ Container (Pending Approvals)
///     │   └─ Container (Success Rate)
///     │
///     └─ Container (White Table Card)
///         ▼ Column
///           ├─ Row (Table Headers: Agent, Phone, Category, Amount, Status,
/// Action)
///           └─ ListView (Query: disbursements)
///               ▼ Container (Row Item)
///                 ▼ Row
///                   ├─ Text (recipient_name)
///                   ├─ Text (recipient_phone)
///                   ├─ Text (category)
///                   ├─ Text (amount)
///                   ├─ Container (Status Pill Badge)
///                   └─ Button ("⚡ Pay via M-Pesa")
class DisbursementmanagerpageColumnScrollablePageWidget extends StatefulWidget {
  const DisbursementmanagerpageColumnScrollablePageWidget({super.key});

  static String routeName = 'DisbursementmanagerpageColumnScrollablePage';
  static String routePath = '/disbursementmanagerpageColumnScrollablePage';

  @override
  State<DisbursementmanagerpageColumnScrollablePageWidget> createState() =>
      _DisbursementmanagerpageColumnScrollablePageWidgetState();
}

class _DisbursementmanagerpageColumnScrollablePageWidgetState
    extends State<DisbursementmanagerpageColumnScrollablePageWidget> {
  late DisbursementmanagerpageColumnScrollablePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(
        context, () => DisbursementmanagerpageColumnScrollablePageModel());

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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(
                                  LogoPollmasterWarPageWidget.routeName);
                            },
                          ),
                          Text(
                            'Disbursement Manager',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 16.0, 24.0, 16.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: wrapWithModel(
                                                model: _model.tableHeaderModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TableHeaderWidget(
                                                  flexVal: '2',
                                                  label: 'AGENT / RECIPIENT',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: wrapWithModel(
                                                model: _model.tableHeaderModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TableHeaderWidget(
                                                  flexVal: '1',
                                                  label: 'CATEGORY',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: wrapWithModel(
                                                model: _model.tableHeaderModel3,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TableHeaderWidget(
                                                  flexVal: '1',
                                                  label: 'AMOUNT',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: wrapWithModel(
                                                model: _model.tableHeaderModel4,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TableHeaderWidget(
                                                  flexVal: '1',
                                                  label: 'STATUS',
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: wrapWithModel(
                                                model: _model.tableHeaderModel5,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: TableHeaderWidget(
                                                  flexVal: '2',
                                                  label: 'ACTION',
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                    FutureBuilder<List<DisbursementsRow>>(
                                      future: DisbursementsTable().queryRows(
                                        queryFn: (q) => q.order('created_at'),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<DisbursementsRow>
                                            listViewDisbursementsRowList =
                                            snapshot.data!;

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewDisbursementsRowList
                                                  .length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewDisbursementsRow =
                                                listViewDisbursementsRowList[
                                                    listViewIndex];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                DisbursementRowWidget(
                                                  key: Key(
                                                      'Keyd1e_${listViewIndex}_of_${listViewDisbursementsRowList.length}'),
                                                  name: listViewDisbursementsRow
                                                      .recipientName,
                                                  phone:
                                                      listViewDisbursementsRow
                                                          .recipientPhone,
                                                  cat: valueOrDefault<String>(
                                                    listViewDisbursementsRow
                                                        .category,
                                                    'agent stipend',
                                                  ),
                                                  amt: listViewDisbursementsRow
                                                      .amount
                                                      .toString(),
                                                  statusColor: () {
                                                    if (listViewDisbursementsRow
                                                            .status ==
                                                        'PENDING') {
                                                      return Color(0xFFFFD939);
                                                    } else if (listViewDisbursementsRow
                                                            .status ==
                                                        'PROCESSING') {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .success;
                                                    } else {
                                                      return Color(0xFFFF0D0D);
                                                    }
                                                  }(),
                                                  id: listViewDisbursementsRow
                                                      .id!,
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(150.0, 0.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(BackToWarPageWidget.routeName);
                      },
                      text: 'Home',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF60CBEE),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
