import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_provider.dart';

class DashboardHelper with ChangeNotifier {
  DashboardController dc = DashboardController();
  int pageIndex = 0;

  Widget bottomNav(
      BuildContext context, int index, PageController pageController) {
    return Container(
      height: 90,
      child: CustomNavigationBar(
        backgroundColor: lightPurple,
        selectedColor: darPurple,
        unSelectedColor: white,

        currentIndex: index,
        // bubbleCurve: Curves.bounceIn,
        // scaleCurve: Curves.decelerate,
        onTap: (val) {
          index = val;
          pageController.jumpToPage(val);
          notifyListeners();
        },
        items: [
          CustomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/blog.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).blogT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          CustomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/chat.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).chatT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          CustomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('images/profile.png'),
            ),
            title: Text(
              Provider.of<DashboardProvider>(context, listen: false).profileT,
              style: TextStyle(fontWeight: FontWeight.w900, color: darPurple),
            ),
          ),
          CustomNavigationBarItem(
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
