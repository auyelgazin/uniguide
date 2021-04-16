import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/blog_controller.dart';
import 'package:uniguide/screens/dashboard/models/dashboard_model.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatelessWidget {
  BlogController controller = BlogController();
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
          // GetBuilder<DashboardModel>(
          //   builder: (controller) => Container(

          //   ),
          // )
          Container(
            height: 670,
            child: GetBuilder<BlogController>(
              init: BlogController(),
              builder: (value) {
                return FutureBuilder(
                    future: value.getData('blogs'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext, int index) {
                            return BlogCard(
                              category: snapshot.data[index].data()['category'],
                              image: snapshot.data[index].data()['sender']
                                  ['image'],
                              sender: snapshot.data[index].data()['sender']
                                  ['fullName'],
                              sendTime: snapshot.data[index].data()['sendTime'],
                              title: snapshot.data[index].data()['title'],
                              comments: snapshot.data[index].data()['comments'],
                              likes: snapshot.data[index].data()['likes'],
                            );
                          },
                        );
                      }
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  String category;
  String image;
  String sender;
  Timestamp sendTime;
  String title;
  var comments = [];
  int likes;

  BlogCard(
      {this.category,
      this.image,
      this.sender,
      this.sendTime,
      this.title,
      this.comments,
      this.likes});

  String timeStampToDate(Timestamp timeStamp) {
    var date = timeStamp.toDate();
    String month = DateFormat.d().add_MMM().format(date).toString();
    String day = DateFormat.Hm().format(date).toString();
    return '$month, $day';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: CircleAvatar(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 87,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB7C1F4).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          sender,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          timeStampToDate(sendTime),
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
                                      title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(children: [
                                  InkWell(
                                    child: Row(children: [
                                      ImageIcon(
                                          AssetImage('images/comment.png')),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        comments.length.toString(),
                                        style: TextStyle(
                                            color: Color(0xFF687684),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ]),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('images/like.png'),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          likes.toString(),
                                          style: TextStyle(
                                              color: Color(0xFF687684),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  )
                                ])
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            splashColor: Color(0xFFB7C1F4),
                            child: Icon(
                              Icons.more_horiz,
                              color: Color(0xFF232195),
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
      ),
    );
  }
}
