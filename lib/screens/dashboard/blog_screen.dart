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
          Container(
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 160.0,
                  color: Colors.red,
                ),
                Container(
                  width: 160.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 160.0,
                  color: Colors.green,
                ),
                Container(
                  width: 160.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}