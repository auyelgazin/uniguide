import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_provider.dart';

class DashboardHelper with ChangeNotifier {
  DashboardController _dc = DashboardController();
  int pageIndex = 0;

  void goToBlog(){
    pageIndex = 0;
    notifyListeners();
  }
  Widget bottomNav(
      BuildContext context, int index, PageController pageController) {
    return Container(
      height: 90,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darPurple,
        unselectedItemColor: white,
        backgroundColor: lightPurple,
        currentIndex: index,
        onTap: (val) {
          index = val;
          pageController.jumpToPage(val);
          notifyListeners();
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/blog.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).blogT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/chat.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).chatT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/profile.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).profileT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/write.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).writeT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
            // label: '––',
          ),

          // avatar instead of "person" icon
          // CustomNavigationBarItem(icon: CircleAvatar(backgroundImage: NetworkImage(Provider.of<FirebaseOperations>(context, listen: false).getInitAvatar))),
        ],
      ),
    );
  }
}
