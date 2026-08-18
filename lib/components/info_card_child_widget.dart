import '/components/data_point_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'info_card_child_model.dart';
export 'info_card_child_model.dart';

class InfoCardChildWidget extends StatefulWidget {
  const InfoCardChildWidget({super.key});

  @override
  State<InfoCardChildWidget> createState() => _InfoCardChildWidgetState();
}

class _InfoCardChildWidgetState extends State<InfoCardChildWidget> {
  late InfoCardChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoCardChildModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        wrapWithModel(
          model: _model.dataPointModel1,
          updateCallback: () => safeSetState(() {}),
          child: DataPointWidget(
            label: 'OFFICIAL NAME',
            value: 'Johnathan Smith',
          ),
        ),
        wrapWithModel(
          model: _model.dataPointModel2,
          updateCallback: () => safeSetState(() {}),
          child: DataPointWidget(
            label: 'CLEARANCE LEVEL',
            value: 'Level 4 (Institutional)',
          ),
        ),
        wrapWithModel(
          model: _model.dataPointModel3,
          updateCallback: () => safeSetState(() {}),
          child: DataPointWidget(
            label: 'EXPIRY DATE',
            value: '12 DEC 2025',
          ),
        ),
      ].divide(SizedBox(height: 16.0)),
    );
  }
}
