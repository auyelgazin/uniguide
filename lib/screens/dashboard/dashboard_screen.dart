import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'blog_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'write_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                BlogScreen(),
                ChatScreen(),
                ProfileScreen(),
                WriteScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Color(0xFF232195),
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFFB7C1F4),
            elevation: 0,
            items: [
              // _bottomNavigationBarItem(
              //   icon: CupertinoIcons.home,
              //   label: 'Home',
              // ),
              // _bottomNavigationBarItem(
              //   icon: CupertinoIcons.sportscourt,
              //   label: 'News',
              // ),
              // _bottomNavigationBarItem(
              //   icon: CupertinoIcons.bell,
              //   label: 'Alerts',
              // ),
              // _bottomNavigationBarItem(
              //   icon: CupertinoIcons.person,
              //   label: 'Account',
              // ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: ImageIcon(
                    AssetImage('images/blog.png'),
                  ),
                  height: 50,
                ),
                label: '––'
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: ImageIcon(
                    AssetImage('images/chat.png'),
                  ),
                  height: 50,
                ),
                label: '––'
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: ImageIcon(
                    AssetImage('images/profile.png'),
                  ),
                  height: 50,
                ),
                label: '––'
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: ImageIcon(
                    AssetImage('images/write.png'),
                  ),
                  height: 50,
                ),
                label: '––'
              ),
            ],
          ),
        );
      },
    );
  }

  // _bottomNavigationBarItem({IconData icon, String label}) {
  //   return BottomNavigationBarItem(
  //     icon: Icon(icon),
  //     label: label,
  //   );
  // }
}
