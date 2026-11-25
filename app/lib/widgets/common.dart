import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// White -> light lavender gradient background used on every screen.
class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.bgStart, AppColors.bgEnd],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: Padding(padding: padding, child: child)),
      ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 54, this.showText = true});
  final double size;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size * 1.15,
          height: size,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.favorite_border,
                    size: size, color: AppColors.iconGrey),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.add,
                    size: size * 0.55, color: AppColors.iconGrey),
              ),
            ],
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 4),
          const Text(
            kAppBrand,
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 54,
    this.color = AppColors.navy,
    this.fontSize = 18,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: onPressed,
        child: Text(label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.suffix,
  });

  final String hint;
  final String? label;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.muted),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffix,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// Drop-down styled like the Figma fields.
class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.leadingLabel,
    this.fillColor = Colors.white,
  });

  final String hint;
  final String? leadingLabel;
  final Color fillColor;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (leadingLabel != null)
            Text(leadingLabel!,
                style: const TextStyle(
                    color: AppColors.muted, fontWeight: FontWeight.w600)),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: Text(hint,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.muted)),
                alignment: leadingLabel != null
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                items: items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder for Figma illustrations. Replace with Image.asset(...) later.
class IllustrationBox extends StatelessWidget {
  const IllustrationBox({super.key, required this.icon, this.height = 200});
  final IconData icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEDF0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 90, color: AppColors.navy),
    );
  }
}

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key, this.size = 56, this.icon = Icons.person});
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
          color: Color(0xFFDDE3FF), shape: BoxShape.circle),
      child: Icon(icon, size: size * 0.6, color: AppColors.navy),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

void showMsg(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
