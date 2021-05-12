import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/provider_files/survey_functions.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List surveysList = [];
  bool isTeacherOrStuff;

  @override
  void initState() {
    getSurveys();
    checkPosition();
    super.initState();
  }

  getSurveys() async {
    dynamic result =
        await Provider.of<SurveyFunctions>(context, listen: false).getSurveys();

    if (result == null) {
      print('cannot fetch surveys');
    } else {
      setState(() {
        surveysList = result;
      });
    }
  }

  checkPosition() {
    String position =
        Provider.of<FirebaseOperations>(context, listen: false).getInitPosition;

    if (position == 'Teacher' || position == 'Stuff') {
      isTeacherOrStuff = true;
    } else {
      isTeacherOrStuff = false;
    }
    print(position);
    print(isTeacherOrStuff);
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
          'Survey',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            isTeacherOrStuff
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add survey', style: loginSignupInfo,),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {},
                      ),
                    ],
                  )
                : Text('Take Survey', style: loginSignupInfo,),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(surveysList[index]['name']),
                      Text(surveysList[index]['link']),
                    ],
                  );
                },
                itemCount: surveysList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
