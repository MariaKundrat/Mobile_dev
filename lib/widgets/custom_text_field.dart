import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final Color? iconColor;
  final Color? textColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.labelStyle,
    this.iconColor,
    this.textColor,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: textColor ?? Colors.black),
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          labelText: labelText,
          labelStyle: labelStyle ?? const TextStyle(color: Colors.black),
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: iconColor ?? Colors.black)
                  : null,
          // ignore: deprecated_member_use
          fillColor: Colors.white.withOpacity(0.2),
          filled: true,
        ),
      ),
    );
  }
}
