import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniguide/screens/dashboard/models/sender.dart';

class Comment{
  String comment;
  Timestamp sendTime;
  Sender sender;

  Comment(this.comment, this.sendTime, this.sender);

}