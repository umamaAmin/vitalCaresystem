import 'package:flutter/material.dart';
import '../theme/app_palette.dart';
import 'role_screen.dart';

const String _brand = 'EASY CARE';

class _ChipData {
  final IconData icon;
  final String label;
  final Alignment align;
  const _ChipData(this.icon, this.label, this.align);
}

class _PageData {
  final IconData icon;
  final String title;
  final String text;
  final Color tint;
  final List<_ChipData> chips;
  const _PageData({
    required this.icon,
    required this.title,
    required this.text,
    required this.tint,
    required this.chips,
  });
}

const List<_PageData> _pages = [
  _PageData(
    icon: Icons.groups_rounded,
    title: 'Stay connected with caregivers',
    text:
        'Easily stay in touch with your caregivers and get real-time updates about your health.',
    tint: Color(0xFFCCFBF1),
    chips: [
      _ChipData(Icons.call_rounded, 'Call', Alignment(-0.85, -0.6)),
      _ChipData(
          Icons.notifications_active_rounded, 'Updates', Alignment(0.85, 0.6)),
    ],
  ),
  _PageData(
    icon: Icons.monitor_heart_rounded,
    title: 'Track your health easily',
    text:
        'Monitor your vitals, get timely medication reminders, and stay aware of your progress.',
    tint: Color(0xFFFFE8D6),
    chips: [
      _ChipData(Icons.favorite_rounded, '72 bpm', Alignment(-0.85, -0.6)),
      _ChipData(Icons.water_drop_rounded, 'SpO2 98%', Alignment(0.85, 0.6)),
    ],
  ),
  _PageData(
    icon: Icons.volunteer_activism_rounded,
    title: 'Daily assistance and services',
    text: 'Need a helping hand? Our trusted caregivers are just a tap away.',
    tint: Color(0xFFDCEBFF),
    chips: [
      _ChipData(Icons.medication_rounded, 'Medicines', Alignment(-0.85, -0.6)),
      _ChipData(
          Icons.health_and_safety_rounded, 'Help', Alignment(0.85, 0.6)),
    ],
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pc = PageController();
  int _index = 0;

  bool get _isLast => _index == _pages.length - 1;

  void _next() {
    if (_isLast) {
      _finish();
      return;
    }
    _pc.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _finish() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const RoleScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  Widget _brandRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
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

  Widget _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (i) {
        final active = i == _index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 28 : 8,
          decoration: BoxDecoration(
            color: active ? AppPalette.teal : const Color(0xFF9FD8CF),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }

  Widget _controls() {
    return Row(
      key: const ValueKey('controls'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: _finish,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: const Text(
            'Skip',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppPalette.muted,
            ),
          ),
        ),
        SizedBox(
          width: 64,
          height: 64,
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.teal,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 4,
            ),
            child: const Icon(Icons.arrow_forward_rounded, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _startButton() {
    return SizedBox(
      key: const ValueKey('start'),
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: _finish,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.teal,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "Let's get started",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
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
            child: Column(
              children: [
                const SizedBox(height: 16),
                _brandRow(),
                Expanded(
                  child: PageView.builder(
                    controller: _pc,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (_, i) => _OnboardPage(data: _pages[i]),
                  ),
                ),
                _dots(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isLast ? _startButton() : _controls(),
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

class _OnboardPage extends StatelessWidget {
  final _PageData data;
  const _OnboardPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final minH = c.maxHeight > 24 ? c.maxHeight - 24 : 0.0;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minH),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Illustration(data: data),
                const SizedBox(height: 28),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: AppPalette.ink,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: AppPalette.muted,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Illustration extends StatelessWidget {
  final _PageData data;
  const _Illustration({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [data.tint, Colors.white],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x140F766E),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x220F766E),
            ),
          ),
          Container(
            width: 112,
            height: 112,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Icon(data.icon, size: 58, color: AppPalette.teal),
          ),
          for (final c in data.chips)
            Align(alignment: c.align, child: _InfoChip(data: c)),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final _ChipData data;
  const _InfoChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, size: 20, color: AppPalette.coral),
          const SizedBox(width: 6),
          Text(
            data.label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppPalette.ink,
            ),
          ),
        ],
      ),
    );
  }
}