import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,
    required this.controller,
    required this.keyboard,
    required this.validate,
    this.onSubmit,
    this.onchange,
    this.onTap,
    required this.label,
    this.isClickable = true,
    required this.prefixIcon,
    this.suffixPressed,
    this.suffixIcon,
    this.isPassword = false,
    // this.colorBorder,
    this.colorIcon,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String? Function(String?)? validate;
  final void Function(String)? onSubmit;
  final void Function(String)? onchange;
  final void Function()? onTap;
  final String label;
  final bool isClickable;

  final dynamic prefixIcon;
  final void Function()? suffixPressed;
  final dynamic suffixIcon;
  final bool isPassword;

  final Color? colorIcon;

  // Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      onTap: onTap,
      cursorColor: Colors.teal,
      validator: validate,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.teal),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: colorIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
