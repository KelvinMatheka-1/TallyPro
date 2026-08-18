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

Future<bool> sendSmsBlast(
  List<String> phoneNumbers,
  String message,
) async {
  try {
    final response = await SupaFlow.client.functions.invoke(
      'send-bulk-sms',
      body: {
        'phone_numbers': phoneNumbers,
        'message': message,
      },
    );

    print('Bulk SMS Edge Response: ${response.data}');
    return response.status == 200;
  } catch (e) {
    print('Bulk SMS Error: $e');
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
