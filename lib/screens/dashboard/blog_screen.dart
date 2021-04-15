import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Blogs', style: titleStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                      icon: ImageIcon(
                        AssetImage('images/filter.png'),
                      ),
                      color: Color(0xFF232195),
                      iconSize: 20,
                      onPressed: () {
                        Get.bottomSheet(Container(
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                WideButtonBox(
                                  ElevatedButton(
                                    child: Text(
                                      'Choose',
                                      style: TextStyle(
                                          color: Color(0xFF141619),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFB7C1F4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(),
                ),
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xFFB7C1F4).withOpacity(0.3),
                    borderRadius: new BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('Name sur'),
                          Text('23:34'),
                          IconButton(icon: Icon(Icons.more), onPressed: () {})
                        ],
                      ),
                      Container(
                        width: 200,
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'disahdiashiud dsahudhau hsauhdusa hhdsuahduahudhushaud udh ausdhuas disahuidhasuidhudhuhdasd usdahduisa',
                            textAlign: TextAlign.left,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
