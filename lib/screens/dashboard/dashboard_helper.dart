import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class DashboardHelper with ChangeNotifier{
  DashboardController dc = DashboardController();

  Widget bottomNav(BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      onTap: (val){
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      items: [
        CustomNavigationBarItem(icon: Icon(Icons.home)),
        CustomNavigationBarItem(icon: Icon(Icons.chat)),
        // CustomNavigationBarItem(icon: CircleAvatar(child: Text(dc.getInitials(Provider.of<FirebaseOperations>(context, listen: false).getInitFullname),))),
        CustomNavigationBarItem(icon: Icon(Icons.note_add)),
      ],
    );
  }
}