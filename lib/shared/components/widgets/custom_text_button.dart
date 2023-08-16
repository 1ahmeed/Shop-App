import 'package:flutter/material.dart';

class CustomTextButton extends  StatelessWidget {
   const CustomTextButton({super.key,
     required this.onPressed,
     required this.text,
     this.style

   });
  final dynamic Function()? onPressed;
   final String text;
   final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: style,
      ),
    );
  }
}
