import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/services/storage_service.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:uniguide/services/firestore_service.dart';
import 'package:path/path.dart' as Path;

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController fullNameController = TextEditingController();

  DashboardController dashboardController = Get.put(DashboardController());

  String editedFullName;

  File imageFile;
  UploadTask task;

  String urlDownload;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  // final picker = ImagePicker();
  // String url;

  // chooseImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   print(pickedFile.path);

  //   setState(() {
  //     imageFile = File(pickedFile.path);
  //   });
  // }

  //  uploadFile() async {
  //   Reference storageRef = FirebaseStorage.instance
  //       .ref()
  //       .child('avatars/${Path.basename(imageFile.path)}');
  //   UploadTask uploadTask = storageRef.putFile(imageFile);

  //   var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //   url = imageUrl.toString();
  //   print(url);
  // }
  

  @override
  Widget build(BuildContext context) {
    final fileName =
        imageFile != null ? Path.basename(imageFile.path) : "No file selected";

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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(Provider.of<FirebaseOperations>(context, listen: false).getInitAvatar),
                    ),
                    // Obx(
                    //   () => Container(
                    //     child: dashboardController.avatar.value != null
                    //         ? Container(
                    //             child: CircleAvatar(
                    //               radius: 50.0,
                    //               backgroundImage: NetworkImage(
                    //                   dashboardController.avatar.value),
                    //               // backgroundImage:
                    //               //     FileImage(imageFile),
                    //               // child:
                    //               // FittedBox(child: Image.network('https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/avatars%2Fimage_picker3446361867049242902.jpg?alt=media&token=90777e73-9f3d-41cc-a30e-3b8d7fb4c181')),
                    //             ),
                    //           )
                    //         : Container(
                    //             child: CircleAvatar(
                    //               radius: 50.0,
                    //               child: Text(
                    //                 dashboardController.getInitials(dashboardController.fullName.value),
                    //               ),
                    //             ),
                    //           ),
                    //   ),
                    // ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () async {

                          await selectFile();
                          uploadFile();
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
                  child: task != null ? buildUploadStatus(task) : Container(),
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
                        hintText: dashboardController.fullName.value,
                        hidePassword: false,
                        controller: fullNameController,
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
                editedFullName = fullNameController.text.trim();

                if (editedFullName.length >= 3) {
                  dashboardController.fullName.value = editedFullName;
                  await FirestoreService(uid: auth.currentUser.uid)
                      .updateUserData(
                    fullName: editedFullName,
                    email: auth.currentUser.email,
                    position: dashboardController.position.value,
                  );
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

  Future selectFile() async {
    final result =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (result == null) return;

    final path = result.path;

    setState(() {
      imageFile = File(path);
    });
  }

  Future uploadFile() async {
    if (imageFile == null) return;

    final fileName = Path.basename(imageFile.path);
    final destination = 'avatars/$fileName';

    task = StorageService.uploadFile(destination, imageFile);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    dashboardController.avatar.value = urlDownload;

    await FirestoreService(uid: auth.currentUser.uid)
        .setAvatar(avatar: dashboardController.avatar.value);

    print('DOWNLOAD LINK => => => $urlDownload');
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
