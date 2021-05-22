import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/message.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/user.dart';
import 'package:uniguide/screens/dashboard/chat_screens/utils.dart';

class FirebaseApi {
  // static Stream<List<User>> getUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .transform(Utils.transformer(User.fromJson));

  // static Future uploadMessage(String uid, String message) async{

  //   final refMessage = FirebaseFirestore.instance.collection('chats/$uid/messages');

  //   final newMessage = Message(
  //     uid: Provider.of<Authentication>().getUserUid;
  //   );
  // }
}
