import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/role_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/elderly_home_screen.dart';
import 'screens/medication_screen.dart';
import 'screens/communication_screen.dart';
import 'screens/caregiver_signup_screen.dart';

void main() {
  runApp(const HealthMateApp());
}

class HealthMateApp extends StatelessWidget {
  const HealthMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (_) => const SplashScreen(),
        Routes.onboarding: (_) => const OnboardingScreen(),
        Routes.role: (_) => const RoleScreen(),
        Routes.register: (_) => const RegisterScreen(),
        Routes.login: (_) => const LoginScreen(),
        Routes.otp: (_) => const OtpScreen(),
        Routes.profile: (_) => const ProfileSetupScreen(),
        Routes.home: (_) => const ElderlyHomeScreen(),
        Routes.medication: (_) => const MedicationScreen(),
        Routes.communication: (_) => const CommunicationScreen(),
        Routes.caregiverSignup: (_) => const CaregiverSignupScreen(),
      },
    );
  }
}
