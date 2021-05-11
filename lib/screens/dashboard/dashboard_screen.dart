import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_provider.dart';
import 'package:uniguide/screens/dashboard/dashboard_helper.dart';
import 'blog_screens/blog_screen.dart';
import 'chat_screen.dart';
import 'profile_screens/profile_screen.dart';
import 'write_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dc = Get.put(DashboardController());
  final PageController pageController = PageController();

  var pages = [
    BlogScreen(),
    ChatScreen(),
    ProfileScreen(),
    WriteScreen(),
  ];

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {


            Provider.of<DashboardHelper>(context, listen: false).pageIndex =
                index;

            switch (Provider.of<DashboardHelper>(context, listen: false)
                .pageIndex) {
              case 0:
                {
                  Provider.of<DashboardProvider>(context, listen: false).blogT =
                      '__';
                  Provider.of<DashboardProvider>(context, listen: false).chatT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .profileT = '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .writeT = '';
                }
                break;
              case 1:
                {
                  Provider.of<DashboardProvider>(context, listen: false).blogT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false).chatT =
                      '__';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .profileT = '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .writeT = '';
                }
                break;
              case 2:
                {
                  Provider.of<DashboardProvider>(context, listen: false).blogT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false).chatT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .profileT = '__';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .writeT = '';
                }
                break;
              case 3:
                {
                  Provider.of<DashboardProvider>(context, listen: false).blogT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false).chatT =
                      '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .profileT = '';
                  Provider.of<DashboardProvider>(context, listen: false)
                      .writeT = '__';
                }
                break;
            }
          });
        },
      ),
      bottomNavigationBar: Provider.of<DashboardHelper>(context, listen: false)
          .bottomNav(
              context,
              Provider.of<DashboardHelper>(context, listen: false).pageIndex,
              pageController),
    );
  }
}
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {

//   @override
//   void initState() {
//     Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
//     // TODO: implement initState
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DashboardController>(
//       builder: (controller) {
//         return Scaffold(
//           body: SafeArea(
//             child: IndexedStack(
//               index: controller.tabIndex,
//               children: [
//                 BlogScreen(),
//                 ChatScreen(),
//                 ProfileScreen(),
//                 WriteScreen(),
//               ],
//             ),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             unselectedItemColor: Colors.white,
//             selectedItemColor: Color(0xFF232195),
//             onTap: controller.changeTabIndex,
//             currentIndex: controller.tabIndex,
//             showSelectedLabels: true,
//             showUnselectedLabels: false,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Color(0xFFB7C1F4),
//             elevation: 0,
//             items: [
//               /*

//               - - - - DONT DELETE - - - -

//               // BottomNavigationBarItem(
//               //   icon: SizedBox(
//               //     child: ImageIcon(
//               //       AssetImage('images/blog.png'),
//               //     ),
//               //     height: 50,
//               //   ),
//               //   label: '–'
//               // ),
//               // BottomNavigationBarItem(
//               //   icon: SizedBox(
//               //     child: ImageIcon(
//               //       AssetImage('images/chat.png'),
//               //     ),
//               //     height: 50,
//               //   ),
//               //   label: '–'
//               // ),
//               // BottomNavigationBarItem(
//               //   icon: SizedBox(
//               //     child: ImageIcon(
//               //       AssetImage('images/profile.png'),
//               //     ),
//               //     height: 50,
//               //   ),
//               //   label: '–'
//               // ),
//               // BottomNavigationBarItem(
//               //   icon: SizedBox(
//               //     child: ImageIcon(
//               //       AssetImage('images/write.png'),
//               //     ),
//               //     height: 50,
//               //   ),
//               //   label: '–'
//               // ), */
//               BottomNavigationBarItem(
//                 icon: Container(
//                   child: ImageIcon(
//                     AssetImage('images/blog.png'),
//                   ),
//                 ),
//                 label: '––',
//               ),
//               BottomNavigationBarItem(
//                 icon: ImageIcon(
//                   AssetImage('images/chat.png'),
//                 ),
//                 label: '––',
//               ),
//               BottomNavigationBarItem(
//                 icon: ImageIcon(
//                   AssetImage('images/profile.png'),
//                 ),
//                 label: '––',
//               ),
//               BottomNavigationBarItem(
//                 icon: ImageIcon(
//                   AssetImage('images/write.png'),
//                 ),
//                 label: '––',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
