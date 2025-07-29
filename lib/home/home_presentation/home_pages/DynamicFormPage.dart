import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis_mockup_demo/home/home_data/models/form_field_data.dart';

import '../../../auth/data/datasource/auth_datasourse.dart';
import '../../../core/utils/snackbar.dart';

class DynamicFormPage extends StatefulWidget {
  final List<FormFieldData> formData;

  const DynamicFormPage({Key? key, required this.formData}) : super(key: key);

  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var field in widget.formData) {
      if (field.type != 'button' && field.id != null) {
        _controllers[field.id!] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('form_title'.tr())),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: widget.formData.length,
          itemBuilder: (context, index) {
            final field = widget.formData[index];
            return _buildField(context, field);
          },
        ),
      ),
    );
  }

  Widget _buildField(BuildContext context, FormFieldData field) {
    switch (field.type) {
      case 'description':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (field.stepTitle != null)
                Text(field.stepTitle!.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
              if (field.label != null) Text(field.label!.tr()),
            ],
          ),
        );

      case 'text':
      case 'number':
      case 'email':
      case 'password':
        final controller = _controllers[field.id]!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            readOnly: field.readOnly ?? false,
            obscureText: field.type == 'password',
            keyboardType: field.type == 'number'
                ? TextInputType.number
                : (field.type == 'email'
                ? TextInputType.emailAddress
                : TextInputType.text),
            decoration: InputDecoration(
              labelText: field.label?.tr(),
              border: const OutlineInputBorder(),
            ),
            maxLength: field.maxLength,
            validator: (value) {
              if ((field.required ?? false) && (value == null || value.trim().isEmpty)) {
                return field.validationMessage?.tr() ?? 'please_enter_${field.id}'.tr();
              }

              if (field.minLength != null && (value?.length ?? 0) < field.minLength!) {
                return field.validationMessage?.tr() ??
                    tr('minimum_length', args: [field.minLength.toString()]);
              }

              if (field.type == 'email' && field.regex != null) {
                final regex = RegExp(field.regex!);
                if (!regex.hasMatch(value ?? '')) {
                  return field.validationMessage?.tr() ?? 'enter_valid_email'.tr();
                }
              }
              return null;
            },
          ),
        );

      case 'button':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final formData = <String, String>{};
                _controllers.forEach((key, controller) {
                  formData[key] = controller.text.trim();
                });

                try {
                  final response = await Dio().post(
                    'https://cartverse-data.onrender.com/register',
                    data: formData,
                  );

                  showSuccessSnackBar(context, 'registration_success'.tr());
                  print('Response: ${response.data}');
                } catch (e) {
                  showErrorSnackBar(context, '${'error_server'.tr()}: ${e.toString()}');
                }
              } else {
                showErrorSnackBar(context, 'please_fix_errors'.tr());
              }
            },
            child: Text(field.label?.tr() ?? 'button_label'.tr()),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
