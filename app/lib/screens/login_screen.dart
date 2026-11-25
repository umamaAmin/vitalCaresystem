import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _contact = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _contact.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            const Text('Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 48),
            AppField(
                hint: 'Email or Phone Number',
                controller: _contact,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            AppField(hint: 'Password', controller: _password, obscure: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => showMsg(context, 'Forgot password (demo)'),
                child: const Text('Forgot Password?',
                    style: TextStyle(fontSize: 13, color: AppColors.navy)),
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Login',
              height: 58,
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(context, Routes.home, (r) => false),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not your Role?'),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.role),
                  child: const Text(' Switch',
                      style: TextStyle(color: AppColors.navy)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.role),
                  child: const Text(' Register',
                      style: TextStyle(
                          color: AppColors.navy, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
