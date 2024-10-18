import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

///  ⚠️⚠️⚠️⚠️⚠️⚠️⚠️ITS USE ONLY FOR DEBUGGING PURPOSES  ⚠️⚠️⚠️⚠️⚠️⚠️⚠️
nkDevLog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  log(message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace);
}

/// [print] for debugging purposes
nkDevPrint(message) {
  if (kDebugMode) {
    print(message);
  }
}

extension DebugLog on Object {
  void get $PRINT {
    log("LOG DATA ERRROR EROOOR EROOOR", error: this);
  }
}
