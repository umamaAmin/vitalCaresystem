import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _nodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _next() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length < 4) {
      showMsg(context, 'Enter the 4 digit code');
      return;
    }
    // Demo: any 4 digits are accepted.
    Navigator.pushNamed(context, Routes.profile);
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Verify Your\nAccount',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            const Text('Enter the digit code sent to your number\nor email',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                return Container(
                  width: 52,
                  height: 52,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _nodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                        counterText: '', border: InputBorder.none),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 3) _nodes[i + 1].requestFocus();
                      if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 22),
            TextButton(
              onPressed: () => showMsg(context, 'OTP sent again (demo)'),
              child: const Text('Resend OTP',
                  style: TextStyle(color: AppColors.navy)),
            ),
            const SizedBox(height: 80),
            PrimaryButton(label: 'Next', onPressed: _next),
          ],
        ),
      ),
    );
  }
}
