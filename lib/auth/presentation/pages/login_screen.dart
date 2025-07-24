import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/signup_page.dart';
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
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'welcome_back'.tr(),
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_email'.tr();
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
                      TextFormField(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                               Text(
                                 'remember_me'.tr(),
                                style: TextStyle(
                                  color: lightColorScheme.onBackground,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Text(
                              'forget_password'.tr(),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formSignInKey.currentState!.validate() && rememberPassword) {
                              showSuccessSnackBar(context, 'processing_data'.tr());

                              // Navigate to HomeScreen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else if (!rememberPassword) {
                              showErrorSnackBar(context, 'please_agree'.tr());
                            }
                          },
                          child: Text('sign_in'.tr()),
                        ),

                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
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
                              'sign_in_with'.tr(),
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
                        height: 25.0,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                             'dont_have_account'.tr(),
                            style: TextStyle(
                              color: lightColorScheme.onBackground,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'sign_up'.tr(),
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