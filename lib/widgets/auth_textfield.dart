import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintLabelText;
  final bool hidePassword;
  final TextEditingController controller;
  final Icon trailingIcon;

  AuthTextField(
      {this.hintLabelText,
      this.hidePassword,
      this.controller,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: Color(0xFF4141A8),
      cursorWidth: 1.5,
      obscureText: hidePassword,
      decoration: InputDecoration(
          
          // border: InputBorder.none,
          suffixIcon: trailingIcon,
          hintText: hintLabelText,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF232195).withOpacity(0.6)),
          fillColor: Color(0xFFB7C1F4).withOpacity(0.4),
          filled: true
          // labelText: hintLabelText
          ),
    );
  }
}
