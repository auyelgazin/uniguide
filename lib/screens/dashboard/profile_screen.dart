import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Text('Profile', style: titleStyle),
          ),
          SizedBox(
            height: 35,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(0, 24),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 30,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Gapuova Madina',
                                    style: fullNameStyle,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '170170170',
                                    style: positionStyle,
                                  ),
                                  Text(
                                    'Information Systems',
                                    style: positionStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.5),
                        child: Divider(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ProfileButton(
                                    avatarImage: 'images/account.png',
                                    title: 'Personal Data',
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.5),
                                    child: Divider(),
                                  ),
                                  ProfileButton(
                                    avatarImage: 'images/settings.png',
                                    title: 'Settings',
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.5),
                                    child: Divider(),
                                  ),
                                  ProfileButton(
                                    avatarImage: 'images/lang.png',
                                    title: 'Language',
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.5),
                                    child: Divider(),
                                  ),
                                  ProfileButton(
                                    avatarImage: 'images/survey.png',
                                    title: 'Survey',
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.5),
                                    child: Divider(),
                                  ),
                                ],
                              ),
                              Text('sd')
                              // GestureDetector(
                              //   child: Expanded(
                              //     child: Container(
                              //       height: 50,
                              //       decoration: BoxDecoration(
                              //         color: Color(0xFFF2F3F2),
                              //       ),
                              //       child: Row(
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Image.asset(
                              //             'images/logout.png',
                              //             height: 20,
                              //           ),
                              //           Text(
                              //             'Log Out',
                              //             style: TextStyle(
                              //               fontSize: 18,
                              //               fontWeight: FontWeight.w400,
                              //               color: Color(0xFF232195),
                              //             ),
                              //           ),
                              //           SizedBox(width: 20)
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   onTap: () {},
                              // ),
                            ],
                          ),
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
    );
  }
}

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
