import 'package:flutter/material.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/onboarding/welcome_screen.dart';
import 'wide_button_box.dart';

class LangButton extends StatelessWidget {
  final String langID;
  final String region;
  final String assetImage;
  final String langName;
  final LanguageController languageController;

  LangButton({this.langID, this.region, this.assetImage, this.langName, this.languageController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        languageController.changeLanguage(langID, region);
        Get.to(() => WelcomeScreen());
      },
      child: WideButtonBox(
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFB7C1F4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(assetImage),
                    maxRadius: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    langName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF141619),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF232195).withOpacity(0.3),
              )
            ],
          ),
        ),
      ),
    );
  }
}