import 'package:flutter/material.dart';
import 'package:uniguide/screens/auth/auth_models/position.dart';

Widget buildSingleCheckbox(Position position, Function onClicked) =>
    buildCheckbox(
      position: position,
      onClicked: () {
        onClicked();
      },
    );

Widget buildCheckbox({
  @required Position position,
  @required VoidCallback onClicked,
}) =>
    ListTile(
      onTap: onClicked,
      trailing: Checkbox(
        // checkColor: Color(0xFF232195),  // color of tick Mark
        activeColor: Color(0xFF232195),
        value: position.value,
        onChanged: (value) => onClicked(),
      ),
      title: Text(
        position.title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF232195).withOpacity(0.6),
        ),
      ),
    );

class PrivacyPolicyCheckbox extends StatelessWidget {
  bool agreementValue;
  Function onChanged;

  PrivacyPolicyCheckbox({this.agreementValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            tristate: false,
            activeColor: Color(0xFF232195),
            value: agreementValue,
            onChanged: onChanged,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'I give consent to the processing of personal data',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
