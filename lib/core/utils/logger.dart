class Logger {
  static void info(String message) {
    print("ℹ️ INFO: $message");
  }

  static void success(String message) {
    print("✅ SUCCESS: $message");
  }

  static void error(String message) {
    print("❌ ERROR: $message");
  }
}
