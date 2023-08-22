import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/pages/booklet_page.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/profile_page.dart';
import 'package:bach_thes/views/pages/statistics_page.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
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
  int currentIndex = 1;

  //function that collects the data from firebase about the current user
  getHiker() async {
    var profiles = await FirebaseFirestore.instance
        .collection('Hikers')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    var arrayOfBadges =
        profiles.docs.first['badges']; // array is now List<dynamic>
    List<String> stringsOfBadges = List<String>.from(arrayOfBadges);

    var arrayOfRecentSearches = profiles.docs.first['recentSearches'];
    List<String> recentSearches = List<String>.from(arrayOfRecentSearches);

    var arrayOfMountainChain = profiles.docs.first['mountainChain'];
    List<String> mountainChain = List<String>.from(arrayOfMountainChain);

    setCurrentHiker(
        profiles.docs.first['id'],
        profiles.docs.first['username'],
        profiles.docs.first['email'],
        profiles.docs.first['level'],
        profiles.docs.first['points'],
        profiles.docs.first['numberOfHikes'],
        profiles.docs.first['altimetersTogheter'],
        profiles.docs.first['timeTogheter'],
        profiles.docs.first['scoreboardParticipation'],
        stringsOfBadges,
        recentSearches,
        profiles.docs.first['distanceTogheter'],
        mountainChain,
        profiles.docs.first['pictureUrl']);
  }

  checkPrefsForBadges() async {
    List<String> finalBadges = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('checkForNewBadges') == true) {
      finalBadges = prefs.getStringList('newBadges')!;
      prefs.setBool('checkForNewBadges', false);
      prefs.remove('newBadges');
    }

    if (finalBadges.length > 0) {
      MyNavigator(context).navigateToBadgeAlert(finalBadges);
    }
  }

  @override
  void initState() {
    getHiker();
    checkPrefsForBadges();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List pages = [ProfilePage(), SearchPeaks(), BookletPage(), StatisticsPage()];

  List titles = [
    "My profile",
    "Search Slovenian Peaks",
    "My hiking booklet",
    "Statistics"
  ];

  @override
  Widget build(BuildContext context) {
    void onTap(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      appBar: myAppBar(titles[currentIndex]),
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

  Future<void> setCurrentHiker(
      String id,
      String username,
      String email,
      int level,
      int points,
      int numberOfHikes,
      double altimetersTogheter,
      int timeTogheter,
      bool scoreboardParticipation,
      List<String> badges,
      List<String> recentSearches,
      double distanceTogheter,
      List<String> mountainChain,
      String pictureUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setInt('level', level);
    prefs.setInt('points', points);
    prefs.setInt('numberOfHikes', numberOfHikes);
    prefs.setInt('timeTogheter', timeTogheter);
    prefs.setDouble('altimetersTogheter', altimetersTogheter);
    prefs.setBool('scoreboardParticipation', scoreboardParticipation);
    prefs.setBool('isLoggedIn', true);
    prefs.setStringList('badges', badges);
    prefs.setStringList('recentSearches', recentSearches);
    prefs.setDouble('distanceTogheter', distanceTogheter);
    prefs.setStringList('mountainChain', mountainChain);
    prefs.setString('pictureUrl', pictureUrl);
    print("SET IN PREFSS: ${prefs.getString('pictureUrl')}");
  }
}
