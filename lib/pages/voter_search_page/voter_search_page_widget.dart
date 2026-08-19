import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'voter_search_page_model.dart';
export 'voter_search_page_model.dart';

class VoterSearchPageWidget extends StatefulWidget {
  const VoterSearchPageWidget({
    super.key,
    required this.streamId,
  });

  final String? streamId;

  static String routeName = 'VoterSearchPage';
  static String routePath = '/voterSearchPage';

  @override
  State<VoterSearchPageWidget> createState() => _VoterSearchPageWidgetState();
}

class _VoterSearchPageWidgetState extends State<VoterSearchPageWidget>
    with TickerProviderStateMixin {
  late VoterSearchPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _updatingVoterIds = {};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoterSearchPageModel());
    _model.textController ??= TextEditingController();
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
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: theme.primaryText,
                  size: 22.0,
                ),
                onPressed: () async {
                  context.pushNamed(AgentDashWidget.routeName);
                },
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Voter Roll & Search',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Stream Voter Register',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0x1960CBEE),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0x3360CBEE),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  'STREAM',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF60CBEE),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              // Search Input Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.alternate,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.textController',
                        const Duration(milliseconds: 150),
                        () => safeSetState(() {}),
                      ),
                      style: GoogleFonts.inter(
                        color: theme.primaryText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Search by Name or National ID...',
                        hintStyle: GoogleFonts.inter(
                          color: theme.secondaryText,
                          fontSize: 14.0,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF60CBEE),
                          size: 20.0,
                        ),
                        suffixIcon: (_model.textController?.text.isNotEmpty ?? false)
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: theme.secondaryText,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  _model.textController?.clear();
                                  safeSetState(() {});
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: theme.primaryBackground,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF60CBEE),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Voters List with FutureBuilder
              Expanded(
                child: FutureBuilder<List<VotersRow>>(
                  future: (_model.requestCompleter ??=
                          Completer<List<VotersRow>>()
                            ..complete(VotersTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'stream_id',
                                    widget.streamId,
                                  )
                                  .order('full_name', ascending: true),
                            )))
                      .future,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 44.0,
                          height: 44.0,
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF60CBEE),
                            ),
                            strokeWidth: 3.0,
                          ),
                        ),
                      );
                    }

                    List<VotersRow> allVoters = snapshot.data!;
                    final searchTerm = _model.textController?.text ?? '';

                    // Filter voters using the corrected filtervoters function
                    final filteredVoters = allVoters.where((voter) {
                      return functions.filtervoters(
                            voter.nationalId,
                            voter.fullName,
                            searchTerm,
                          ) ??
                          true;
                    }).toList();

                    final totalCount = allVoters.length;
                    final votedCount =
                        allVoters.where((v) => v.hasVoted == true).length;
                    final pendingCount = totalCount - votedCount;

                    return Column(
                      children: [
                        // Turnout Summary Strip
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          color: theme.primaryBackground,
                          child: Row(
                            children: [
                              _buildStatChip(
                                label: 'Total',
                                value: '$totalCount',
                                color: theme.secondaryText,
                                theme: theme,
                              ),
                              const SizedBox(width: 8.0),
                              _buildStatChip(
                                label: 'Voted',
                                value: '$votedCount',
                                color: const Color(0xFF02CA79),
                                theme: theme,
                              ),
                              const SizedBox(width: 8.0),
                              _buildStatChip(
                                label: 'Pending',
                                value: '$pendingCount',
                                color: const Color(0xFFFB8C10),
                                theme: theme,
                              ),
                              const Spacer(),
                              if (searchTerm.isNotEmpty)
                                Text(
                                  '${filteredVoters.length} found',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF60CBEE),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Voter Items
                        Expanded(
                          child: filteredVoters.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 56.0,
                                          height: 56.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0x1960CBEE),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.search_off_rounded,
                                            color: Color(0xFF60CBEE),
                                            size: 28.0,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          searchTerm.isEmpty
                                              ? 'No voters in this stream'
                                              : 'No voters match "$searchTerm"',
                                          style: GoogleFonts.readexPro(
                                            color: theme.primaryText,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 6.0),
                                        Text(
                                          searchTerm.isEmpty
                                              ? 'Voter records allocated to this stream will appear here.'
                                              : 'Check the spelling of the name or national ID and try again.',
                                          style: GoogleFonts.inter(
                                            color: theme.secondaryText,
                                            fontSize: 13.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (searchTerm.isNotEmpty) ...[
                                          const SizedBox(height: 14.0),
                                          TextButton.icon(
                                            onPressed: () {
                                              _model.textController?.clear();
                                              safeSetState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.clear_rounded,
                                              size: 16.0,
                                              color: Color(0xFF60CBEE),
                                            ),
                                            label: Text(
                                              'Clear Search',
                                              style: GoogleFonts.inter(
                                                color: const Color(0xFF60CBEE),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                )
                              : RefreshIndicator(
                                  color: const Color(0xFF60CBEE),
                                  backgroundColor: theme.secondaryBackground,
                                  onRefresh: () async {
                                    safeSetState(() =>
                                        _model.requestCompleter = null);
                                    await _model.waitForRequestCompleted();
                                  },
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    itemCount: filteredVoters.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10.0),
                                    itemBuilder: (context, index) {
                                      final voter = filteredVoters[index];
                                      final hasVoted = voter.hasVoted == true;
                                      final isUpdating =
                                          _updatingVoterIds.contains(voter.id);

                                      // Initials for avatar
                                      final names = voter.fullName
                                          .trim()
                                          .split(' ')
                                          .where((n) => n.isNotEmpty)
                                          .toList();
                                      final initials = names.isNotEmpty
                                          ? (names.length >= 2
                                              ? '${names[0][0]}${names[1][0]}'
                                              : names[0].substring(
                                                  0,
                                                  names[0].length >= 2
                                                      ? 2
                                                      : 1))
                                          : 'V';

                                      return Container(
                                        padding: const EdgeInsets.all(14.0),
                                        decoration: BoxDecoration(
                                          color: theme.secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          border: Border.all(
                                            color: hasVoted
                                                ? const Color(0x3302CA79)
                                                : theme.alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Avatar Initials
                                            Container(
                                              width: 44.0,
                                              height: 44.0,
                                              decoration: BoxDecoration(
                                                color: hasVoted
                                                    ? const Color(0x1902CA79)
                                                    : const Color(0x1960CBEE),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: hasVoted
                                                      ? const Color(0x4D02CA79)
                                                      : const Color(0x3360CBEE),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  initials.toUpperCase(),
                                                  style: GoogleFonts.readexPro(
                                                    color: hasVoted
                                                        ? const Color(
                                                            0xFF02CA79)
                                                        : const Color(
                                                            0xFF60CBEE),
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(width: 12.0),

                                            // Voter details
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    voter.fullName,
                                                    style: GoogleFonts.readexPro(
                                                      color: theme.primaryText,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4.0),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 6.0,
                                                          vertical: 2.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: theme
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          border: Border.all(
                                                            color: theme
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'ID: ${voter.nationalId}',
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: theme
                                                                .secondaryText,
                                                            fontSize: 11.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      if (voter.phoneNumber !=
                                                              null &&
                                                          voter.phoneNumber!
                                                              .isNotEmpty) ...[
                                                        const SizedBox(
                                                            width: 6.0),
                                                        Text(
                                                          voter.phoneNumber!,
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: theme
                                                                .secondaryText,
                                                            fontSize: 11.5,
                                                          ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 8.0),

                                            // Status and Action
                                            if (hasVoted) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0x1902CA79),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0x4D02CA79),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .check_circle_rounded,
                                                          color: Color(
                                                              0xFF02CA79),
                                                          size: 13.0,
                                                        ),
                                                        const SizedBox(
                                                            width: 4.0),
                                                        Text(
                                                          'VOTED',
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: const Color(
                                                                0xFF02CA79),
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (voter.votedAt != null) ...[
                                                    const SizedBox(height: 4.0),
                                                    Text(
                                                      dateTimeFormat(
                                                        'h:mm a',
                                                        voter.votedAt,
                                                      ),
                                                      style: GoogleFonts.inter(
                                                        color:
                                                            theme.secondaryText,
                                                        fontSize: 11.0,
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ] else ...[
                                              SizedBox(
                                                height: 34.0,
                                                child: ElevatedButton.icon(
                                                  onPressed: isUpdating
                                                      ? null
                                                      : () async {
                                                          setState(() {
                                                            _updatingVoterIds
                                                                .add(voter.id!);
                                                          });
                                                          try {
                                                            await VotersTable()
                                                                .update(
                                                              data: {
                                                                'has_voted':
                                                                    true,
                                                                'marked_by_agent_id':
                                                                    currentUserUid,
                                                                'voted_at':
                                                                    supaSerialize<
                                                                        DateTime>(
                                                                  getCurrentTimestamp,
                                                                ),
                                                              },
                                                              matchingRows:
                                                                  (rows) =>
                                                                      rows.eqOrNull(
                                                                'id',
                                                                voter.id,
                                                              ),
                                                            );
                                                            if (context.mounted) {
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    '${voter.fullName} marked as voted.',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  duration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              3000),
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFF02CA79),
                                                                ),
                                                              );
                                                            }
                                                          } catch (e) {
                                                            if (context.mounted) {
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Error marking voter: $e'),
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFFE65454),
                                                                ),
                                                              );
                                                            }
                                                          } finally {
                                                            if (mounted) {
                                                              setState(() {
                                                                _updatingVoterIds
                                                                    .remove(voter.id);
                                                                _model.requestCompleter =
                                                                    null;
                                                              });
                                                              await _model
                                                                  .waitForRequestCompleted();
                                                            }
                                                          }
                                                        },
                                                  icon: isUpdating
                                                      ? const SizedBox(
                                                          width: 14.0,
                                                          height: 14.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Color(
                                                                0xFF12151C),
                                                            strokeWidth: 2.0,
                                                          ),
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .how_to_reg_rounded,
                                                          color: Color(
                                                              0xFF12151C),
                                                          size: 16.0,
                                                        ),
                                                  label: Text(
                                                    'Mark Voted',
                                                    style: GoogleFonts.inter(
                                                      color: const Color(
                                                          0xFF12151C),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF60CBEE),
                                                    elevation: 0.0,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12.0,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
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
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required String label,
    required String value,
    required Color color,
    required FlutterFlowTheme theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.inter(
              color: theme.secondaryText,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.readexPro(
              color: color,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
