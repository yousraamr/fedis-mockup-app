import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'package:fedis_mockup_demo/auth/presentation/view_model/auth_provider.dart';
import 'package:fedis_mockup_demo/auth/data/datasource/auth_datasourse.dart';
import 'package:fedis_mockup_demo/auth/data/repository/auth_repository_impl.dart';
import 'package:fedis_mockup_demo/auth/domain/usecases/login_usecase.dart';
import 'package:fedis_mockup_demo/auth/domain/usecases/register_usecase.dart';
import 'package:fedis_mockup_demo/auth/domain/usecases/logout_usecase.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/auth/presentation/pages/welcome_page.dart';
import 'package:fedis_mockup_demo/core/utils/custom_router.dart';
import 'package:fedis_mockup_demo/home/home_presentation/home_view_model/nav_provider.dart';
import 'package:fedis_mockup_demo/core/utils/route_names.dart';
import 'package:fedis_mockup_demo/core/storage/cache_helper.dart';
import 'package:fedis_mockup_demo/core/providers/theme_provider.dart';

import 'home/home_data/home_datasource/home_datasource.dart';
import 'home/home_presentation/home_view_model/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();

  String savedLang = CacheHelper.getData("userLanguage") as String? ?? 'ar';
  Locale initialLocale = Locale(savedLang);

  final bool isDarkMode = (CacheHelper.getData('isDarkMode') ?? false) as bool;

  // Dependency Injection
  final dio = Dio();
  final dataSource = AuthDataSource(dio);
  final authRepository = AuthRepositoryImpl(dataSource);
  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      saveLocale: false, // prevent EasyLocalization from storing globally
      startLocale: initialLocale, // set user-specific locale
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(
              loginUseCase: loginUseCase,
              registerUseCase: registerUseCase,
              logoutUseCase: logoutUseCase,
            ),
          ),
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider(null)),
          ChangeNotifierProvider(create: (_) => HomeProvider(homeDataSource: HomeDataSource(Dio()))),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fedis Mockup Demo',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: welcomeScreen,
      onGenerateRoute: CustomRouter.allRoutes,
    );
  }
}
