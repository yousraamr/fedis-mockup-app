import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/signup_page.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/login_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/home_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/profile_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/cart_screen.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_pages/fav_screen.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/welcome_page.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/forget_password.dart';
class CustomRouter {
  static Route<dynamic>? allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case favoritesScreen:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}