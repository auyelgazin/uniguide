import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:uniguide/widgets/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'welcome_screen.dart';
import 'package:uniguide/widgets/lang_button.dart';

LanguageController _controller = Get.put(LanguageController());

class ChooseLangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'choose'.tr,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          LangButton(
            langID: 'en',
            region: 'US',
            assetImage: 'images/en.png',
            langName: 'English  ',
            languageController: _controller,
          ),
          SizedBox(
            height: 21,
          ),
          LangButton(
            langID: 'ru',
            region: 'RU',
            assetImage: 'images/ru.png',
            langName: 'Русский',
            languageController: _controller,
          ),
          SizedBox(
            height: 21,
          ),
          LangButton(
            langID: 'kz',
            region: 'KZ',
            assetImage: 'images/kz.png',
            langName: 'Қазақша',
            languageController: _controller,
          ),
        ],
      ),
    );
  }
}

// class LangButton extends StatelessWidget {
//   final String langID;
//   final String region;
//   final String assetImage;
//   final String langName;

//   LangButton({this.langID, this.region, this.assetImage, this.langName});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _controller.changeLanguage(langID, region);
//         Get.to(() => WelcomeScreen());
//       },
//       child: WideButtonBox(
//         Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFB7C1F4),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: 5,
//               ),
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: AssetImage(assetImage),
//                     maxRadius: 15,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     langName,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF141619),
//                     ),
//                   ),
//                 ],
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 color: Color(0xFF232195).withOpacity(0.5),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
