import '/backend/supabase/supabase.dart';
import '/components/disbursement_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'disbursementmanagerpage_column_scrollable_page_model.dart';
export 'disbursementmanagerpage_column_scrollable_page_model.dart';

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
  String _searchFilter = '';

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
            children: [
              Icon(
                Icons.payments_rounded,
                color: theme.primary,
                size: 22.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Disbursement Manager',
                style: GoogleFonts.readexPro(
                  color: theme.primaryText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),

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
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Financial KPI Overview Cards
                FutureBuilder<List<DisbursementsRow>>(
                  future: DisbursementsTable().queryRows(
                    queryFn: (q) => q.order('created_at'),
                  ),
                  builder: (context, snapshot) {
                    final list = snapshot.data ?? [];
                    final totalDisbursed = list
                        .where((d) =>
                            d.status == 'PROCESSING' ||
                            d.status == 'PAID' ||
                            d.status == 'COMPLETED' ||
                            d.status == 'SUCCESS')
                        .fold<double>(0.0, (sum, d) => sum + d.amount);
                    final pendingCount =
                        list.where((d) => d.status == 'PENDING').length;
                    final totalCount = list.length;
                    final successCount = list
                        .where((d) =>
                            d.status == 'PROCESSING' ||
                            d.status == 'PAID' ||
                            d.status == 'COMPLETED' ||
                            d.status == 'SUCCESS')
                        .length;
                    final successRate = totalCount > 0
                        ? ((successCount / totalCount) * 100).toStringAsFixed(0)
                        : '100';

                    return Row(
                      children: [
                        // Total Disbursed
                        Expanded(
                          child: _buildKpiCard(
                            title: 'Disbursed',
                            value: 'KES ${totalDisbursed.toStringAsFixed(0)}',
                            subtitle: '$successCount payments sent',
                            icon: Icons.account_balance_wallet_rounded,
                            iconColor: const Color(0xFF02CA79),
                            theme: theme,
                          ),
                        ),
                        const SizedBox(width: 10.0),

                        // Pending Approvals
                        Expanded(
                          child: _buildKpiCard(
                            title: 'Pending',
                            value: '$pendingCount Payouts',
                            subtitle: 'Awaiting dispatch',
                            icon: Icons.hourglass_top_rounded,
                            iconColor: const Color(0xFFFFD939),
                            theme: theme,
                          ),
                        ),
                        const SizedBox(width: 10.0),

                        // Success Rate
                        Expanded(
                          child: _buildKpiCard(
                            title: 'Success Rate',
                            value: '$successRate%',
                            subtitle: 'M-Pesa delivery',
                            icon: Icons.check_circle_rounded,
                            iconColor: theme.primary,
                            theme: theme,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20.0),

                // Search Filter for Disbursements
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
                    hintText: 'Search agent name, phone, or category...',
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),

                // Disbursements Table / List Card
                Container(
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: theme.alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryBackground,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(13.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 50.0), // avatar space
                            Expanded(
                              flex: 3,
                              child: Text(
                                'RECIPIENT',
                                style: GoogleFonts.inter(
                                  color: theme.secondaryText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'CATEGORY',
                                style: GoogleFonts.inter(
                                  color: theme.secondaryText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'AMOUNT',
                                style: GoogleFonts.inter(
                                  color: theme.secondaryText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            SizedBox(
                              width: 65.0,
                              child: Text(
                                'ACTION',
                                style: GoogleFonts.inter(
                                  color: theme.secondaryText,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Disbursements List
                      FutureBuilder<List<DisbursementsRow>>(
                        future: DisbursementsTable().queryRows(
                          queryFn: (q) => q.order('created_at', ascending: false),
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: SizedBox(
                                  width: 32.0,
                                  height: 32.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      theme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          var list = snapshot.data!;
                          if (_searchFilter.isNotEmpty) {
                            list = list.where((d) {
                              final name =
                                  (d.recipientName ?? '').toLowerCase();
                              final phone = d.recipientPhone.toLowerCase();
                              final cat = d.category.toLowerCase();
                              return name.contains(_searchFilter) ||
                                  phone.contains(_searchFilter) ||
                                  cat.contains(_searchFilter);
                            }).toList();
                          }

                          if (list.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Center(
                                child: Text(
                                  _searchFilter.isEmpty
                                      ? 'No disbursement records available.'
                                      : 'No payouts match "$_searchFilter".',
                                  style: GoogleFonts.inter(
                                    color: theme.secondaryText,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final row = list[index];
                              return DisbursementRowWidget(
                                key: Key('payout_row_${row.id ?? index}'),
                                id: row.id,
                                name: row.recipientName ?? 'Agent',
                                phone: row.recipientPhone,
                                cat: row.category,
                                amt: row.amount.toStringAsFixed(0),
                                status: row.status ?? 'PENDING',
                                onStatusChanged: () {
                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required FlutterFlowTheme theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 16.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: theme.secondaryText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: GoogleFonts.readexPro(
              color: theme.primaryText,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: theme.secondaryText,
              fontSize: 10.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

