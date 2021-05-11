import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/survey_functions.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List surveysList = [];

  @override
  void initState() {
    getSurveys();
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
              // Get.back();
              print(surveysList);
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
      body: Container(
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
    );
  }
}
