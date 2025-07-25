import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: lightColorScheme.shadow,
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage("assets/images/pizza.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: lightColorScheme.shadow,
          ),
        ),
      ],
    );
  }
}
