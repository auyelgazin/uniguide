import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';
import 'package:uniguide/services/firestore_service.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _fullNameController = TextEditingController();

  String _editedFullName;

  DashboardController _dc = Get.put(DashboardController());

  final snackBar = SnackBar(content: Text('Profile avatar updated!'));

  File _file;
  String _imageUrl;

  Future selectFile(ImageSource source) async {
    var result =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: source, imageQuality: 40);

    if (result == null)
      _file = null;
    else {
      final path = result.path;
      setState(() {
        _file = File(path);
      });
    }
  }

  Future sendImage() async {
    var storageImage = FirebaseStorage.instance.ref().child(_file.path);
    var task = storageImage.putFile(_file);
    _imageUrl = await (await task).ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF232195),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'Personal Data',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Provider.of<FirebaseOperations>(context, listen: false)
                                .getInitAvatar ==
                            noAvatarUrl
                        ? CircleAvatar(
                            backgroundColor: darPurple,
                            radius: 50,
                            child: Text(
                              _dc.getInitials(Provider.of<FirebaseOperations>(
                                      context,
                                      listen: false)
                                  .getInitFullname),
                              style: TextStyle(
                                fontSize: 30,
                                color: white,
                              ),
                            ),
                          )
                        : (_file == null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    Provider.of<FirebaseOperations>(context,
                                            listen: false)
                                        .getInitAvatar),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(_file),
                              )),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () async {
                          print('updating user avatar...');
                          try {
                            selectFile(ImageSource.gallery).whenComplete(() {
                              print('image selected');
                              // Get.defaultDialog();
                              sendImage().whenComplete(() {
                                print('image sent to FStorage');
                                Provider.of<FirebaseOperations>(context,
                                        listen: false)
                                    .updateAvatar(context, {
                                  'avatar': _imageUrl,
                                });
                              });
                            });
                          } catch (e) {
                            print(e);
                            return null;
                          }
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFB7C1F4),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ImageIcon(
                            AssetImage('images/camera.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  height: 20,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 4),
                        child: Text('Your name'),
                      ),
                      AuthTextField(
                        labelText: null,
                        hintText: Provider.of<FirebaseOperations>(context,
                                listen: false)
                            .getInitFullname,
                        hidePassword: false,
                        controller: _fullNameController,
                        trailingIcon: null,
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: AuthButton(
              'Save',
              () async {
                _editedFullName = _fullNameController.text.trim();

                List<String> indexList = [];

                getFullameIndex(String fullname) {
                  List<String> splitList = fullname.split(' ');

                  indexList.add(fullname.toLowerCase());
                  for (int i = 0; i < splitList.length; i++) {
                    for (int j = 0; j <= splitList[i].length; j++) {
                      indexList.add(splitList[i].substring(0, j).toLowerCase());
                    }
                  }
                }
                getFullameIndex(_editedFullName);

                if (_editedFullName.length >= 3) {
                  await FirestoreService(uid: _auth.currentUser.uid)
                      .updateFullname(
                    fullName: _editedFullName,
                    searchIndex: indexList,
                  ).whenComplete(() {
                    
                    Provider.of<FirebaseOperations>(context, listen: false).getInitFullname;
                    setState(() {
                      
                    });
                  });
                  Get.back();
                }
                // updateUserData()
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(1);

            if (progress != 1.0) {
              print(progress);
              return Text(
                'Picture uploading: $percentage %',
                style: positionStyle,
              );
            } else
              return Container();
          } else
            return Container();
        },
      );
}
