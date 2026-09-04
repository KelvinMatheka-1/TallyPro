import '/backend/supabase/supabase.dart';
import '/components/log_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'back_to_war_page_model.dart';
export 'back_to_war_page_model.dart';

class BackToWarPageWidget extends StatefulWidget {
  const BackToWarPageWidget({super.key});

  static String routeName = 'BackToWarPage';
  static String routePath = '/backToWarPage';

  @override
  State<BackToWarPageWidget> createState() => _BackToWarPageWidgetState();
}

class _BackToWarPageWidgetState extends State<BackToWarPageWidget> {
  late BackToWarPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSending = false;
  String _searchFilter = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackToWarPageModel());
    _model.textController ??= TextEditingController(
      text:
          'Polling stations are officially open! Please carry your National ID card and turn out to vote. Every single vote counts!',
    );
    _model.textFieldFocusNode ??= FocusNode();
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
    final textLength = _model.textController?.text.length ?? 0;
    final smsCredits = (textLength / 160).ceil().clamp(1, 10);

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
                Icons.mark_email_read_rounded,
                color: theme.primary,
                size: 22.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Bulk SMS Campaign',
                style: GoogleFonts.readexPro(
                  color: theme.primaryText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),

              // Sender ID Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: theme.accent1,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: theme.primary.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'SENDER: TALLYPRO',
                  style: GoogleFonts.inter(
                    color: theme.primary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(width: 8.0),

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
                // Financial & Dispatch KPI Cards
                FutureBuilder<List<SmsLogsRow>>(
                  future: SmsLogsTable().queryRows(
                    queryFn: (q) => q.order('created_at'),
                  ),
                  builder: (context, smsSnapshot) {
                    final logs = smsSnapshot.data ?? [];
                    final totalDispatched = logs.length;
                    final deliveredCount = logs
                        .where((l) =>
                            l.status?.toUpperCase() == 'DELIVERED' ||
                            l.status?.toUpperCase() == 'SENT')
                        .length;
                    final deliveryRate = totalDispatched > 0
                        ? ((deliveredCount / totalDispatched) * 100)
                            .toStringAsFixed(1)
                        : '100.0';

                    return FutureBuilder<List<VotersRow>>(
                      future: VotersTable().queryRows(
                        queryFn: (q) => q,
                      ),
                      builder: (context, votersSnapshot) {
                        final totalVoters = votersSnapshot.data?.length ?? 0;

                        return Row(
                          children: [
                            // Total Dispatched
                            Expanded(
                              child: _buildKpiCard(
                                title: 'Dispatched',
                                value: totalDispatched.toString(),
                                subtitle: 'Total Messages',
                                icon: Icons.send_rounded,
                                iconColor: theme.primary,
                                theme: theme,
                              ),
                            ),
                            const SizedBox(width: 10.0),

                            // Delivery Rate
                            Expanded(
                              child: _buildKpiCard(
                                title: 'Delivery Rate',
                                value: '$deliveryRate%',
                                subtitle: '$deliveredCount delivered',
                                icon: Icons.done_all_rounded,
                                iconColor: const Color(0xFF02CA79),
                                theme: theme,
                              ),
                            ),
                            const SizedBox(width: 10.0),

                            // Target Audience
                            Expanded(
                              child: _buildKpiCard(
                                title: 'Voter Base',
                                value: totalVoters.toString(),
                                subtitle: 'Registered Voters',
                                icon: Icons.groups_rounded,
                                iconColor: const Color(0xFFFFD939),
                                theme: theme,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 20.0),

                // Compose SMS Campaign Card
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(14.0),
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
                          Icon(
                            Icons.edit_note_rounded,
                            color: theme.primary,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Compose Mobilization Message',
                            style: GoogleFonts.readexPro(
                              color: theme.primaryText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 3.0,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryBackground,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              '🎯 Target: All Voters',
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

                      // Text Field
                      TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        maxLines: 4,
                        onChanged: (_) {
                          setState(() {});
                        },
                        style: GoogleFonts.inter(
                          color: theme.primaryText,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Type mobilization SMS text to broadcast to voters...',
                          hintStyle: GoogleFonts.inter(
                            color: theme.secondaryText,
                            fontSize: 13.0,
                          ),
                          filled: true,
                          fillColor: theme.primaryBackground,
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
                          contentPadding: const EdgeInsets.all(12.0),
                        ),
                      ),

                      const SizedBox(height: 10.0),

                      // Counter Strip & Launch Button
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Characters: $textLength / 160',
                                style: GoogleFonts.inter(
                                  color: theme.secondaryText,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '$smsCredits SMS Credit${smsCredits > 1 ? 's' : ''} per voter',
                                style: GoogleFonts.inter(
                                  color: theme.primary,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: _isSending
                                ? null
                                : () async {
                                    final text =
                                        _model.textController?.text.trim() ?? '';
                                    if (text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter a message to send.',
                                            style: GoogleFonts.inter(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: theme.error,
                                        ),
                                      );
                                      return;
                                    }

                                    setState(() {
                                      _isSending = true;
                                    });

                                    try {
                                      _model.allVoters =
                                          await VotersTable().queryRows(
                                        queryFn: (q) => q,
                                      );

                                      final phoneNumbers = _model.allVoters!
                                          .map((e) => e.phoneNumber)
                                          .withoutNulls
                                          .where((p) => p.trim().isNotEmpty)
                                          .toList();

                                      if (phoneNumbers.isEmpty) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'No voters with valid phone numbers found to broadcast.',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              backgroundColor:
                                                  const Color(0xFFE58B00),
                                              duration:
                                                  const Duration(seconds: 4),
                                            ),
                                          );
                                        }
                                        return;
                                      }

                                      final success = await actions.sendSmsBlast(
                                        phoneNumbers,
                                        text,
                                      );

                                      if (context.mounted) {
                                        if (success) {
                                          _model.textController?.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'SMS broadcast dispatched to ${phoneNumbers.length} voters!',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              backgroundColor:
                                                  const Color(0xFF02CA79),
                                              duration:
                                                  const Duration(seconds: 4),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Failed to send SMS broadcast. Check SMS gateway credentials.',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              backgroundColor: theme.error,
                                              duration:
                                                  const Duration(seconds: 4),
                                            ),
                                          );
                                        }
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Error launching SMS blast: $e',
                                              style: GoogleFonts.inter(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: theme.error,
                                          ),
                                        );
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() {
                                          _isSending = false;
                                        });
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primary,
                              disabledBackgroundColor:
                                  theme.primary.withValues(alpha: 0.6),
                              elevation: 0.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: _isSending
                                ? const SizedBox(
                                    width: 14.0,
                                    height: 14.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : const Icon(
                                    Icons.rocket_launch_rounded,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                            label: Text(
                              _isSending ? 'Sending...' : 'Launch SMS Blast',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24.0),

                // Recent Campaign Delivery Logs Section Header & Search
                Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: theme.primary,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Recent Delivery Logs',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                // Search Filter for SMS Logs
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
                    hintText: 'Search logs by recipient phone or message...',
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

                const SizedBox(height: 12.0),

                // Logs Table / List
                Container(
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                      color: theme.alternate,
                      width: 1.0,
                    ),
                  ),
                  child: FutureBuilder<List<SmsLogsRow>>(
                    future: SmsLogsTable().queryRows(
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

                      var logs = snapshot.data!;
                      if (_searchFilter.isNotEmpty) {
                        logs = logs.where((l) {
                          final phone = l.recipientPhone.toLowerCase();
                          final body = l.messageBody.toLowerCase();
                          return phone.contains(_searchFilter) ||
                              body.contains(_searchFilter);
                        }).toList();
                      }

                      if (logs.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Center(
                            child: Text(
                              _searchFilter.isEmpty
                                  ? 'No recent SMS campaign logs available.'
                                  : 'No logs match "$_searchFilter".',
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
                        itemCount: logs.length,
                        itemBuilder: (context, index) {
                          final row = logs[index];
                          return LogRowWidget(
                            key: Key('sms_log_${row.id ?? index}'),
                            phone: row.recipientPhone,
                            status: row.status ?? 'DELIVERED',
                            cost: row.cost?.toString() ?? '0.80',
                            message: row.messageBody,
                          );
                        },
                      );
                    },
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
