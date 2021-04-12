// Fixed-sized BoxConstraints for showing purple 'submit' buttons and auth related textFields

import 'package:flutter/material.dart';

class WideButtonBox extends StatelessWidget {
  final Widget widget;

  WideButtonBox(this.widget);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ConstrainedBox(
        
        constraints: BoxConstraints.tightFor(height: 57),
        child: widget,
      ),
    );
  }
}
