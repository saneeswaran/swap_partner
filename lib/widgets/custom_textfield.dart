import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool obScure;
  final VoidCallback? onPressed;
  final TextEditingController controller;
  final Color color;
  final int? maxLength;
  const CustomTextfield(
      {super.key,
      required this.text,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.obScure = false,
      this.onPressed,
      required this.controller,
      this.color = Colors.grey,
      this.maxLength = null});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obScure,
      maxLength: maxLength,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2)),
          hintText: text,
          suffixIcon: IconButton(onPressed: onPressed, icon: Icon(icon)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2))),
    );
  }
}
