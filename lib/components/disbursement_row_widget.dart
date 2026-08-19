import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'disbursement_row_model.dart';
export 'disbursement_row_model.dart';

class DisbursementRowWidget extends StatefulWidget {
  const DisbursementRowWidget({
    super.key,
    String? name,
    String? phone,
    String? cat,
    String? amt,
    Color? statusColor,
    String? status,
    required this.id,
    this.onStatusChanged,
  })  : name = name ?? 'Agent',
        phone = phone ?? '+254 700 000 000',
        cat = cat ?? 'Stipend',
        amt = amt ?? '0',
        statusColor = statusColor ?? const Color(0x00000000),
        status = status ?? 'PENDING';

  final String name;
  final String phone;
  final String cat;
  final String amt;
  final Color statusColor;
  final String status;
  final String? id;
  final VoidCallback? onStatusChanged;

  @override
  State<DisbursementRowWidget> createState() => _DisbursementRowWidgetState();
}

class _DisbursementRowWidgetState extends State<DisbursementRowWidget> {
  late DisbursementRowModel _model;
  bool _isProcessing = false;
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisbursementRowModel());
    _currentStatus = widget.status.toUpperCase();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void didUpdateWidget(covariant DisbursementRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _currentStatus = widget.status.toUpperCase();
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isPaidOrProcessing = _currentStatus == 'PROCESSING' ||
        _currentStatus == 'PAID' ||
        _currentStatus == 'COMPLETED' ||
        _currentStatus == 'SUCCESS';
    final isPending = _currentStatus == 'PENDING';
    final isFailed = _currentStatus == 'FAILED';

    Color buttonColor;
    String buttonText;
    Color buttonTextColor;

    if (isPaidOrProcessing) {
      buttonColor = const Color(0xFF02CA79);
      buttonText = 'Paid';
      buttonTextColor = Colors.white;
    } else if (isPending) {
      buttonColor = const Color(0xFFFFD939);
      buttonText = 'Pay';
      buttonTextColor = const Color(0xFF151820);
    } else if (isFailed) {
      buttonColor = const Color(0xFFE65454);
      buttonText = 'Retry';
      buttonTextColor = Colors.white;
    } else {
      buttonColor = const Color(0xFFFFD939);
      buttonText = 'Pay';
      buttonTextColor = const Color(0xFF151820);
    }

    final initial =
        widget.name.isNotEmpty ? widget.name.trim()[0].toUpperCase() : 'A';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(
          bottom: BorderSide(
            color: theme.alternate,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Avatar Initial
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: isPaidOrProcessing
                  ? const Color(0x1902CA79)
                  : theme.accent1,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: isPaidOrProcessing
                    ? const Color(0x4D02CA79)
                    : theme.primary.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.readexPro(
                color: isPaidOrProcessing
                    ? const Color(0xFF02CA79)
                    : theme.primary,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12.0),

          // Recipient Name & Phone
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.readexPro(
                    color: theme.primaryText,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  widget.phone,
                  style: GoogleFonts.inter(
                    color: theme.secondaryText,
                    fontSize: 12.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Category Badge
          Expanded(
            flex: 2,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: theme.alternate,
                  width: 1.0,
                ),
              ),
              child: Text(
                widget.cat,
                style: GoogleFonts.inter(
                  color: theme.secondaryText,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8.0),

          // Amount
          Expanded(
            flex: 2,
            child: Text(
              'KES ${widget.amt}',
              style: GoogleFonts.readexPro(
                color: theme.primaryText,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12.0),

          // Conditional Pay / Paid Button
          SizedBox(
            height: 34.0,
            child: ElevatedButton(
              onPressed: (_isProcessing || isPaidOrProcessing)
                  ? null
                  : () async {
                      if (widget.id == null) return;
                      setState(() {
                        _isProcessing = true;
                      });

                      try {
                        final success =
                            await actions.disburseMpesa(widget.id!);

                        if (success) {
                          await DisbursementsTable().update(
                            data: {
                              'status': 'PROCESSING',
                              'updated_at': DateTime.now().toIso8601String(),
                            },
                            matchingRows: (q) => q.eq('id', widget.id!),
                          );
                          setState(() {
                            _currentStatus = 'PROCESSING';
                          });
                        }

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Payment queued to Safaricom Daraja for ${widget.name}'
                                    : 'Failed to dispatch M-Pesa payment.',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: success
                                  ? const Color(0xFF02CA79)
                                  : theme.error,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }

                        widget.onStatusChanged?.call();
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error processing payout: $e',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                              backgroundColor: theme.error,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isProcessing = false;
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                disabledBackgroundColor: buttonColor,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black87),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isPaidOrProcessing) ...[
                          const Icon(
                            Icons.check_rounded,
                            size: 14.0,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4.0),
                        ],
                        Text(
                          buttonText,
                          style: GoogleFonts.inter(
                            color: buttonTextColor,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

