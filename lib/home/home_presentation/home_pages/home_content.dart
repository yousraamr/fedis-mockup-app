import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../home_view_model/home_provider.dart';
import 'cart_screen.dart';
import 'fav_screen.dart';
import 'profile_screen.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/bottom_navbar.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/custom_text.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/card_button.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_view_model/nav_provider.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:fedis_mockup_demo/core/project_widgets/language_toggle_button.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/food_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    final List<Widget> pages = [
      const HomePageContent(),
      const CartScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    super.initState();
    // ✅ Fetch JSON services on page load
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('hi_user', namedArgs: {'userName': authProvider.userName ?? 'User'}),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: lightColorScheme.shadow,
                ),
              ),
              LanguageToggleButton(
                iconColor: lightColorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 10),

          CustomText(hint: tr('search_hint')),
          const SizedBox(height: 15),

          _buildPromoBanner(context),
          const SizedBox(height: 20),

          _buildSectionHeader(context, tr('services')),
          const SizedBox(height: 10),

          // ✅ Dynamic Services List
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, _) {
                if (homeProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (homeProvider.errorMessage != null) {
                  return Center(child: Text(homeProvider.errorMessage!));
                } else if (homeProvider.services.isEmpty) {
                  return const Center(child: Text("No services available"));
                } else {
                  return ListView.separated(
                    itemCount: homeProvider.services.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final service = homeProvider.services[index];
                      return ServiceItemWidget(
                        title: service.serviceName ?? 'No Name',
                        description: service.serviceLink ?? 'No Description',
                        imageUrl: service.serviceImage ?? '',
                      );
                    },
                  );
                }
              },
            ),
          ),
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
              Text(tr('get_special_discount'),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: lightColorScheme.outlineVariant)),
              const SizedBox(height: 25),
              Text(tr('up_to_discount', namedArgs: {'percent': '75'}),
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
            child: Text(tr('show_all'),
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