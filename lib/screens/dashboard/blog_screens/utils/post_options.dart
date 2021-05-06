import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/widgets/dashboard_widgets/comment_card.dart';

class PostFunctions {
  DashboardController dashboardController = Get.put(DashboardController());
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController commentController = TextEditingController();

  Future addLike(BuildContext context, String postID, String subDocID) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(subDocID)
        .set({
      'likes': FieldValue.increment(1),
      'fullName': dashboardController.fullName.value,
      'avatar': dashboardController.avatar.value,
      'uid': auth.currentUser.uid,
      'time': Timestamp.now(),
    });
  }

  Future addComment(BuildContext context, String postID, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'fullName': dashboardController.getFullName(),
      'avatar': dashboardController.getAvatar(),
      'uid': auth.currentUser.uid,
      'time': Timestamp.now(),
    });
  }

  

  showCommentsPage(
      BuildContext context, DocumentSnapshot snapshot, String docID) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              Text('Comments Section: '),
              Container(
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(docID)
                      .collection('comments')
                      .orderBy('time')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      );
                    } else {
                      return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot documentSnapshot) {
                        return CommentCard(
                          sender: documentSnapshot.data()['fullName'],
                          image: documentSnapshot.data()['avatar'],
                          comment: documentSnapshot.data()['comment'],
                        );
                      }).toList());
                    }
                  },
                ),
              ),
              // Container(
              //   height: 60,
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     children: [
              //       TextField(
              //         controller: commentController,
              //       ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Icon(Icons.send),
              //       // )
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
