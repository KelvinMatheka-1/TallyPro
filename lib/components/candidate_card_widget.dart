import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'candidate_card_model.dart';
export 'candidate_card_model.dart';

class CandidateCardWidget extends StatefulWidget {
  const CandidateCardWidget({
    super.key,
    String? initials,
    Color? tone,
    String? name,
    String? party,
    String? votes,
    required this.candidatIid,
    this.streamId,
  })  : this.initials = initials ?? 'PM',
        this.tone = tone ?? const Color(0x00000000),
        this.name = name ?? 'Hon. Peter Musyoka Mutua',
        this.party = party ?? 'CCMB',
        this.votes = votes ?? '0';

  final String initials;
  final Color tone;
  final String name;
  final String party;
  final String votes;
  final String? candidatIid;
  final String? streamId;

  @override
  State<CandidateCardWidget> createState() => _CandidateCardWidgetState();
}

class _CandidateCardWidgetState extends State<CandidateCardWidget> {
  late CandidateCardModel _model;
  bool _isSaving = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CandidateCardModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // Compute display initials
    final initialsText = widget.initials.length <= 3
        ? widget.initials
        : (widget.name.isNotEmpty
            ? widget.name
                .split(' ')
                .where((w) => w.isNotEmpty)
                .take(2)
                .map((w) => w[0].toUpperCase())
                .join()
            : 'PM');

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: Candidate Avatar + Name + Party
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: const Color(0x1960CBEE),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0x4D60CBEE),
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initialsText,
                  style: GoogleFonts.readexPro(
                    color: const Color(0xFF60CBEE),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7.0,
                            vertical: 2.0,
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
                            widget.party,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF60CBEE),
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14.0),

          // Vote Count Input + Recorded Tally + Save Button
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: theme.primaryBackground,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: theme.alternate,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                // Input label
                Text(
                  'Votes:',
                  style: GoogleFonts.inter(
                    color: theme.secondaryText,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8.0),

                // Number Input Field
                Expanded(
                  child: SizedBox(
                    height: 40.0,
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.textController',
                        const Duration(milliseconds: 300),
                        () async {
                          _model.votesEntered =
                              int.tryParse(_model.textController?.text ?? '') ??
                                  0;
                          safeSetState(() {});
                        },
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xFF60CBEE),
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter ballot count',
                        hintStyle: GoogleFonts.inter(
                          color: theme.secondaryText,
                          fontSize: 13.0,
                        ),
                        filled: true,
                        fillColor: theme.secondaryBackground,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF60CBEE),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                // Save / Upsert Button
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving
                        ? null
                        : () async {
                            final inputVotes = int.tryParse(
                              _model.textController?.text.trim() ?? '',
                            );
                            if (inputVotes == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please enter a valid vote count number.'),
                                  backgroundColor: Color(0xFFFB8C10),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              _isSaving = true;
                            });

                            try {
                              String? targetStreamId = widget.streamId;

                              // If streamId was not directly passed, query agent_dashboard_view
                              if (targetStreamId == null ||
                                  targetStreamId.isEmpty) {
                                final rows = await AgentDashboardViewTable()
                                    .querySingleRow(
                                  queryFn: (q) => q.eqOrNull(
                                    'user_id',
                                    currentUserUid,
                                  ),
                                );
                                if (rows.isNotEmpty) {
                                  targetStreamId = rows.first.streamId;
                                }
                              }

                              if (targetStreamId == null ||
                                  widget.candidatIid == null) {
                                throw Exception(
                                    'Missing stream ID or candidate ID');
                              }

                              await actions.upsertTally(
                                targetStreamId,
                                widget.candidatIid!,
                                inputVotes,
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Recorded $inputVotes votes for ${widget.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: const Color(0xFF02CA79),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error saving tally: $e'),
                                    backgroundColor: const Color(0xFFE65454),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isSaving = false;
                                });
                              }
                            }
                          },
                    icon: _isSaving
                        ? const SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: CircularProgressIndicator(
                              color: Color(0xFF12151C),
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Icon(
                            Icons.save_rounded,
                            size: 16.0,
                            color: Color(0xFF12151C),
                          ),
                    label: Text(
                      'Save',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF12151C),
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF60CBEE),
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
