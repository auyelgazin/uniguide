import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatelessWidget {
  String category;
  String image;
  String sender;
  Timestamp sendTime;
  String title;
  var comments = [];
  int likes;

  PostCard(
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