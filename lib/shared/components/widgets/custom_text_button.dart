import 'package:flutter/material.dart';

class CustomTextButton extends  StatelessWidget {
   CustomTextButton({
     Key? key,
     required this.onPressed,
     required this.text,
     this.style

   });
   dynamic Function()? onPressed;
   String text;
   TextStyle? style;

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
