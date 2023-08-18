import 'package:flutter/material.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/utils/styles.dart';

class BadgeAlert extends StatefulWidget {
  List<String> newBadges;

  BadgeAlert({required this.newBadges});

  @override
  State<BadgeAlert> createState() => _BadgeAlertState();
}

class _BadgeAlertState extends State<BadgeAlert> {
  bool moreThanOneBadge = false;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.newBadges.length > 1) {
      setState(() {
        moreThanOneBadge = true;
      });
    } else {
      setState(() {
        moreThanOneBadge = false;
      });
    }
  }

  Widget renderTrophyTiles(String badge) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 150,
      child: Column(
        children: [
          Expanded(
              child: Image.asset(
            'lib/utils/images/trophy.gif',
            fit: BoxFit.contain,
          )),
          Text("$badge",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Styles.deepgreen,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/utils/images/points_conf.png'),
                    fit: BoxFit.cover)),
            child: Column(children: [
              SizedBox(
                height: 35,
              ),
              CloseButton(
                onPressed: () {
                  setState(() {
                    MyNavigator(context).navigateToMainPage();
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text("Congratulations!",
                          style: TextStyle(
                              color: Styles.deepgreen,
                              fontSize: 30,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Align(
                                alignment: Alignment.center,
                                child: moreThanOneBadge
                                    ? Text("You have unlocked new badges! ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Styles.deepgreen,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        ))
                                    : Text("You have unlocked\n a new badge! ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Styles.deepgreen,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        )),
                              ))),
                    ],
                  )),
              SizedBox(height: 15),
              moreThanOneBadge
                  ? Container(
                      height: 300,
                      child: GridView.count(
                        crossAxisCount: widget.newBadges.length,
                        // Generate 100 widgets that display their index in the List.
                        children:
                            List.generate(widget.newBadges.length, (index) {
                          return renderTrophyTiles(widget.newBadges[index]);
                        }),
                      ),
                    )
                  : Container(
                      height: 350,
                      child: Column(
                        children: [
                          Image.asset('lib/utils/images/trophy.gif',
                              height: 300),
                          Text("${widget.newBadges[0]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Styles.deepgreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                    )
            ])),
      ]),
    ));
  }
}
