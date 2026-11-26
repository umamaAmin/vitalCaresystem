import 'package:material_ui/material_ui.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.initialRole = 'Elderly User'});
  final String initialRole;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _password = TextEditingController();
  late String _role = widget.initialRole;
  bool _agree = false;

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _password.dispose();
    super.dispose();
  }

  void _continue() {
    if (_name.text.trim().isEmpty ||
        _contact.text.trim().isEmpty ||
        _password.text.isEmpty) {
      showMsg(context, 'Please fill all the fields');
      return;
    }
    if (!_agree) {
      showMsg(context, 'Please accept the Terms & Privacy Policy');
      return;
    }
    Navigator.pushNamed(context, Routes.otp);
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text('Create Your\nAccount',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 22),
            AppField(label: 'Full Name', hint: 'Enter Your Name', controller: _name),
            const SizedBox(height: 14),
            AppField(
                label: 'Email / Phone Number',
                hint: 'Enter Your Email or phone Number',
                controller: _contact,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 14),
            AppField(
                label: 'Password',
                hint: 'Create a Password',
                controller: _password,
                obscure: true),
            const SizedBox(height: 14),
            AppDropdown(
              leadingLabel: 'Role',
              hint: 'Select role',
              value: _role,
              items: const ['Elderly User', 'Caregiver', 'Admin'],
              onChanged: (v) => setState(() => _role = v ?? _role),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const AvatarCircle(size: 54),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () => showMsg(context, 'Upload photo (demo)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.navy,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Upload photo'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _agree,
                        onChanged: (v) => setState(() => _agree = v ?? false),
                      ),
                      const Expanded(
                        child: Text('I agree to the Terms & Privacy Policy',
                            style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                  PrimaryButton(label: 'Continue', onPressed: _continue),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(fontSize: 13)),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, Routes.login),
                        child: const Text('Login',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
