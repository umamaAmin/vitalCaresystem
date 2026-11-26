import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String? _caregiver;
  String? _language;
  bool _largeFont = false;
  bool _highContrast = false;

  Widget _heading(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 8),
        child: Text(t,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      );

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const Spacer(),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            const Text('Set Up Your\nProfile',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Emergency contact',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  const _SoftField(hint: 'Name'),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                          child: _SoftField(
                              hint: 'Phone', type: TextInputType.phone)),
                      SizedBox(width: 12),
                      Expanded(child: _SoftField(hint: 'Relation')),
                    ],
                  ),
                  _heading('Primary Caregiver'),
                  AppDropdown(
                    fillColor: const Color(0xFFF3F5FF),
                    hint: 'Select caregiver',
                    value: _caregiver,
                    items: const ['Caregiver 1', 'Caregiver 2'],
                    onChanged: (v) => setState(() => _caregiver = v),
                  ),
                  TextButton(
                    onPressed: () => showMsg(context, 'Add new caregiver (demo)'),
                    child: const Text('+ Add new caregiver',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.navy,
                            fontWeight: FontWeight.w700)),
                  ),
                  _heading('Preferred Language'),
                  AppDropdown(
                    fillColor: const Color(0xFFF3F5FF),
                    hint: 'Choose language',
                    value: _language,
                    items: const ['English', 'Urdu', 'Hindi'],
                    onChanged: (v) => setState(() => _language = v),
                  ),
                  const SizedBox(height: 14),
                  _toggle('Large Font Size', _largeFont,
                      (v) => setState(() => _largeFont = v)),
                  _toggle('High Contrast Mode', _highContrast,
                      (v) => setState(() => _highContrast = v)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'Save & Continue',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, Routes.home, (r) => false),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SoftField extends StatelessWidget {
  const _SoftField({required this.hint, this.type});
  final String hint;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.muted),
        filled: true,
        fillColor: const Color(0xFFF3F5FF),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
