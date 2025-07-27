import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/signup_page.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/home_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/profile_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/cart_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/fav_screen.dart';

class CustomRouter {
  static Route<dynamic>? allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case registerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignUpScreen());
      case loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignInScreen());
      case homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case profileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());
      default:
        return null;
    }
  }
}