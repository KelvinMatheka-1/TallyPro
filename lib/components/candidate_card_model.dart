import '/flutter_flow/flutter_flow_util.dart';
import 'candidate_card_widget.dart' show CandidateCardWidget;
import 'package:flutter/material.dart';

class CandidateCardModel extends FlutterFlowModel<CandidateCardWidget> {
  ///  Local state fields for this component.

  int votesEntered = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
