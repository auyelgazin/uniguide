import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'blog_screens/blog_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'write_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {

//   int _currentIndex = 0;

//   var tabs = [
//     BlogScreen(),
//     ChatScreen(),
//     ProfileScreen(),
//     WriteScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: tabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFFB7C1F4),
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             label: 'sd',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.add,
//             ),
//             label: 'ssad',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.chat,
//             ),
//             label: 'sas',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.chat,
//             ),
//             label: 'sas',
//           ),

//         ],
//         onTap: (index){
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
    // TODO: implement initState
    super.initState();
    
  }
  
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
              // BottomNavigationBarItem(
              //   icon: SizedBox(
              //     child: ImageIcon(
              //       AssetImage('images/blog.png'),
              //     ),
              //     height: 50,
              //   ),
              //   label: '–'
              // ),
              // BottomNavigationBarItem(
              //   icon: SizedBox(
              //     child: ImageIcon(
              //       AssetImage('images/chat.png'),
              //     ),
              //     height: 50,
              //   ),
              //   label: '–'
              // ),
              // BottomNavigationBarItem(
              //   icon: SizedBox(
              //     child: ImageIcon(
              //       AssetImage('images/profile.png'),
              //     ),
              //     height: 50,
              //   ),
              //   label: '–'
              // ),
              // BottomNavigationBarItem(
              //   icon: SizedBox(
              //     child: ImageIcon(
              //       AssetImage('images/write.png'),
              //     ),
              //     height: 50,
              //   ),
              //   label: '–'
              // ),
              BottomNavigationBarItem(
                icon: Container(
                  child: ImageIcon(
                    AssetImage('images/blog.png'),
                  ),
                ),
                label: '––',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('images/chat.png'),
                ),
                label: '––',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('images/profile.png'),
                ),
                label: '––',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('images/write.png'),
                ),
                label: '––',
              ),
            ],
          ),
        );
      },
    );
  }
}
