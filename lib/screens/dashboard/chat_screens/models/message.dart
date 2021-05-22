import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String uid;
  final String avatar;
  final String fullname;
  final String message;
  final DateTime createdAt;

  const Message({
    @required this.uid,
    @required this.avatar,
    @required this.fullname,
    @required this.message,
    @required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        uid: json['useruid'],
        avatar: json['avatar'],
        fullname: json['fullname'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'useruid': uid,
        'avatar': avatar,
        'fullname': fullname,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
