import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportz_management/admin/event_add.dart';

import '../screens/admin_screen.dart';
import '../utils/colors.dart';
import 'results_add.dart';

// const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
// const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
// const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
// const blueColor = Color.fromRGBO(0, 149, 246, 1);
// const primaryColor = Colors.white;
// const secondaryColor = Colors.grey;

List<Widget> homeScreenItems = [
  const AdminScreen(),
  const EventAdd(),
  const ResultAdd(),
  const EventAdd(),
  const ResultAdd(),
  // HistoryScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];

class AdminNavScreen extends StatefulWidget {
  const AdminNavScreen({Key? key}) : super(key: key);

  @override
  State<AdminNavScreen> createState() => _AdminNavScreenState();
}

class _AdminNavScreenState extends State<AdminNavScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.event_available,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.checklist_rtl_outlined,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.history_outlined,
          //     color: (_page == 3) ? primaryColor : secondaryColor,
          //   ),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person,
          //     color: (_page == 4) ? primaryColor : secondaryColor,
          //   ),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
