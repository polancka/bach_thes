import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/map_page.dart';
import 'package:bach_thes/views/pages/profile_page.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

/*Main page serves as a frame for navigating between pages using the bottom 
navigation bar. It also features a custom drawer and a custom app bar, which 
are defined in views/widgets/resuable_widgets.dart */

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 3;
  var thisUserId;

  @override
  Widget build(BuildContext context) {
    setState(() {
      thisUserId = FirebaseAuth.instance.currentUser?.uid;
    });

    List pages = [HomePage(), MapPage(), SearchPeaks(), ProfilePage()];

    void onTap(int index) {
      print(currentIndex);
      setState(() {
        currentIndex = index;
        thisUserId = FirebaseAuth.instance.currentUser?.uid;
      });
    }

    return Scaffold(
      appBar: myAppBar(""),
      drawer: myDrawer(context),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Styles.lightgreen,
        //backgroundColor: Colors.amber,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
