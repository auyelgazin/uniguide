import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IosImage extends StatefulWidget {
  @override
  
  _IosImageState createState() => _IosImageState();
}


class _IosImageState extends State<IosImage> {

  PickedFile imageUrl;
  final ImagePicker _imagePicker = ImagePicker();

  Future getImageFromGallery() async {
    var image = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Container(
        child: imageUrl == null ? Text('No image') : Image.file(File(imageUrl.path)),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.perm_media_outlined),
        onPressed: (){
          getImageFromGallery();
        },
      ),
    );
  }
}