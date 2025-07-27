import 'package:flutter/material.dart';
import '../../../core/storage/session_manager.dart';
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

  Future<bool> login(BuildContext context, String email, String password) async {
    _setLoading(true);
    bool isSuccess = false;

    final result = await loginUseCase.execute(email, password);

    await result.fold<Future<void>>(
          (failure) async {
        Logger.error("Login Failed: ${failure.message}");
        if (context.mounted) showErrorSnackBar(context, failure.message);
      },
          (data) async {
        Logger.success("Login successful");
        Logger.info("Login API Response: $data");

        final token = data['accessToken'];
        final user = data['user'];

        // ✅ Handle different formats
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
          if (context.mounted) showErrorSnackBar(context, "Invalid server response");
          return;
        }

        await SessionManager.saveSession(token: token, userName: userName, email: userEmail);

        this.userName = userName;
        this.email = userEmail;
        notifyListeners();

        Logger.info("User Details: Name=$userName, Email=$userEmail, Token=$token");
        if (context.mounted) showSuccessSnackBar(context, "Welcome $userName");
        isSuccess = true;
      },
    );

    _setLoading(false);
    return isSuccess;
  }

  Future<bool> register(BuildContext context, String name, String email, String password) async {
    _setLoading(true);
    bool isSuccess = false;

    final result = await registerUseCase.execute(name, email, password);
    result.fold(
          (failure) {
        Logger.error("Registration Failed: ${failure.message}");
        showErrorSnackBar(context, failure.message);
      },
          (data) {
        Logger.success("✅ Registration Successful");
        Logger.info("User Details: Name=$name, Email=$email");
        showSuccessSnackBar(context, "Registration Successful");
        isSuccess = true;
      },
    );
    _setLoading(false);
    return isSuccess;
  }


  Future<void> logout(BuildContext context) async {
    try {
      Logger.info("Logging out user: $userName ($email)");

      await logoutUseCase.execute();
      userName = null;
      email = null;
      notifyListeners();

      Logger.success("✅ User logged out successfully");
      showSuccessSnackBar(context, "Logged out successfully");
    } catch (e) {
      Logger.error("Logout Error: $e");
      showErrorSnackBar(context, "Logout Failed");
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}