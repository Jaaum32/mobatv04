import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mobatv04/screens/splash_animated.dart';
import 'package:mobatv04/screens/onboarding/onboarding_screen.dart';
import 'package:mobatv04/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode? _themeMode;

  @override
  void initState() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    super.initState();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashAnimated(toggleTheme: _toggleTheme),
        '/onboarding': (context) => OnboardingScreen(toggleTheme: _toggleTheme),
        '/login': (context) => LoginScreen(toggleTheme: _toggleTheme),
      },
    );
  }
}
