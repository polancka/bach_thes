import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/pages/booklet_page.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/map_page.dart';
import 'package:bach_thes/views/pages/profile_page.dart';
import 'package:bach_thes/views/pages/statistics_page.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Main page serves as a frame for navigating between pages using the bottom 
navigation bar. It also features a custom drawer and a custom app bar, which 
are defined in views/widgets/resuable_widgets.dart */

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _emailSharedPref;

  int currentIndex = 3;
  var thisUserId;

  //function that collects the data from firebase about the current user
  getHiker() async {
    setState(() {
      thisUserId = FirebaseAuth.instance.currentUser?.uid;
    });
    var profiles = await FirebaseFirestore.instance
        .collection('Hikers')
        .where('id', isEqualTo: thisUserId)
        .get();
    var profilestwo = profiles.docs;
    for (var userSnapshot in profilestwo) {
      //error when running : "Another exception was thrown: NoSuchMethodError: The getter 'username' was called on null." but it does load
      setState(() {
        currentHiker = Hiker(
            id: userSnapshot['id'].toString(),
            username: userSnapshot['username'].toString(),
            email: userSnapshot['email'].toString(),
            profilePicture: userSnapshot['pictureUrl'].toString(),
            level: userSnapshot['level'].toString(),
            points: userSnapshot['points'].toString(),
            bookletId: userSnapshot['bookletId'].toString(),
            scoreboardParticipation:
                userSnapshot['scoreboardParticipation'].toString());
      });
    }
  }

  Future<void> _updateString() async {
    final SharedPreferences prefs = await _prefs;
    final String newEmail = "alo";

    setState(() {
      _emailSharedPref =
          prefs.setString('email', newEmail).then((bool success) {
        return newEmail;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(prefs.getString("email"));
    getHiker();

    List pages = [
      ProfilePage(),
      SearchPeaks(),
      BookletPage(),
      StatisticsPage()
    ];

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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Booklet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}
