import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mana_uz/constants/app_constants.dart';
import 'package:mana_uz/screens/main_navigation.dart';
import 'package:mana_uz/screens/splash_screen.dart';
import 'package:mana_uz/theme/app_theme.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  
  runApp(const ManaUzApp());
}

class ManaUzApp extends StatelessWidget {
  const ManaUzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(
        // After splash screen, navigate to MainNavigation
        nextScreen: MainNavigation(),
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },
    );
  }
}
