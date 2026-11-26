import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'register_screen.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const BrandLogo(showText: false),
            const SizedBox(height: 12),
            const Text('Who are You?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 22),
            _RoleCard(
              icon: Icons.elderly,
              title: 'Elderly User',
              subtitle: 'Access personalized care and reminders',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        const RegisterScreen(initialRole: 'Elderly User')),
              ),
            ),
            _RoleCard(
              icon: Icons.medical_services_outlined,
              title: 'Caregiver',
              subtitle: 'Manage and monitor your assigned elders',
              onTap: () => Navigator.pushNamed(context, Routes.caregiverSignup),
            ),
            _RoleCard(
              icon: Icons.admin_panel_settings_outlined,
              title: 'Admin',
              subtitle: 'Oversee system operations and reports',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const RegisterScreen(initialRole: 'Admin')),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, Routes.login),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                AvatarCircle(size: 62, icon: icon),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.navy)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.muted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
