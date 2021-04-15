import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 85,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFB7C1F4).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 85,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Shawn Carter',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '22:23',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF687684),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Also understand that, as humans, design can be emotional and stimulate the playful brain.',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Row(children: [
                                          Icon(
                                            Icons.comment_outlined,
                                            color: Color(0xFF687684),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            '46',
                                            style: TextStyle(
                                                color: Color(0xFF687684),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ]),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Row(children: [
                                          Icon(
                                            Icons.favorite_outline_rounded,
                                            color: Color(0xFF687684),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            '363',
                                            style: TextStyle(
                                                color: Color(0xFF687684),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ])
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.more_horiz),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
