import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/core/utils/snackbar.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/auth/presentation/widgets/custom_scaffold.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import '../../../core/utils/service_loader.dart';
import 'package:fedis_mockup_demo/home/home_data/models/form_field_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool agreePersonalData = false;
  bool _obscurePassword = true;

  List<FormFieldData> _formFields = [];
  bool _isLoadingForm = true;

  @override
  void initState() {
    super.initState();
    _loadFormFields();
  }

  void _loadFormFields() async {
    final service = await loadSignupService();
    setState(() {
      _formFields = service?.formData ?? [];
      _isLoadingForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return CustomScaffold(
      child: _isLoadingForm
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                      Text(
                        'get_started'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: lightColorScheme.primary),
                      ),
                      const SizedBox(height: 40),

                      // Render all fields from JSON
                      ..._formFields.map((field) =>
                          _buildField(field, context, authProvider)),

                      const SizedBox(height: 30),
                      _orDivider(context, 'sign_up_with'.tr()),
                      const SizedBox(height: 30),

                      // Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already_have_account'.tr(),
                            style: TextStyle(
                                color: lightColorScheme.onBackground),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignInScreen()),
                              );
                            },
                            child: Text(
                              'sign_in'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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

  Widget _buildField(
      FormFieldData field, BuildContext context, AuthProvider authProvider) {
    final id = field.id;

    switch (field.type) {
      case 'description':
        return Column(
          children: [
            Text(
              field.label?.tr() ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
          ],
        );

      case 'text':
      case 'email':
      case 'password':
        _controllers.putIfAbsent(id!, () => TextEditingController());
        return Column(
          children: [
            TextFormField(
              controller: _controllers[id],
              obscureText: field.type == 'password' ? _obscurePassword : false,
              validator: (value) {
                if (field.required == true &&
                    (value == null || value.isEmpty)) {
                  return field.validationMessage?.tr();
                }
                if (field.regex != null &&
                    value != null &&
                    !RegExp(field.regex!).hasMatch(value)) {
                  return field.validationMessage?.tr();
                }
                if (field.minLength != null &&
                    (value?.length ?? 0) < field.minLength!) {
                  return field.validationMessage?.tr();
                }
                return null;
              },
              decoration: _inputDecoration(
                field.label?.tr() ?? '',
                'enter_${field.name}'.tr(),
              ).copyWith(
                suffixIcon: field.type == 'password'
                    ? IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        );

      case 'button':
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: agreePersonalData,
                  onChanged: (val) =>
                      setState(() => agreePersonalData = val ?? false),
                  activeColor: lightColorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    '${'agree_processing'.tr()} ${'personal_data'.tr()}',
                    style: TextStyle(color: lightColorScheme.onBackground),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    _handleButtonAction(field, context, authProvider),
                child: authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : Text(field.label?.tr() ?? 'submit'),
              ),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  void _handleButtonAction(FormFieldData field, BuildContext context,
      AuthProvider authProvider) async {
    if (field.action == 'submit') {
      if (_formSignupKey.currentState!.validate()) {
        if (!agreePersonalData) {
          showErrorSnackBar(context, 'please_agree'.tr());
          return;
        }

        final data = <String, String>{};
        _controllers.forEach((key, controller) {
          data[key] = controller.text.trim();
        });

        try {
          final response = await Dio().post(
            'https://cartverse-data.onrender.com/register',
            data: data,
          );
          showSuccessSnackBar(context, 'registration_success'.tr());
          print('Response: ${response.data}');
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          }
        } catch (e) {
          showErrorSnackBar(context, '${'error_server'.tr()}: ${e.toString()}');
        }
      } else {
        showErrorSnackBar(context, 'please_fix_errors'.tr());
      }
    }
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
            child: Divider(
                thickness: 0.7,
                color: lightColorScheme.outlineVariant.withOpacity(0.5))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text,
              style: TextStyle(color: lightColorScheme.onBackground)),
        ),
        Expanded(
            child: Divider(
                thickness: 0.7,
                color: lightColorScheme.outlineVariant.withOpacity(0.5))),
      ],
    );
  }
}
