import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/dashboard/models/comment.dart';
import 'package:uniguide/screens/dashboard/models/sender.dart';

class BlogModel{

  // String blogID;
  String category;
  String title;
  Timestamp sendTime;
  Sender sender;
  int likes;
  var comments = [Comment];

  BlogModel(this.category, this.title, this.sendTime, this.sender, this.likes, this.comments);

  BlogModel.fromJson(Map<dynamic, dynamic> map){
    if (map == null) {
      return;
    }
    else{
      category = map['category'];
      title = map['title'];
      sendTime = map['sendTime'];
      sender = map['sender'];
      likes = map['likes'];
      comments = map['comments'];

    }
  }

  toJson() {
    return {
      'category': category,
      'title': title,
      'sendTime': sendTime,
      'sender': sender,
      'likes': likes,
      'comments': comments
    };
  }



}