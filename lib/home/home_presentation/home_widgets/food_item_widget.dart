import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2,
        color: lightColorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: lightColorScheme.onPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/BK.jpeg",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Burger King", style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    children: const [
                      Icon(Icons.star_rate, color: Colors.yellowAccent, size: 16),
                      SizedBox(width: 4),
                      Text("5.0"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer, color: lightColorScheme.outlineVariant, size: 16),
                      Text("20-25 mins  • 7 km"),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
