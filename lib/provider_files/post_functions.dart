import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uniguide/widgets/dashboard_widgets/comment_card.dart';

import 'authentication.dart';
import 'firebase_operations.dart';

class PostFunctions with ChangeNotifier {

  String timePosted;
  String get getTimePosted => timePosted;

  showTimeAgo(dynamic timedata){
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    timePosted = timeago.format(dateTime);
    print(timePosted);
    notifyListeners();
  }

  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'fullname': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitFullname,
      'avatar':
          Provider.of<FirebaseOperations>(context, listen: false).getInitAvatar,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'email':
          Provider.of<FirebaseOperations>(context, listen: false).geiInitEmail,
      'time': Timestamp.now()
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
              return CommentCard(
                sender: documentSnapshot.data()['fullname'],
                avatar: documentSnapshot.data()['avatar'],
                comment: documentSnapshot.data()['comment'],
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
              children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(documentSnapshot.data()['avatar']),
                  ),
                  title: Text(documentSnapshot.data()['fullname']),
                );
              }).toList()
            );
          }
        });
  }
}
