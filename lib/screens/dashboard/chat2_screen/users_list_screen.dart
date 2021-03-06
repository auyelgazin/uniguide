import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/chat_screens/chat_screen.dart';
import 'package:uniguide/screens/dashboard/chat_screens/chat_sucareen.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/user.dart';
import 'package:uniguide/screens/dashboard/chat_screens/utils.dart';

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();

  // UsersList(this.users);
}

class _UsersListScreenState extends State<UsersListScreen> {
  TextEditingController _searchC = TextEditingController();

  String _searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Chat',
            style: titleStyle,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: black,
                  ),
                ),

                hintText: 'Search',
                fillColor: lightPurple.withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                // border:
              ),
              controller: _searchC,
              onChanged: (val) {
                setState(() {
                  _searchString = val.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 13),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: lightPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: StreamBuilder<List<UserModel>>(
                  stream: (_searchString == null || _searchString.trim() == '')
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .snapshots()
                          .transform(Utils.transformer(UserModel.fromJson))
                      : FirebaseFirestore.instance
                          .collection('users')
                          .where('searchIndex', arrayContains: _searchString)
                          .snapshots()
                          .transform(Utils.transformer(UserModel.fromJson)),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Something Went Wrong Try later');
                        } else {
                          final users = snapshot.data;

                          if (users.isEmpty) {
                            return Text('No Users Found');
                          } else
                            return ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    height: 45,
                                    child: GestureDetector(
                                      onTap: () {
                                        Provider.of<FirebaseOperations>(context, listen: false).addChat(Provider.of<Authentication>(context, listen: false).getUserUid, user.uid);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ChatScreen(user),
                                        ));
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: new Text(
                                        '${user.fullname} (${user.position})',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Color(0xFF2F2F32),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                    }
                  },
                ),
              ),
            ),
            //! DONT DELETE
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: (_searchString == null || _searchString.trim() == '')
            //         ? FirebaseFirestore.instance.collection('users').snapshots()
            //         : FirebaseFirestore.instance
            //             .collection('users')
            //             .where('searchIndex', arrayContains: _searchString)
            //             .snapshots()
            //             .transform(Utils.transformer(UserModel.fromJson)),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('has error');
            //       }
            //       switch (snapshot.connectionState) {
            //         case ConnectionState.waiting:
            //           return Container(
            //             margin: EdgeInsets.only(top: 15),
            //             decoration: BoxDecoration(
            //               color: lightPurple.withOpacity(0.3),
            //               borderRadius: BorderRadius.circular(15),
            //             ),
            //           );
            //         case ConnectionState.none:
            //           return Text('no data presented)');
            //         case ConnectionState.done:
            //           return Text('we are done');
            //         default:
            //           return Container(
            //             margin: EdgeInsets.only(top: 15),
            //             decoration: BoxDecoration(
            //               color: lightPurple.withOpacity(0.3),
            //               borderRadius: BorderRadius.circular(15),
            //             ),
            //             child: new ListView(
            //               children: snapshot.data.docs.map(
            //                 (DocumentSnapshot documentSnapshot) {
            //                   return Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 20),
            //                     child: Container(
            //                       alignment: Alignment.bottomLeft,
            //                       height: 45,
            //                       child: new Text(
            //                         '${documentSnapshot['fullname']} (${documentSnapshot['position']})',
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.w400,
            //                           fontSize: 18,
            //                           color: Color(0xFF2F2F32),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ).toList(),
            //             ),
            //           );
            //       }
            //     },
            //   ),
            // ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
