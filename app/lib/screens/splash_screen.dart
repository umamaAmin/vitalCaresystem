import 'dart:async';
import 'package:material_ui/material_ui.dart';
import '../theme/app_palette.dart';
import 'onboarding_screen.dart';

const String _brand = 'EASY CARE';
const String _tagline = 'Caring for your golden years,\nlike a family';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
    _timer = Timer(const Duration(milliseconds: 3000), _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, _, _) => const OnboardingScreen(),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppPalette.tealDark,
              AppPalette.teal,
              AppPalette.tealBright,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: -90, right: -70, child: _circle(260, AppPalette.white10)),
            Positioned(
                bottom: -110,
                left: -80,
                child: _circle(300, AppPalette.white10)),
            Positioned(
                top: 160, left: -40, child: _circle(110, AppPalette.white10)),
            Center(
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 30,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          size: 64,
                          color: AppPalette.coral,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        _brand,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        _tagline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPalette.white80,
                          fontSize: 18,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}