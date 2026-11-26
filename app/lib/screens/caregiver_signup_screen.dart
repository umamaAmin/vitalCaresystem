import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class CaregiverSignupScreen extends StatefulWidget {
  const CaregiverSignupScreen({super.key});

  @override
  State<CaregiverSignupScreen> createState() => _CaregiverSignupScreenState();
}

class _CaregiverSignupScreenState extends State<CaregiverSignupScreen> {
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  bool _showPassword = false;
  bool _agree = false;
  final Set<String> _slots = {'Morning'};

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _password.dispose();
    _code.dispose();
    super.dispose();
  }

  void _create() {
    if (_name.text.trim().isEmpty ||
        _contact.text.trim().isEmpty ||
        _password.text.isEmpty) {
      showMsg(context, 'Please fill all the fields');
      return;
    }
    if (!_agree) {
      showMsg(context, 'Please accept the Terms & Privacy');
      return;
    }
    Navigator.pushNamed(context, Routes.otp);
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(t,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      );

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
                const Text('Create Caregiver Account',
                    style: TextStyle(fontSize: 12, color: AppColors.muted)),
              ],
            ),
            const Text('Caregiver Sign Up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                        color: Color(0xFFEDF0FF), shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: AppColors.navy),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profile photo',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        Text('Optional',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.muted)),
                      ],
                    ),
                  ),
                  SmallButton(
                      label: 'Upload',
                      onPressed: () => showMsg(context, 'Upload photo (demo)')),
                ],
              ),
            ),
            _label('Full name'),
            AppField(hint: 'Enter full name', controller: _name),
            _label('Phone or Email'),
            AppField(
                hint: 'Enter phone or email',
                controller: _contact,
                keyboardType: TextInputType.emailAddress),
            _label('Password'),
            AppField(
              hint: 'Create a password',
              controller: _password,
              obscure: !_showPassword,
              suffix: IconButton(
                icon: Icon(_showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
            ),
            _label('Available time slots'),
            Row(
              children: ['Morning', 'Afternoon', 'Evening'].map((s) {
                final selected = _slots.contains(s);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              selected ? AppColors.navy : Colors.white,
                          foregroundColor:
                              selected ? Colors.white : AppColors.ink,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => setState(() {
                          selected ? _slots.remove(s) : _slots.add(s);
                        }),
                        child: Text(s,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            _label('Link elder profile'),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: AppField(
                              hint: 'Enter elder code', controller: _code)),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => showMsg(context,
                              _code.text.isEmpty ? 'Enter a code first' : 'Code submitted (demo)'),
                          child: const Text('Enter Code',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('or', style: TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: () =>
                        showMsg(context, 'Request sent to family (demo)'),
                    child: const Text('Send request to family'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _agree,
                  onChanged: (v) => setState(() => _agree = v ?? false),
                ),
                const Text('I agree to Terms & Privacy',
                    style: TextStyle(fontSize: 13)),
              ],
            ),
            PrimaryButton(label: 'Create Account', onPressed: _create),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, Routes.login),
                  child: const Text('Already have an account? Login',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
