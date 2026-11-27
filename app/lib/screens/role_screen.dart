import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_palette.dart';
import 'register_screen.dart';

const String _brand = 'EASY CARE';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  void _openRegister(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen(initialRole: role)),
    );
  }

  Widget _brandRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: AppPalette.teal,
          child: Icon(Icons.favorite_rounded, size: 20, color: Colors.white),
        ),
        SizedBox(width: 10),
        Text(
          _brand,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppPalette.tealDark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.mint,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                children: [
                  _brandRow(),
                  const SizedBox(height: 32),
                  const Text(
                    'Who are you?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppPalette.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose how you will use Easy Care',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppPalette.muted),
                  ),
                  const SizedBox(height: 28),
                  _RoleCard(
                    index: 0,
                    icon: Icons.elderly_rounded,
                    tint: AppPalette.mintDeep,
                    title: 'Elderly User',
                    text: 'Access personalized care and reminders',
                    onTap: () => _openRegister(context, 'Elderly User'),
                  ),
                  _RoleCard(
                    index: 1,
                    icon: Icons.medical_services_rounded,
                    tint: const Color(0xFFFFE8D6),
                    title: 'Caregiver',
                    text: 'Manage and monitor your assigned elders',
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.caregiverSignup),
                  ),
                  _RoleCard(
                    index: 2,
                    icon: Icons.admin_panel_settings_rounded,
                    tint: const Color(0xFFDCEBFF),
                    title: 'Admin',
                    text: 'Oversee system operations and reports',
                    onTap: () => _openRegister(context, 'Admin'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, Routes.login),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(fontSize: 16, color: AppPalette.muted),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppPalette.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.index,
    required this.icon,
    required this.tint,
    required this.title,
    required this.text,
    required this.onTap,
  });

  final int index;
  final IconData icon;
  final Color tint;
  final String title;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + index * 150),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(offset: Offset(0, 24 * (1 - v)), child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x140F766E),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: tint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(icon, size: 34, color: AppPalette.teal),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppPalette.ink,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            text,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.3,
                              color: AppPalette.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppPalette.mint,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: AppPalette.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}