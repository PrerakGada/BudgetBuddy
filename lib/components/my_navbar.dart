import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyNavBar extends StatefulWidget {
  final Function(int)? onTap;
  final int currentIndex;

  const MyNavBar({super.key, required this.onTap, required this.currentIndex});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: Colors.amber,
      unselectedItemColor: Palette.greyDark,
      selectedItemColor: Colors.black,
      onTap: widget.onTap, // new
      currentIndex: widget.currentIndex, // new
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/dashboard.svg",
            width: 22,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/transactions.svg",
            width: 30,
          ),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/stocks.svg",
              width: 30,
            ),
            label: 'Bytes'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/stocks.svg",
              width: 30,
            ),
            label: 'Courses'),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/stocks.svg",
              width: 30,
            ),
            label: 'Mentor')
      ],
    );
  }
}
