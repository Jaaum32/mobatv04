import 'package:flutter/material.dart';
import 'package:mobatv04/screens/splash_animated.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuScan',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashAnimated(),
        //'/onboarding': (context) => const OnboardingScreen(),
        // adicione outras rotas aqui
      },
    );
  }
}
