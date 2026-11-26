import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Text('Voice Assist',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700)),
                      SizedBox(width: 6),
                      Icon(Icons.mic, size: 18, color: AppColors.navy),
                    ],
                  ),
                ),
              ],
            ),
            const Text('Stay connected',
                style: TextStyle(fontSize: 12, color: AppColors.muted)),
            const Text('Communication',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
            const Text('Big buttons and voice assist for easy access',
                style: TextStyle(fontSize: 12, color: AppColors.muted)),
            const SizedBox(height: 16),
            _BigAction(
              title: 'Call Caregiver',
              subtitle: 'Immediate voice call to your caregiver',
              icon: Icons.call,
              colors: const [Color(0xFF4A56D6), Color(0xFF2E3192)],
              badge: const _Badge('!', AppColors.red),
              onTap: () => showMsg(context, 'Calling caregiver (demo)'),
            ),
            const SizedBox(height: 14),
            _BigAction(
              title: 'Chat with Family',
              subtitle: 'Send messages or voice notes',
              icon: Icons.chat_bubble,
              colors: const [Colors.white, Colors.white],
              dark: false,
              badge: const _Badge('3', Color(0xFFFF6B6B)),
              onTap: () => showMsg(context, 'Opening family chat (demo)'),
            ),
            const SizedBox(height: 14),
            _BigAction(
              title: 'Video Call Doctor',
              subtitle: 'Secure video consultation',
              icon: Icons.videocam,
              colors: const [Color(0xFF8E6BFF), Color(0xFF5B4BE0)],
              badge: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                    color: AppColors.green, shape: BoxShape.circle),
              ),
              onTap: () => showMsg(context, 'Starting video call (demo)'),
            ),
            const SizedBox(height: 22),
            Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => showMsg(context, 'Listening... say "Call my caregiver"'),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8E96D8),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child:
                          const Icon(Icons.mic, size: 46, color: AppColors.ink),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Voice Quick Call',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const Text('Say: "Call my caregiver"',
                      style: TextStyle(fontSize: 12, color: AppColors.muted)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Need help?',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        Text('Call support or emergency services',
                            style: TextStyle(
                                fontSize: 11, color: AppColors.muted)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => showMsg(context, 'Calling support (demo)'),
                    child: const Text('Call Support',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }
}

class _BigAction extends StatelessWidget {
  const _BigAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.badge,
    required this.onTap,
    this.dark = true,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final Widget badge;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final fg = dark ? Colors.white : AppColors.ink;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: dark ? const Color(0x33FFFFFF) : const Color(0xFFEDF0FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: dark ? Colors.white : AppColors.navy),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: fg)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            color: dark
                                ? const Color(0xCCFFFFFF)
                                : AppColors.muted)),
                  ],
                ),
              ),
              badge,
            ],
          ),
        ),
      ),
    );
  }
}
