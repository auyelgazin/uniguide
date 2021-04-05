import 'package:flutter/material.dart';
import 'package:uniguide/widgets/font_styles.dart';

class AuthButton extends StatelessWidget {
  final String childText;
  final Function func;

  AuthButton(this.childText, this.func);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        childText,
        style: wideButtonTitle,
      ),
      onPressed: func,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF4F4DAA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
