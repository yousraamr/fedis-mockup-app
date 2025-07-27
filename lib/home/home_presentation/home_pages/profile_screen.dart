import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis_mockup_demo/core/utils/route_names.dart';
import 'package:fedis_mockup_demo/core/utils/snackbar.dart';
import 'package:fedis_mockup_demo/core/providers/theme_provider.dart';
import '../../../themes/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggingOut = false;

  Future<void> _showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("confirm_logout".tr()),
          content: Text("logout_question".tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("cancel".tr()),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                "logout".tr(),
                style: TextStyle(color: lightColorScheme.onPrimary),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await _logout(context);
    }
  }

  Future<void> _logout(BuildContext context) async {
    setState(() => _isLoggingOut = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.logout(context);
      if (!mounted) return;
      showSuccessSnackBar(context, "logged_out_successfully".tr());
      Navigator.pushReplacementNamed(context, loginScreen);
    } catch (e) {
      showErrorSnackBar(context, "logout_failed".tr(namedArgs: {'error': e.toString()}));
    } finally {
      if (mounted) setState(() => _isLoggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("profile".tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              authProvider.userName ?? "user".tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              authProvider.email ?? "not_available".tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 40),

            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.dark_mode, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      "dark_mode".tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ],
                );
              },
            ),
            const Spacer(),

            _isLoggingOut
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: Text("logout".tr(), style: const TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
