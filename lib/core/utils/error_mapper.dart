import 'package:easy_localization/easy_localization.dart';

String mapApiErrorToKey(String message) {
  final normalized = message.toLowerCase();

  if (normalized.contains("email already exists")) {
    return "error_email_exists";
  }
  if (normalized.contains("registration successful")) {
    return "registration_success";
  }
  if (normalized.contains("login successful")) {
    return "login_success";
  }
  if (normalized.contains("incorrect password")) {
    return "error_incorrect_password";
  }
  if (normalized.contains("user not found")) {
    return "error_user_not_found";
  }
  if (normalized.contains("invalid email")) {
    return "error_invalid_email";
  }

  return "error_server"; // ✅ Default fallback key
}