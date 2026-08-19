import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/candidate_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'back_results_tally_page_model.dart';
export 'back_results_tally_page_model.dart';

class BackResultsTallyPageWidget extends StatefulWidget {
  const BackResultsTallyPageWidget({super.key});

  static String routeName = 'BackResultsTallyPage';
  static String routePath = '/backResultsTallyPage';

  @override
  State<BackResultsTallyPageWidget> createState() =>
      _BackResultsTallyPageWidgetState();
}

class _BackResultsTallyPageWidgetState
    extends State<BackResultsTallyPageWidget> {
  late BackResultsTallyPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isTransmitting = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackResultsTallyPageModel());
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

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

        final agentDashboardRows = snapshot.data!;
        final agentRow =
            agentDashboardRows.isNotEmpty ? agentDashboardRows.first : null;

        final centerName = agentRow?.centerName ?? 'Athi River Primary School';
        final streamName = agentRow?.streamName ?? 'Stream 1 (A - L)';
        final streamId = agentRow?.streamId;

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
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: theme.primaryText,
                  size: 22.0,
                ),
                onPressed: () => context.pop(),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Results & Form 34A',
                    style: GoogleFonts.readexPro(
                      color: theme.primaryText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$streamName • $centerName',
                    style: GoogleFonts.inter(
                      color: theme.secondaryText,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              actions: [
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
                    // Section 1: Candidate Ballot Counts
                    Text(
                      'Candidate Ballot Counts',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Enter counts for each candidate and save individually.',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                        fontSize: 12.5,
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    FutureBuilder<List<CandidatesRow>>(
                      future: CandidatesTable().queryRows(
                        queryFn: (q) =>
                            q.order('ballot_order', ascending: true),
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
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: candidateList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10.0),
                          itemBuilder: (context, index) {
                            final candidate = candidateList[index];
                            return CandidateCardWidget(
                              key: Key(
                                  'CandCard_${index}_${candidateList.length}'),
                              initials: candidate.photoUrl,
                              name: candidate.name,
                              party: candidate.partyName,
                              votes: '0',
                              candidatIid: candidate.id!,
                              streamId: streamId,
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 28.0),

                    // Section 2: Ballot Audit Stats
                    Text(
                      'Ballot Audit & Discrepancies',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Record valid, rejected, and disputed ballots for cross-verification.',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                        fontSize: 12.5,
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: theme.alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Total Valid Votes
                          _buildAuditInputRow(
                            label: 'Total Valid Votes',
                            controller: _model.textController1!,
                            focusNode: _model.textFieldFocusNode1!,
                            icon: Icons.check_circle_outline_rounded,
                            iconColor: const Color(0xFF02CA79),
                            theme: theme,
                          ),
                          const SizedBox(height: 12.0),
                          Divider(color: theme.alternate, height: 1.0),
                          const SizedBox(height: 12.0),

                          // Total Rejected Votes
                          _buildAuditInputRow(
                            label: 'Rejected / Spoilt Ballots',
                            controller: _model.textController2!,
                            focusNode: _model.textFieldFocusNode2!,
                            icon: Icons.highlight_off_rounded,
                            iconColor: const Color(0xFFE65454),
                            theme: theme,
                          ),
                          const SizedBox(height: 12.0),
                          Divider(color: theme.alternate, height: 1.0),
                          const SizedBox(height: 12.0),

                          // Disputed Votes
                          _buildAuditInputRow(
                            label: 'Disputed Ballots',
                            controller: _model.textController3!,
                            focusNode: _model.textFieldFocusNode3!,
                            icon: Icons.help_outline_rounded,
                            iconColor: const Color(0xFFFB8C10),
                            theme: theme,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28.0),

                    // Section 3: Form 34A Statutory Document
                    Text(
                      'Form 34A Statutory Document',
                      style: GoogleFonts.readexPro(
                        color: theme.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Take a clear, uncropped photo of the signed official Form 34A.',
                      style: GoogleFonts.inter(
                        color: theme.secondaryText,
                        fontSize: 12.5,
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: _model.uploadedFileUrl_uploadedFormUrl.isNotEmpty
                              ? const Color(0x3302CA79)
                              : theme.alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (_model.uploadedFileUrl_uploadedFormUrl.isNotEmpty) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.network(
                                _model.uploadedFileUrl_uploadedFormUrl,
                                height: 200.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF02CA79),
                                  size: 16.0,
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Form 34A Uploaded',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF02CA79),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                          ],

                          // Upload Button
                          InkWell(
                            onTap: () async {
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                storageFolderPath: '',
                                maxWidth: 1920.00,
                                maxHeight: 1920.00,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) =>
                                      validateFileFormat(
                                          m.storagePath, context))) {
                                safeSetState(() => _model
                                    .isDataUploading_uploadedFormUrl = true);
                                var selectedUploadedFiles =
                                    <FFUploadedFile>[];
                                var downloadUrls = <String>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name:
                                                m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename:
                                                m.originalFilename,
                                          ))
                                      .toList();

                                  downloadUrls =
                                      await uploadSupabaseStorageFiles(
                                    bucketName: 'form-34a-images',
                                    selectedFiles: selectedMedia,
                                  );
                                } finally {
                                  _model.isDataUploading_uploadedFormUrl =
                                      false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadedFormUrl =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadedFormUrl =
                                        downloadUrls.first;
                                  });
                                }
                              }
                            },
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(
                                  color: theme.alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _model.uploadedFileUrl_uploadedFormUrl
                                            .isNotEmpty
                                        ? Icons.replay_rounded
                                        : Icons.add_a_photo_rounded,
                                    color: theme.primary,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    _model.uploadedFileUrl_uploadedFormUrl
                                            .isNotEmpty
                                        ? 'Retake / Change Photo'
                                        : 'Take / Upload Form 34A Photo',
                                    style: GoogleFonts.inter(
                                      color: theme.primary,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32.0),

                    // Transmit & Lock Stream Results Button
                    SizedBox(
                      width: double.infinity,
                      height: 52.0,
                      child: ElevatedButton.icon(
                        onPressed: _isTransmitting
                            ? null
                            : () async {
                                final validVotes = int.tryParse(
                                    _model.textController1?.text.trim() ?? '');
                                final rejectedVotes = int.tryParse(
                                    _model.textController2?.text.trim() ?? '');
                                final disputedVotes = int.tryParse(
                                    _model.textController3?.text.trim() ?? '');

                                if (validVotes == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter the Total Valid Votes count.'),
                                      backgroundColor: Color(0xFFFB8C10),
                                    ),
                                  );
                                  return;
                                }

                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogCtx) => AlertDialog(
                                    backgroundColor:
                                        theme.secondaryBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0),
                                    ),
                                    title: Text(
                                      'Lock & Transmit Stream Results?',
                                      style: GoogleFonts.readexPro(
                                        color: theme.primaryText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'This action will finalize the tally for this stream and transmit the statutory Form 34A to the War Room dashboard.',
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
                                          style: TextStyle(
                                              color: theme.secondaryText),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogCtx, true),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF02CA79),
                                          elevation: 0.0,
                                        ),
                                        child: const Text(
                                          'Transmit & Lock',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm != true) return;

                                setState(() {
                                  _isTransmitting = true;
                                });

                                try {
                                  await StatutoryFormsTable().insert({
                                    'stream_id': streamId,
                                    'agent_id': currentUserUid,
                                    'form_type': 'FORM_34A',
                                    'image_url': _model
                                        .uploadedFileUrl_uploadedFormUrl,
                                    'total_valid_votes': validVotes,
                                    'rejected_votes': rejectedVotes ?? 0,
                                    'disputed_votes': disputedVotes ?? 0,
                                    'is_verified': false,
                                    'submitted_at': supaSerialize<DateTime>(
                                        getCurrentTimestamp),
                                  });

                                  // Update stream status to LOCKED_SUBMITTED
                                  if (streamId != null) {
                                    await PollingStreamsTable().update(
                                      data: {'status': 'LOCKED_SUBMITTED'},
                                      matchingRows: (q) =>
                                          q.eq('id', streamId),
                                    );
                                  }

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Form 34A and stream results successfully locked and transmitted to War Room!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        duration: Duration(seconds: 4),
                                        backgroundColor: Color(0xFF02CA79),
                                      ),
                                    );

                                    context.pushNamed(
                                        AgentDashWidget.routeName);
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Error transmitting results: $e'),
                                        backgroundColor:
                                            const Color(0xFFE65454),
                                      ),
                                    );
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isTransmitting = false;
                                    });
                                  }
                                }
                              },
                        icon: _isTransmitting
                            ? SizedBox(
                                width: 18.0,
                                height: 18.0,
                                child: CircularProgressIndicator(
                                  color: theme.primaryBackground,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Icon(
                                Icons.lock_outline_rounded,
                                color: theme.primaryBackground,
                                size: 18.0,
                              ),
                        label: Text(
                          _isTransmitting
                              ? 'Transmitting...'
                              : 'Transmit & Lock Stream Results',
                          style: GoogleFonts.readexPro(
                            color: theme.primaryBackground,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAuditInputRow({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required Color iconColor,
    required FlutterFlowTheme theme,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 18.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: theme.primaryText,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 110.0,
          height: 38.0,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            cursorColor: theme.primary,
            style: GoogleFonts.readexPro(
              color: theme.primaryText,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              isDense: true,
              hintText: '0',
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

