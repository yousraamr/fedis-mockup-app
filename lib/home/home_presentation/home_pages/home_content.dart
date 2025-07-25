import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';

import '../home_widgets/custom_text.dart';
import '../home_widgets/card_button.dart';
import '../home_widgets/category_circle.dart';
import '../home_widgets/food_item_widget.dart';

class HomeContent extends StatelessWidget {
  final String userName;
  const HomeContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: topMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $userName!",
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
            child: Image.asset("assets/images/burger.png")),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Special Discount",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: lightColorScheme.outlineVariant,
                ),
              ),
              const SizedBox(height: 25),
              Text("up to 75%",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: lightColorScheme.background),
              ),
              const SizedBox(height: 40),
              const CardButton()
            ],
          ),
        )
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
      scrollDirection: Axis.vertical,
    );
  }

  Padding _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: lightColorScheme.shadow,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text("Show all",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: lightColorScheme.secondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
