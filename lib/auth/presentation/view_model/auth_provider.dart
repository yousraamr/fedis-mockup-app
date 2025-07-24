import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fedis_mockup_demo/auth/domain/usecases/login_usecase.dart';
import 'package:fedis_mockup_demo/auth/domain/usecases/register_usecase.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthProvider({required this.loginUseCase, required this.registerUseCase});

  bool isLoading = false;

  Future<Map<String, dynamic>?> login(BuildContext context, String email, String password) async {
    _setLoading(true);
    try {
      final data = await loginUseCase.execute(email, password);
      print("🔍 Login API Response: $data");

      if (data['accessToken'] != null) {
        print("✅ Login Successful: ${data['accessToken']} for ${data['user']}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['accessToken']);
        await prefs.setString('userName', data['user']['name'] ?? '');
        await prefs.setString('email', data['user']['email'] ?? '');
        return data;
      } else {
        print("❌ Login Failed - Missing token");
        return null;
      }
    } catch (e) {
      _setLoading(false);
      print("❌ Login Error: $e");
      return null;
    }
  }



  Future<Map<String, dynamic>?> register(
      BuildContext context, String name, String email, String password) async {
    _setLoading(true);
    try {
      final result = await registerUseCase.execute(name, email, password);
      _setLoading(false);

      // If we have a token, registration was successful
      if (result['accessToken'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Registration Successful')),
        );
        return result;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Registration Failed')),
        );
        return null;
      }
    } catch (e) {
      _setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      return null;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
