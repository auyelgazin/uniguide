import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uniguide/widgets/dashboard_widgets/comment_card.dart';

import '../constants/colors.dart';
import '../constants/consants.dart';
import '../constants/font_styles.dart';
import '../screens/dashboard/controllers/dashboard_controller.dart';
import 'authentication.dart';
import 'firebase_operations.dart';

class PostFunctions with ChangeNotifier {
  DashboardController dc = Get.put(DashboardController());

  String timePosted;
  String get getTimePosted => timePosted;

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();

    timeago.setLocaleMessages('ru', timeago.RuShortMessages());
    timeago.setLocaleMessages('en', timeago.EnShortMessages());

    timePosted = timeago.format(dateTime, locale: 'ru');

    // notifyListeners();
  }

  Future addLike(BuildContext context, String postId, String subDocId) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .get()
        .then((doc) {
      if (doc.exists) {
        print('user already liked');
      } else {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({'likes': FieldValue.increment(1)}).whenComplete(() {
          print('like++');
        });
        return FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(subDocId)
            .set({
          'likes': FieldValue.increment(1),
          'fullname': Provider.of<FirebaseOperations>(context, listen: false)
              .getInitFullname,
          'avatar': Provider.of<FirebaseOperations>(context, listen: false)
              .getInitAvatar,
          'useruid':
              Provider.of<Authentication>(context, listen: false).getUserUid,
          'email': Provider.of<FirebaseOperations>(context, listen: false)
              .geiInitEmail,
          'time': Timestamp.now()
        }).whenComplete(() {
          print('subCollection "likes" created for this post');
        });
      }
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'fullname': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitFullname,
      'avatar':
          Provider.of<FirebaseOperations>(context, listen: false).getInitAvatar,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'email':
          Provider.of<FirebaseOperations>(context, listen: false).geiInitEmail,
      'time': Timestamp.now()
    }).whenComplete(() {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'comments': FieldValue.increment(1)});
    });
  }

  showComments(BuildContext context, DocumentSnapshot snapshot, String docId) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(docId)
            .collection('comments')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
              Provider.of<PostFunctions>(context, listen: false)
                  .showTimeAgo(documentSnapshot.data()['time']);
              return CommentCard(
                sender: documentSnapshot.data()['fullname'],
                avatar: documentSnapshot.data()['avatar'],
                comment: documentSnapshot.data()['comment'],
                timeAgo: Provider.of<PostFunctions>(context, listen: false)
                    .getTimePosted
                    .toString(),
              );
            }).toList());
          }
        });
  }

  showLikes(BuildContext context, String docId) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(docId)
            .collection('likes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      child: documentSnapshot.data()['avatar'] == noAvatarUrl
                          ? CircleAvatar(
                              backgroundColor: darPurple,
                              child: Text(
                                dc.getInitials(
                                    documentSnapshot.data()['fullname']),
                                style: initialsStyle,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()['avatar']),
                            ),
                    ),
                    title: Text(documentSnapshot.data()['fullname']),
                  ),
                  Divider(),
                ],
              );
            }).toList());
          }
        });
  }
}
