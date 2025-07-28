import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis_mockup_demo/home/home_data/models/form_field_data.dart';

class DynamicFormPage extends StatelessWidget {
  final List<FormFieldData> formData;

  const DynamicFormPage({Key? key, required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('form_title'.tr())),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: formData.length,
        itemBuilder: (context, index) {
          final field = formData[index];
          return _buildField(context, field);
        },
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
                Text(field.stepTitle!.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              if (field.label != null) Text(field.label!.tr()),
            ],
          ),
        );

      case 'text':
      case 'number':
      case 'email':
      case 'password':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
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
          ),
        );

      case 'button':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton.icon(
            onPressed: () {
              // Add submit action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('form_submitted'.tr())),
              );
            },
            icon: field.arrow == true
                ? const Icon(Icons.arrow_forward)
                : const SizedBox(),
            label: Text(field.name?.tr() ?? 'Submit'.tr()),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
