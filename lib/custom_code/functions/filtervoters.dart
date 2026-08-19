import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

bool? filtervoters(
  String? nationionalId,
  String? fullName,
  String? searchTerm,
) {
  // If search bar is empty, show all voters
  if (searchTerm == null || searchTerm.trim().isEmpty) {
    return true;
  }

  final query = searchTerm.toLowerCase().trim();
  final idMatch =
      nationionalId != null && nationionalId.toLowerCase().contains(query);
  final nameMatch =
      fullName != null && fullName.toLowerCase().contains(query);

  return idMatch || nameMatch;
}
