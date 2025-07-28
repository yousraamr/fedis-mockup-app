/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SingleChildScrollView(
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

          Consumer<HomeProvider>(
            builder: (context, homeProvider, _) {
              if (homeProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeProvider.errorMessage != null) {
                return Center(child: Text(homeProvider.errorMessage!));
              } else if (homeProvider.services.isEmpty) {
                return const Center(child: Text("No services available"));
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.services.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final service = homeProvider.services[index];
                    return ServiceItemWidget(
                      title: service.serviceName ?? 'No Name',
                      url: service.serviceLink ?? '',
                      imageUrl: service.serviceImage ?? '',
                    );
                  },
                );
              }
            },
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

class ServiceItemWidget extends StatelessWidget {
  final String title;
  final String url;
  final String imageUrl;

  const ServiceItemWidget({
    super.key,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openLink(url),
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import '../home_view_model/home_provider.dart';
import 'package:fedis_mockup_demo/core/project_widgets/language_toggle_button.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/bottom_navbar.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/card_button.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/DynamicFormPage.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_view_model/nav_provider.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    final List<Widget> pages = [
      const HomePageContent(),
      const Center(child: Text("Cart Page")),
      const Center(child: Text("Favorites Page")),
      const Center(child: Text("Profile Page")),
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
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SingleChildScrollView(
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

          // Services List
          Consumer<HomeProvider>(
            builder: (context, homeProvider, _) {
              if (homeProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (homeProvider.errorMessage != null) {
                return Center(child: Text(homeProvider.errorMessage!));
              } else if (homeProvider.services.isEmpty) {
                return const Center(child: Text("No services available"));
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.services.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final service = homeProvider.services[index];
                    return GestureDetector(
                      onTap: () async {
                        if (service.formData != null && service.formData!.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DynamicFormPage(formData: service.formData!),
                            ),
                          );
                        } else if (service.serviceLink != null) {
                          final uri = Uri.parse(service.serviceLink!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Could not launch link")),
                            );
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  service.serviceImage ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.image, size: 30),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  service.serviceName ?? 'Unnamed Service',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
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
              Text(
                tr('get_special_discount'),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: lightColorScheme.outlineVariant,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                tr('up_to_discount', namedArgs: {'percent': '75'}),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: lightColorScheme.background,
                ),
              ),
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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: lightColorScheme.shadow,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DynamicFormPage(formData: []),
                ),
              );
            },
            child: Text(
              tr('show_all'),
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