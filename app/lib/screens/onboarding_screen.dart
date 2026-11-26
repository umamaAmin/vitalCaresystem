import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class _Page {
  const _Page(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const _pages = [
    _Page(Icons.people_alt_outlined, 'Stay Connected with CareGivers',
        'Easily stay in touch with your caregivers and get real-time updates about your health.'),
    _Page(Icons.monitor_heart_outlined, 'Track Your Health Easily',
        'Monitor your vitals, get timely medication reminders, and stay aware of your progress.'),
    _Page(Icons.volunteer_activism_outlined, 'Daily Assistance and Services',
        'Need a helping hand? Our trusted caregivers are just a tap away.'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goRole() => Navigator.pushReplacementNamed(context, Routes.role);

  void _next() {
    _controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;
    return GradientScaffold(
      child: Column(
        children: [
          const SizedBox(height: 8),
          const BrandLogo(),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                final p = _pages[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // TODO: replace with Image.asset of the Figma art.
                        IllustrationBox(icon: p.icon, height: 220),
                        const SizedBox(height: 28),
                        Text(p.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),
                        Text(p.body,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.muted)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLast)
            PrimaryButton(label: "Let's get Started", onPressed: _goRole)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _goRole,
                  child: const Text('SKIP',
                      style: TextStyle(fontSize: 16, color: AppColors.ink)),
                ),
                InkWell(
                  onTap: _next,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                        color: AppColors.ink, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_right_alt,
                        color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
