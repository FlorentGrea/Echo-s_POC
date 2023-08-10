import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder_clone/pages/account_page.dart';
import 'package:tinder_clone/pages/explore_page.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'dart:developer';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_one,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), AccountPage()],
    );
  }

  Widget getAppBar() {
    List bottomItems = [
      pageIndex == 0
          ? "images/utilisateur-de-profil.svg"
          : "images/utilisateur-de-profil.svg",
      pageIndex == 1
          ? "images/settings.svg"
          : "images/settings.svg",
    ];
    return AppBar(
      backgroundColor: primary_one,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: SvgPicture.asset(
                bottomItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
