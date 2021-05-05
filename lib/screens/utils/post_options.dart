import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class PostFunctions{

  DashboardController dashboardController = Get.put(DashboardController());

  Future addLike(BuildContext context, String postID, String subDocID) async{
    return FirebaseFirestore.instance.collection('posts').doc(
      postID
    ).collection('likes').doc(subDocID).set(
      {
        'likes': FieldValue.increment(1),
        'fullName': dashboardController.fullName,
      }
    );
  }
}