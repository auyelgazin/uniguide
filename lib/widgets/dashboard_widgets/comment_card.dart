import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class CommentCard extends StatelessWidget {

  // String image;
  String sender;
  String avatar;
  // Timestamp sendTime;
  String comment;
  String timeAgo;


  CommentCard({
    // this.image,
    this.sender,
    this.avatar,
    // this.sendTime,
    this.comment,
    this.timeAgo,

  });

  String timeStampToDate(Timestamp timeStamp) {
    var date = timeStamp.toDate();
    String month = DateFormat.d().add_MMM().format(date).toString();
    String day = DateFormat.Hm().format(date).toString();
    return '$month, $day';
  }

  DashboardController dc = Get.put(DashboardController());

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
                    child: avatar == noAvatarUrl
                        ? CircleAvatar(
                          backgroundColor: darPurple,
                            child: Text(
                              dc.getInitials(sender),
                              style: initialsStyle,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(avatar),
                          ),
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
                                          timeAgo,
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
                                      comment,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                
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
