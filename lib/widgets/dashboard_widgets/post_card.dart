import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class PostCard extends StatefulWidget {
  String category;
  // String image;
  String sender;
  // Timestamp sendTime;
  String title;
  // var comments = [];
  // int likes;
  Function onComment;
  Function onLike;

  Widget likes;

  PostCard({
    this.category,
    // this.image,
    this.sender,
    // this.sendTime,
    this.title,
    this.onComment,
    this.onLike,
    this.likes,
    // this.comments,
    // this.likes
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String timeStampToDate(Timestamp timeStamp) {
    var date = timeStamp.toDate();
    String month = DateFormat.d().add_MMM().format(date).toString();
    String day = DateFormat.Hm().format(date).toString();
    return '$month, $day';
  }

  DashboardController dashboardController = Get.put(DashboardController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dashboardController.getCurrentProfile();
  // }

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
                  Container(
                    child: CircleAvatar(
                      child: Text(
                        dashboardController.getInitials(widget.sender),
                      ),
                    ),
                    // child: widget.image != null
                    //     ? Container(
                    //         child: CircleAvatar(

                    //           backgroundImage: NetworkImage(widget.image),
                    //           // child:
                    //           // FittedBox(child: Image.network('https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/avatars%2Fimage_picker3446361867049242902.jpg?alt=media&token=90777e73-9f3d-41cc-a30e-3b8d7fb4c181')),
                    //         ),
                    //       )
                    //     : Container(
                    //         child: CircleAvatar(
                    //           child: Text(
                    //             dashboardController.getInitials(widget.sender),
                    //           ),
                    //         ),
                    //       ),
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
                                          widget.sender,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '12 Hours ago',
                                          // timeStampToDate(sendTime),
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
                                      widget.title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(children: [
                                  InkWell(
                                    onTap: widget.onComment,
                                    child: Row(children: [
                                      ImageIcon(
                                          AssetImage('images/comment.png')),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        '12',
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
                                    onTap: widget.onLike,
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('images/like.png'),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        widget.likes,
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
