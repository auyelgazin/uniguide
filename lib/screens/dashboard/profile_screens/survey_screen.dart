import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/provider_files/survey_functions.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List surveysList = [];
  bool isTeacherOrStuff;

  TextEditingController nameC = TextEditingController();
  TextEditingController linkC = TextEditingController();

  @override
  void initState() {
    getSurveys();
    checkPosition();
    super.initState();
  }

  openURL(String url) async{

    if (await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'coulndt launch url: $url';
    }
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
                      Text(
                        'Add survey',
                        style: loginSignupInfo,
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          // Provider.of<SurveyFunctions>(context, listen: false).addSurvey(doc, link)
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 40,
                                        child: IconButton(
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Add the description',
                                              style: surveyInfo,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 36,
                                              child: TextField(
                                                controller: nameC,
                                                textAlignVertical:
                                                    TextAlignVertical.bottom,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  fillColor: lightPurple
                                                      .withOpacity(0.5),
                                                  filled: true,
                                                  hintText:
                                                      'Ex: Beta Career Survey',
                                                  hintStyle: commentHint,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Paste the link',
                                              style: surveyInfo,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 36,
                                              child: TextField(
                                                controller: linkC,
                                                textAlignVertical:
                                                    TextAlignVertical.bottom,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  fillColor: lightPurple
                                                      .withOpacity(0.5),
                                                  filled: true,
                                                  hintText: 'Link has to start with "https://"',
                                                  hintStyle: commentHint,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: AuthButton(
                                          'Add',
                                          () {
                                            if (nameC.text.trim() != null &&
                                                linkC.text.trim().startsWith('https://')) {
                                              Provider.of<SurveyFunctions>(
                                                      context,
                                                      listen: false)
                                                  .addSurvey(nameC.text.trim(),
                                                      linkC.text.trim())
                                                  .whenComplete(() {
                                                print('Survey added');
                                                getSurveys();
                                                nameC.clear();
                                                linkC.clear();
                                                setState(() {});
                                              }).whenComplete(() {
                                                Get.back();
                                              });
                                            } else {
                                              print('fill all fields');
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  )
                : Text(
                    'Take Survey',
                    style: loginSignupInfo,
                  ),
             SizedBox(
                    height: 25,
                  ),     
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surveysList[index]['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF121212),
                        ),
                      ),
                      SizedBox(height: 5,),
                      InkWell(
                        onTap: () {
                          openURL(surveysList[index]['link']);
                        },
                                              child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: lightPurple.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(child: Text(surveysList[index]['link'])),
                        ),
                      ),
                      SizedBox(height: 20,),
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
