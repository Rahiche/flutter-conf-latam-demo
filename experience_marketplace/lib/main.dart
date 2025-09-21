import 'package:experience_marketplace/data/repositories/api_category_repository.dart';
import 'package:experience_marketplace/data/repositories/category_repository.dart';
import 'package:experience_marketplace/data/services/auth_service.dart';
import 'package:experience_marketplace/data/services/serverpod_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';
import 'config/server_config.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/api_user_repository.dart';
import 'data/repositories/experience_repository.dart';
import 'data/repositories/api_experience_repository.dart';
import 'data/repositories/mock_category_repository.dart';
import 'data/repositories/mock_experience_repository.dart';
import 'data/providers/feature_flag_provider.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  // Log server configuration for debugging
  ServerConfig.logConfig();

  // Configure Google Fonts - allow fetching on web, restrict in mock mode on native
  GoogleFonts.config.allowRuntimeFetching = kIsWeb || !ServerConfig.isMockMode;

  runApp(const MyApp());
}

// Server client is only constructed in non-mock mode.
ServerpodService _buildServerpodService() {
  final svc = ServerpodService(
    ServerConfig.serverUrl,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..setConnectivityMonitor(FlutterConnectivityMonitor());
  return svc;
}

class ResponsiveDevicePreview extends StatelessWidget {
  const ResponsiveDevicePreview({super.key});

  @override
  Widget build(BuildContext context) {
    const isMock = ServerConfig.isMockMode;

    return MultiProvider(
      providers: isMock
          ? [
              // Mock mode: no server, all local data
              Provider<AuthService>(
                create: (_) => AuthService.mock(),
              ),
              Provider<UserRepository>(
                create: (_) => MockUserRepository(),
                dispose: (_, repo) {
                  if (repo is MockUserRepository) repo.dispose();
                },
              ),
              Provider<CategoryRepository>(
                create: (_) => MockCategoryRepository(),
              ),
              Provider<ExperienceRepository>(
                create: (_) => MockExperienceRepository(),
              ),
              ChangeNotifierProvider<FeatureFlagProvider>(
                create: (_) => FeatureFlagProvider(enableTimeSorting: true),
              ),
            ]
          : [
              Provider<ServerpodService>(
                create: (_) => _buildServerpodService(),
              ),
              ProxyProvider<ServerpodService, AuthService>(
                update: (context, serverpodService, authService) =>
                    authService ?? AuthService(serverpodService),
              ),
              ProxyProvider<ServerpodService, UserRepository>(
                update: (context, serverpodService, userRepository) =>
                    userRepository ??
                    ApiUserRepository(serverpodService: serverpodService),
                dispose: (_, repository) {
                  if (repository is ApiUserRepository) {
                    repository.dispose();
                  }
                },
              ),
              ProxyProvider<ServerpodService, CategoryRepository>(
                update: (context, serverpodService, categoryRepository) =>
                    categoryRepository ??
                    ApiCategoryRepository(apiService: serverpodService),
              ),
              ProxyProvider<ServerpodService, ExperienceRepository>(
                update: (context, serverpodService, experienceRepository) =>
                    experienceRepository ??
                    ApiExperienceRepository(apiService: serverpodService),
              ),
              ChangeNotifierProvider<FeatureFlagProvider>(
                create: (_) => FeatureFlagProvider(enableTimeSorting: true),
              ),
            ],
      child: Builder(
        builder: (context) {
          final isLargeDevice = MediaQuery.of(context).size.width > 800;

          if (isLargeDevice) {
            return DevicePreview(
              backgroundColor: Colors.transparent,
              enabled: true,
              isToolbarVisible: false,
              builder: (context) => MaterialApp(
                title: 'Experience Marketplace',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.light,
                useInheritedMediaQuery: true,
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                home: const SplashScreen(),
              ),
            );
          }

          return MaterialApp(
            title: 'Experience Marketplace',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveDevicePreview();
  }
}
