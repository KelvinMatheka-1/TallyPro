// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future upsertTally(
  String streamId,
  String candidateId,
  int votesCount,
) async {
  final supabase = SupaFlow.client;
  final currentUserId = supabase.auth.currentUser?.id;
  await supabase.from('tallies').upsert(
    {
      'stream_id': streamId,
      'candidate_id': candidateId,
      'agent_id': currentUserId,
      'votes_count': votesCount,
      'submitted_at': DateTime.now().toIso8601String(),
    },
    onConflict: 'stream_id,candidate_id',
  );
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
