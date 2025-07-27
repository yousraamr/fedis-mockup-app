import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import '../widgets/custom_scaffold.dart';
import 'package:fedis_mockup_demo/translations/signup_strings.dart';
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
  bool agreePersonalData = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
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
                // get started form
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      Text(
                        'get_started'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      // full name
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_full_name'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text('full_name'.tr()),
                          hintText: 'enter_full_name'.tr(),
                          hintStyle: TextStyle(
                            color: lightColorScheme.onBackground,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text('email'.tr()),
                          hintText: 'enter_email'.tr(),
                          hintStyle: TextStyle(
                            color: lightColorScheme.onBackground,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text('password'.tr()),
                          hintText: 'enter_password'.tr(),
                          hintStyle: TextStyle(
                            color: lightColorScheme.onBackground,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: lightColorScheme.onBackground,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // i agree to the processing
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor: lightColorScheme.primary,
                          ),
                          Text(
                            'agree_processing'.tr(),
                            style: TextStyle(
                              color: lightColorScheme.onBackground,
                            ),
                          ),
                          Text(
                            'personal_data'.tr(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // signup button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignupKey.currentState!.validate() && agreePersonalData) {
                              final authProvider = Provider.of<AuthProvider>(context, listen: false);

                              String name = _nameController.text.trim();
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();

                              if (name.isEmpty || email.isEmpty || password.isEmpty) {
                                showErrorSnackBar(context, 'please_fill_all_fields'.tr());
                                return;
                              }

                              showSuccessSnackBar(context, 'processing_data'.tr());

                              bool success = await authProvider.register(context, name, email, password);

                              if (success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignInScreen()),
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
                      const SizedBox(
                        height: 30.0,
                      ),
                      // sign up divider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: lightColorScheme.outlineVariant.withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'sign_up_with'.tr(),
                              style: TextStyle(
                                color: lightColorScheme.onBackground,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: lightColorScheme.outlineVariant.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already_have_account'.tr(),
                            style: TextStyle(
                              color: lightColorScheme.onBackground,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignInScreen(),
                                ),
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
                      const SizedBox(
                        height: 20.0,
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
}