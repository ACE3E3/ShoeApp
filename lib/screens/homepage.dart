import 'package:e_shoeapp/services/firebaseservices.dart';
import 'package:e_shoeapp/tabs/hometabs.dart';
import 'package:e_shoeapp/tabs/savedtabs.dart';
import 'package:e_shoeapp/tabs/searchtab.dart';
import 'package:e_shoeapp/widgets/bottomtabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                 setState(() {
                   _selectedTab = num;
                 });
              },
              children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
                _tabsPageController.animateToPage(
                    num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }
}
