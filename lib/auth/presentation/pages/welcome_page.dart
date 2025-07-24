import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/signup_page.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/auth/presentation/widgets/custom_scaffold.dart';
import 'package:fedis_mockup_demo/auth/presentation/widgets/welcome_button.dart';
import 'package:fedis_mockup_demo/translations/welcome_page_strings.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${welcomeBack.tr()}\n',
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              color: lightColorScheme.onBackground,
                            ),
                        ),
                         TextSpan(
                             text: '\n${enterDetails.tr()}',
                            style: TextStyle(
                              fontSize: 20,
                              color: lightColorScheme.primary,
                            ))
                      ],
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                   Expanded(
                    child: WelcomeButton(
                      buttonText: login.tr(),
                      onTap: const SignInScreen(),
                      color: Colors.transparent,
                      textColor: lightColorScheme.onBackground,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: signUp.tr(),
                      onTap: const SignUpScreen(),
                      color: lightColorScheme.onPrimary,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}