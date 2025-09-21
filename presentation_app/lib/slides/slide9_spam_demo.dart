// ignore_for_file: depend_on_referenced_packages

import 'package:experience_marketplace/data/providers/feature_flag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:experience_marketplace/data/repositories/category_repository.dart';
import 'package:experience_marketplace/data/services/auth_service.dart';
import 'package:experience_marketplace/data/repositories/user_repository.dart';
import 'package:experience_marketplace/data/repositories/experience_repository.dart';
import 'package:experience_marketplace/data/repositories/mock_category_repository.dart';
import 'package:experience_marketplace/data/repositories/spam_experience_repository.dart';
import 'package:experience_marketplace/presentation/screens/splash/splash_screen.dart';
import 'package:experience_marketplace/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/theme_service.dart';
import 'package:device_preview/device_preview.dart';

class Slide9SpamDemo extends StatefulWidget {
  const Slide9SpamDemo({super.key});

  @override
  State<Slide9SpamDemo> createState() => _Slide9SpamDemoState();
}

class _Slide9SpamDemoState extends State<Slide9SpamDemo> {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Container(
      decoration: BoxDecoration(gradient: themeService.getGradient()),
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Row(
          children: [
            // Left side - title and description
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let's see the app demo",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(width: 48),
            // Right side - app demo showing spam events
            Expanded(
              flex: 1,
              child: Center(
                child: DeviceFrame(
                  device: Devices.android.samsungGalaxyS25,
                  screen: MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(size: const Size(393, 852)),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 393,
                        height: 852,
                        child: SpamDemoApp(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpamDemoApp extends StatelessWidget {
  const SpamDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleFonts.config.allowRuntimeFetching = false;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FeatureFlagProvider>(
          create: (_) => FeatureFlagProvider(enableTimeSorting: false),
        ),
        Provider<AuthService>(create: (_) => AuthService.mock()),
        Provider<UserRepository>(
          create: (_) => MockUserRepository(),
          dispose: (_, repo) {
            if (repo is MockUserRepository) repo.dispose();
          },
        ),
        Provider<CategoryRepository>(create: (_) => MockCategoryRepository()),
        Provider<ExperienceRepository>(
          create: (_) => SpamExperienceRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Experience Marketplace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
