import '/components/data_point_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'info_card_child_widget.dart' show InfoCardChildWidget;
import 'package:flutter/material.dart';

class InfoCardChildModel extends FlutterFlowModel<InfoCardChildWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for DataPoint.
  late DataPointModel dataPointModel1;
  // Model for DataPoint.
  late DataPointModel dataPointModel2;
  // Model for DataPoint.
  late DataPointModel dataPointModel3;

  @override
  void initState(BuildContext context) {
    dataPointModel1 = createModel(context, () => DataPointModel());
    dataPointModel2 = createModel(context, () => DataPointModel());
    dataPointModel3 = createModel(context, () => DataPointModel());
  }

  @override
  void dispose() {
    dataPointModel1.dispose();
    dataPointModel2.dispose();
    dataPointModel3.dispose();
  }
}
