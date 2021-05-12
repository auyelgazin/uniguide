import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SurveyFunctions with ChangeNotifier {
  Future getSurveys() async {
    List surveys = [];

    try {
      await FirebaseFirestore.instance.collection('surveys').orderBy('time', descending: true).get().then((snap) {
        snap.docs.forEach((element) {
          surveys.add(element.data());
        });
      });
      return surveys;
    } catch (e) {
      print(e.toString());
    }
  }

  Future addSurvey(String doc, String link) async {
    try {
      await FirebaseFirestore.instance.collection('surveys').doc(doc).set({
        'name': doc,
        'link': link,
        'time': Timestamp.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
