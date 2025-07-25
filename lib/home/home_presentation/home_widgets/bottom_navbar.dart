import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../home_view_model/nav_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavProvider>(
      builder: (context, navProvider, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.outlineVariant,
          currentIndex: navProvider.currentIndex,
          onTap: navProvider.changeTab,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined), label: 'home'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: 'cart'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_border),
                label: 'favorites'.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline), label: 'profile'.tr()),
          ],
        );
      },
    );
  }
}
