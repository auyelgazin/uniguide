// Fixed-sized BoxConstraints for showing purple 'submit' buttons and auth related textFields

import 'package:flutter/material.dart';

class WideButtonBox extends StatelessWidget {
  final Widget widget;

  WideButtonBox(this.widget);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      
      constraints: BoxConstraints.tightFor(width: 335, height: 57),
      child: widget,
    );
  }
}
