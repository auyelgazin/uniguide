import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String avatarImage;
  final String title;
  final Function onTap;

  ProfileButton({this.avatarImage, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 44),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFE4E4E4),
                    child: Image.asset(
                      avatarImage,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4F4F4F),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/go.png',
                height: 13,
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
