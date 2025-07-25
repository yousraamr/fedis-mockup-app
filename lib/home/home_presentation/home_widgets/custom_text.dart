import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, this.hint});
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outlineVariant,
            offset: const Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.onPrimary,
          hintText: hint,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
