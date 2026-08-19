import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'log_row_model.dart';
export 'log_row_model.dart';

class LogRowWidget extends StatefulWidget {
  const LogRowWidget({
    super.key,
    String? phone,
    String? status,
    String? cost,
    required this.message,
  })  : phone = phone ?? '+254 700 000 000',
        status = status ?? 'DELIVERED',
        cost = cost ?? '0.80';

  final String phone;
  final String status;
  final String cost;
  final String? message;

  @override
  State<LogRowWidget> createState() => _LogRowWidgetState();
}

class _LogRowWidgetState extends State<LogRowWidget> {
  late LogRowModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LogRowModel());
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
    final isDelivered = widget.status.toUpperCase() == 'DELIVERED' ||
        widget.status.toUpperCase() == 'SENT';
    final isQueued = widget.status.toUpperCase() == 'QUEUED' ||
        widget.status.toUpperCase() == 'PENDING';

    Color statusColor;
    if (isDelivered) {
      statusColor = const Color(0xFF02CA79);
    } else if (isQueued) {
      statusColor = const Color(0xFFFFD939);
    } else {
      statusColor = const Color(0xFFE65454);
    }

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
          // SMS Icon Badge
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: isDelivered
                  ? const Color(0x1902CA79)
                  : theme.accent1,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.mark_email_read_rounded,
              color: isDelivered
                  ? const Color(0xFF02CA79)
                  : theme.primary,
              size: 18.0,
            ),
          ),
          const SizedBox(width: 12.0),

          // Phone & Message Snippet
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.phone,
                  style: GoogleFonts.readexPro(
                    color: theme.primaryText,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  widget.message ?? 'No message body',
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
          const SizedBox(width: 10.0),

          // Status Badge & Cost
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  widget.status.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                'KES ${widget.cost}',
                style: GoogleFonts.inter(
                  color: theme.secondaryText,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

