import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:fedis_mockup_demo/core/storage/cache_helper.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';

class LanguageToggleButton extends StatelessWidget {
  final Color iconColor;
  final double iconSize;

  const LanguageToggleButton({
    super.key,
    this.iconColor = Colors.black,
    this.iconSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return IconButton(
      icon: Icon(Icons.language, size: iconSize, color: iconColor),
      onPressed: () async {
        final newLocale = context.locale.languageCode == 'ar'
            ? const Locale('en')
            : const Locale('ar');

        if (authProvider.email != null) {
          await CacheHelper.saveData("userLanguage_${authProvider.email}", newLocale.languageCode);
        }

        await context.setLocale(newLocale);
      },
    );
  }
}
