import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/signup_page.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:fedis_mockup_demo/auth/presentation/widgets/custom_scaffold.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/home_screen.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/utils/snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('welcome_back'.tr(),
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(color: lightColorScheme.primary)),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: emailController,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'please_enter_email'.tr() : null,
                        decoration: _inputDecoration('email'.tr(), 'enter_email'.tr()),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'please_enter_password'.tr() : null,
                        decoration: _inputDecoration('password'.tr(), 'enter_password'.tr()),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (val) => setState(() => rememberPassword = val!),
                                activeColor: lightColorScheme.primary,
                              ),
                              Text('remember_me'.tr(),
                                  style: TextStyle(color: lightColorScheme.onBackground)),
                            ],
                          ),
                          GestureDetector(
                            child: Text('forget_password'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: lightColorScheme.primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (!rememberPassword) {
                                showErrorSnackBar(context, 'please_agree'.tr());
                                return;
                              }
                              final success = await authProvider.login(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                              if (success != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                                );
                              }
                            }
                          },
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Text('sign_in'.tr()),
                        ),
                      ),
                      const SizedBox(height: 25),
                      _orDivider(context, 'sign_in_with'.tr()),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('dont_have_account'.tr(),
                              style: TextStyle(color: lightColorScheme.onBackground)),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignUpScreen()),
                            ),
                            child: Text('sign_up'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: lightColorScheme.primary)),
                          ),
                        ],
                      ),
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

  Widget _orDivider(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(thickness: 0.7, color: lightColorScheme.outlineVariant.withOpacity(0.5)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: TextStyle(color: lightColorScheme.onBackground)),
        ),
        Expanded(
          child: Divider(thickness: 0.7, color: lightColorScheme.outlineVariant.withOpacity(0.5)),
        ),
      ],
    );
  }
}
