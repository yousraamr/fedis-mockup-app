import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/bottom_navbar.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_view_model/nav_provider.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';

import 'cart_screen.dart';
import 'fav_screen.dart';
import 'profile_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/custom_text.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/category_circle.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/food_item_widget.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/card_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    // Pages for each BottomNavBar item
    final List<Widget> pages = [
      const HomePageContent(),
      const CartScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: navProvider.currentIndex, // Keeps all pages alive
        children: pages,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, ${authProvider.userName ?? 'User'}!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: lightColorScheme.shadow,
            ),
          ),
          const SizedBox(height: 10),
          const CustomText(hint: "Search Your Food or Restaurant"),
          const SizedBox(height: 15),
          _buildPromoBanner(context),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "Categories"),
          const SizedBox(height: 5),
          _buildCategories(),
          const SizedBox(height: 10),
          _buildSectionHeader(context, "Restaurant"),
          Expanded(child: _buildRestaurantList()),
        ],
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset("assets/images/burger.png"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Special Discount",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: lightColorScheme.outlineVariant)),
              const SizedBox(height: 25),
              Text("up to 75%",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: lightColorScheme.background)),
              const SizedBox(height: 40),
              const CardButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) => const SizedBox(width: 25),
        itemBuilder: (context, index) => const CategoryCircle(title: "Pizza"),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return ListView.separated(
      itemBuilder: (context, index) => const FoodItemWidget(),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: 5,
    );
  }

  Padding _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: lightColorScheme.shadow)),
          InkWell(
            onTap: () {},
            child: Text("Show all",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: lightColorScheme.secondary,
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
