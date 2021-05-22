import 'package:meta/meta.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserModel {
  final String uid;
  final String fullname;
  final String avatar;
  final String position;
  final List<dynamic> searchIndex;

  const UserModel({
    this.uid,
    @required this.fullname,
    @required this.avatar,
    this.position,
    this.searchIndex,
  });

  UserModel copyWith({
    String uid,
    String fullname,
    String avatar,
    String position,
    List<dynamic> searchIndex,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        fullname: fullname ?? this.fullname,
        avatar: avatar ?? this.avatar,
        position: position ?? this.position,
        searchIndex: searchIndex ?? this.searchIndex,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['useruid'],
        fullname: json['fullname'],
        avatar: json['avatar'],
        position: json['position'],
        searchIndex: json['searchIndex']

      );

  Map<String, dynamic> toJson() => {
        'useruid': uid,
        'fullname': fullname,
        'avatar': avatar,
        'position': position,
        'searchIndex': searchIndex
      };
}