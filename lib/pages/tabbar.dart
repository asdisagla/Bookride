import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_finance_app/pages/booking.dart';
import 'package:flutter_finance_app/pages/comming.dart';
import 'package:flutter_finance_app/pages/home_page.dart';
import 'package:flutter_finance_app/pages/viewAll_booking.dart';
import 'package:flutter_finance_app/theme/colors.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int pageIndex = 0;

  
List<Widget> pages = [
  HomePage(),
  Comming(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: SafeArea(
        child: SizedBox(
          // height: 30,
          // width: 40,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Booking(),
                ),
              );
            },
            child: Icon(
              Icons.directions_car,
              color: white,
              size: 20,
            ),
            backgroundColor: primary,
            // shape:
            //     BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
     return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.calendar,
    ];
    return AnimatedBottomNavigationBar(
       backgroundColor: primary,
       icons: iconItems,
        splashColor: secondary,
        activeColor: black,
        inactiveColor: Colors.white,
        gapLocation: GapLocation.center,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        elevation: 2,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
