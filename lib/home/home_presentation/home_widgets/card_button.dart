import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(
          "Claim Voucher",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: lightColorScheme.shadow,
          ),
        ),
      ),
    );
  }
}
