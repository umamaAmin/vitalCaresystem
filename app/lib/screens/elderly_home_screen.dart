import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ElderlyHomeScreen extends StatefulWidget {
  const ElderlyHomeScreen({super.key});

  @override
  State<ElderlyHomeScreen> createState() => _ElderlyHomeScreenState();
}

class _ElderlyHomeScreenState extends State<ElderlyHomeScreen> {
  int? _mood;

  static const _moods = ['😃', '🙂', '😐', '😔'];
  static const _moodNames = ['Great', 'Good', 'Okay', 'Not well'];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good morning,',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600)),
                      Text('Keerthi',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.muted)),
                    ],
                  ),
                ),
                const AvatarCircle(size: 54),
              ],
            ),
            const Text('Welcome back — here’s your day at a glance',
                style: TextStyle(fontSize: 13, color: AppColors.muted)),
            const SizedBox(height: 14),

            // Health summary
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const AvatarCircle(size: 50, icon: Icons.monitor_heart),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Health Summary',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        const Text('Heart Rate • Blood Pressure • Steps',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.muted)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: const [
                            _Pill('72 bpm'),
                            _Pill('120/80'),
                            _Pill('3,240 steps'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Feature cards
            Row(
              children: [
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.medication_outlined,
                    title: 'Medication',
                    subtitle: 'Reminders',
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.medication),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.event_outlined,
                    title: 'Appointments',
                    subtitle: 'Upcoming',
                    onTap: () => showMsg(context, 'Appointments (coming soon)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.chat_bubble_outline,
                    title: 'Chat with',
                    subtitle: 'Family',
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.communication),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FeatureCard(
                    icon: Icons.emergency_outlined,
                    title: 'Call',
                    subtitle: 'Ambulance',
                    danger: true,
                    onTap: () => showMsg(context, 'Calling ambulance (demo)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Call caregiver + emergency
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.communication),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          AvatarCircle(size: 34, icon: Icons.call),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text('Call Caregiver',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () => showMsg(context, 'Emergency alert sent (demo)'),
                    child: const Text('Emergency',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Mood
            const Text('How are you feeling today?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const Text('Tap a face to let us know',
                style: TextStyle(fontSize: 12, color: AppColors.muted)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_moods.length, (i) {
                  final selected = _mood == i;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _mood = i);
                      showMsg(context, 'Feeling: ${_moodNames[i]}');
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFFFFE9A8)
                            : const Color(0xFFFFF3D6),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: selected
                                ? AppColors.navy
                                : Colors.transparent,
                            width: 2),
                      ),
                      child:
                          Text(_moods[i], style: const TextStyle(fontSize: 26)),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 14),
            const Center(
              child: Text('Need help? Contact support • Settings',
                  style: TextStyle(fontSize: 12, color: AppColors.muted)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: const TextStyle(fontSize: 11)),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final accent = danger ? AppColors.red : AppColors.navy;
    return Material(
      color: danger ? AppColors.redSoft : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 30, color: accent),
              const SizedBox(height: 10),
              Text(title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: danger ? AppColors.red : AppColors.ink)),
              Row(
                children: [
                  Expanded(
                    child: Text(subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            color: danger ? AppColors.red : AppColors.muted,
                            fontWeight:
                                danger ? FontWeight.w700 : FontWeight.w400)),
                  ),
                  Icon(Icons.arrow_right_alt, color: accent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
