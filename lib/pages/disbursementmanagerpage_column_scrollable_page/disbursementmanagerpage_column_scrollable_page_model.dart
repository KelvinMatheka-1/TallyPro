import '/components/table_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'disbursementmanagerpage_column_scrollable_page_widget.dart'
    show DisbursementmanagerpageColumnScrollablePageWidget;
import 'package:flutter/material.dart';

class DisbursementmanagerpageColumnScrollablePageModel extends FlutterFlowModel<
    DisbursementmanagerpageColumnScrollablePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TableHeader.
  late TableHeaderModel tableHeaderModel1;
  // Model for TableHeader.
  late TableHeaderModel tableHeaderModel2;
  // Model for TableHeader.
  late TableHeaderModel tableHeaderModel3;
  // Model for TableHeader.
  late TableHeaderModel tableHeaderModel4;
  // Model for TableHeader.
  late TableHeaderModel tableHeaderModel5;

  @override
  void initState(BuildContext context) {
    tableHeaderModel1 = createModel(context, () => TableHeaderModel());
    tableHeaderModel2 = createModel(context, () => TableHeaderModel());
    tableHeaderModel3 = createModel(context, () => TableHeaderModel());
    tableHeaderModel4 = createModel(context, () => TableHeaderModel());
    tableHeaderModel5 = createModel(context, () => TableHeaderModel());
  }

  @override
  void dispose() {
    tableHeaderModel1.dispose();
    tableHeaderModel2.dispose();
    tableHeaderModel3.dispose();
    tableHeaderModel4.dispose();
    tableHeaderModel5.dispose();
  }
}
