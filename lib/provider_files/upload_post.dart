import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/colors.dart';

class UploadPost with ChangeNotifier {
  selectPostType(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.width / 2 + 40,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      color: Colors.red,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      color: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
