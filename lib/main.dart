import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/community_screen.dart';
import 'screens/my_screen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/drain_management_screen.dart';
import 'screens/drain_registration_screen.dart';
import 'screens/notification_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const CleaningApp(),
    ),
  );
}

class CleaningApp extends StatelessWidget {
  const CleaningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '청소 관리',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FFAA),
        ),
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          case '/login':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
              transitionDuration: const Duration(milliseconds: 1200),
              reverseTransitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // 페이드인 + 스케일 조합으로 더 부드러운 효과
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.95,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    )),
                    child: child,
                  ),
                );
              },
            );
          case '/home':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          default:
            return MaterialPageRoute(
              builder: (context) {
                switch (settings.name) {
                  case '/map':
                    return const MapScreen();
                  case '/community':
                    return const CommunityScreen();
                  case '/my':
                    return const MyScreen();
                  case '/profile-edit':
                    return const ProfileEditScreen();
                  case '/drain-management':
                    return const DrainManagementScreen();
                  case '/drain-registration':
                    return const DrainRegistrationScreen();
                  case '/notification':
                    return const NotificationScreen();
                  default:
                    return const SplashScreen();
                }
              },
            );
        }
      },
    );
  }
}
