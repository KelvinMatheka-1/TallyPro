import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'table_header_model.dart';
export 'table_header_model.dart';

class TableHeaderWidget extends StatefulWidget {
  const TableHeaderWidget({
    super.key,
    String? flexVal,
    String? label,
  })  : this.flexVal = flexVal ?? '2',
        this.label = label ?? 'AGENT / RECIPIENT';

  final String flexVal;
  final String label;

  @override
  State<TableHeaderWidget> createState() => _TableHeaderWidgetState();
}

class _TableHeaderWidgetState extends State<TableHeaderWidget> {
  late TableHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TableHeaderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      valueOrDefault<String>(
        widget.label,
        'AGENT / RECIPIENT',
      ),
      style: FlutterFlowTheme.of(context).labelSmall.override(
            font: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
            ),
            color: FlutterFlowTheme.of(context).secondaryText,
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
            lineHeight: 1.4,
          ),
    );
  }
}
