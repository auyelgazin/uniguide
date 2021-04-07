import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintLabelText;
  final bool hidePassword;
  final TextEditingController controller;
  final Icon trailingIcon;
  final TextInputType keyboardType;

  AuthTextField(
      {this.hintLabelText,
      this.hidePassword,
      this.controller,
      this.trailingIcon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: Color(0xFF4141A8),
      cursorWidth: 1.5,
      obscureText: hidePassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(

          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: trailingIcon,
          
          hintText: hintLabelText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF232195).withOpacity(0.6),
          ),
          // focusColor: Color(0xFFB7C1F4),

          fillColor: Color(0xFFB7C1F4).withOpacity(0.4), 
          filled: true
          // labelText: hintLabelText
          ),
    );
  }
}
