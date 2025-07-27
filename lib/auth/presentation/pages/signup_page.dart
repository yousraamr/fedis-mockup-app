import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import '../widgets/custom_scaffold.dart';
import 'package:fedis_mockup_demo/core/utils/snackbar.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 10)),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: BoxDecoration(
                color: lightColorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'get_started'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Full Name Field
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_full_name'.tr();
                          }
                          return null;
                        },
                        decoration: _inputDecoration('full_name'.tr(), 'enter_full_name'.tr()),
                      ),
                      const SizedBox(height: 25.0),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_email'.tr();
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'enter_valid_email'.tr();
                          }
                          return null;
                        },
                        decoration: _inputDecoration('email'.tr(), 'enter_email'.tr()),
                      ),
                      const SizedBox(height: 25.0),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          }
                          if (value.length < 6) {
                            return 'password_min_length'.tr(); // Add this key in translations
                          }
                          return null;
                        },
                        decoration: _inputDecoration('password'.tr(), 'enter_password'.tr()).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),

                      // Agreement Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value ?? false;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          Expanded(
                            child: Text(
                              '${'agree_processing'.tr()} ${'personal_data'.tr()}',
                              style: TextStyle(color: lightColorScheme.onBackground),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignupKey.currentState!.validate() && agreePersonalData) {
                              String name = _nameController.text.trim();
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();

                              if (name.isEmpty || email.isEmpty || password.isEmpty) {
                                showErrorSnackBar(context, 'please_fill_all_fields'.tr());
                                return;
                              }

                              bool success = await authProvider.register(context, name, email, password);

                              if (success && context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                                );
                              }
                            } else if (!agreePersonalData) {
                              showErrorSnackBar(context, 'please_agree'.tr());
                            }
                          },
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Text('sign_up'.tr()),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Divider
                      _orDivider(context, 'sign_up_with'.tr()),
                      const SizedBox(height: 30.0),

                      // Already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already_have_account'.tr(),
                            style: TextStyle(color: lightColorScheme.onBackground),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const SignInScreen()),
                              );
                            },
                            child: Text(
                              'sign_in'.tr(),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Input Decoration
  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      label: Text(label),
      hintText: hint,
      hintStyle: TextStyle(color: lightColorScheme.onBackground),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: lightColorScheme.onBackground),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightColorScheme.onBackground),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Reusable Divider
  Widget _orDivider(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(thickness: 0.7, color: lightColorScheme.outlineVariant.withOpacity(0.5))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: TextStyle(color: lightColorScheme.onBackground)),
        ),
        Expanded(child: Divider(thickness: 0.7, color: lightColorScheme.outlineVariant.withOpacity(0.5))),
      ],
    );
  }
}
