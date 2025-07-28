import 'package:fedis_mockup_demo/translations/login_strings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/storage/session_manager.dart';
import '../../../core/utils/error_mapper.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/snackbar.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  });

  bool isLoading = false;
  String? userName;
  String? email;

  /// ✅ LOGIN
  Future<bool> login(BuildContext context, String email, String password) async {
    _setLoading(true);
    bool isSuccess = false;

    final result = await loginUseCase.execute(email, password);

    await result.fold<Future<void>>(
          (failure) async {
        Logger.error("Login Failed: ${failure.message}");
        if (context.mounted) {
          final localizedMessage = mapApiErrorToKey(failure.message).tr();
          showErrorSnackBar(context, localizedMessage);
        }
      },
          (data) async {
        Logger.success("✅ Login successful");
        Logger.info("Login API Response: $data");

        final token = data['accessToken'];
        final user = data['user'];
        final apiMessage = data['message'] ?? "Login Successful";

        String? userName;
        if (user != null) {
          if (user['name'] != null) {
            userName = user['name'];
          } else if (user['firstName'] != null && user['lastName'] != null) {
            userName = "${user['firstName']} ${user['lastName']}";
          }
        }
        final userEmail = user?['email'];

        if (token == null || userName == null || userEmail == null) {
          Logger.error("Invalid response: Missing token or user details");
          if (context.mounted) showErrorSnackBar(context, "invalid_server_response".tr());
          return;
        }

        await SessionManager.saveSession(token: token, userName: userName, email: userEmail);

        this.userName = userName;
        this.email = userEmail;
        notifyListeners();

        /// ✅ Show user details in console
        Logger.info("User Details after login: Name=$userName, Email=$userEmail, Token=$token");

        if (context.mounted) {
          showSuccessSnackBar(context, loginSuccess.tr()); // ✅ Direct API message for success
        }
        isSuccess = true;
      },
    );

    _setLoading(false);
    return isSuccess;
  }

  /// ✅ REGISTER
  Future<bool> register(BuildContext context, String name, String email, String password) async {
    _setLoading(true);
    bool isSuccess = false;

    final result = await registerUseCase.execute(name, email, password);
    result.fold(
          (failure) {
        Logger.error("Registration Failed: ${failure.message}");
        if (context.mounted) {
          final localizedMessage = mapApiErrorToKey(failure.message).tr();
          showErrorSnackBar(context, localizedMessage);
        }
      },
          (data) {
        Logger.success("✅ Registration Successful");
        final apiMessage = data['message'] ?? "Registration Successful";

        /// ✅ Log user details in console
        Logger.info("New User Registered: Name=$name, Email=$email");

        if (context.mounted) {
          showSuccessSnackBar(context, apiMessage); // ✅ Direct API message for success
        }
        isSuccess = true;
      },
    );
    _setLoading(false);
    return isSuccess;
  }

  /// ✅ LOGOUT
  Future<void> logout(BuildContext context) async {
    try {
      Logger.info("Logging out user: $userName ($email)");

      await logoutUseCase.execute();
      userName = null;
      email = null;
      notifyListeners();

      await context.setLocale(const Locale('en'));

      Logger.success("✅ User logged out successfully");
      showSuccessSnackBar(context, "logged_out_successfully".tr());
    } catch (e) {
      Logger.error("Logout Error: $e");
      showErrorSnackBar(context, "logout_failed".tr());
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}