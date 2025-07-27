import 'package:flutter/foundation.dart';

class Logger {
  static void info(String message) {
    if (kDebugMode) {
      print("ℹ️ INFO: $message");
    }
  }

  static void success(String message) {
    if (kDebugMode) {
      print("✅ SUCCESS: $message");
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      print("❌ ERROR: $message");
    }
  }
}
