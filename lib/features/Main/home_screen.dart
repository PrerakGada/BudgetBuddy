import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_buddy/features/BucketList/bucket_list.dart';
import 'package:budget_buddy/features/BucketList/create_bucket_list.dart';
import 'package:budget_buddy/features/budget/budget_screen.dart';
import 'package:budget_buddy/features/expense_tracker/expense_tracker.dart';
import 'package:budget_buddy/features/Home/dashboard.dart';
import 'package:budget_buddy/features/groups/groups.dart';
import 'package:budget_buddy/features/stocks/stocks.dart';
import 'package:budget_buddy/features/student_loan/student_loan.dart';
import 'package:budget_buddy/features/transactions/add_transaction.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../stocks/stock_selection.dart';
import '../transactions/transactions.dart';
import '../../components/chat_drawer.dart';
import '../../components/my_appbar.dart';
import '../../components/my_drawer.dart';

import '../../components/my_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = '/homescreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const Dashboard(),
      const Transactions(),
      const StudentLoan(),
      const StockSelection(),
    ];
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    List<IconData> icons = [
      Icons.dashboard_rounded,
      Icons.currency_exchange_rounded,
      Icons.wallet,
      Icons.newspaper_rounded,
    ];

    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.white,
        child: const Icon(
          Icons.add_outlined,
          color: Palette.black,
        ),
        onPressed: () {
          // Navigator.pushNamed(context, CreateBucketList.id);

          //open bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTransaction(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: onTabTapped,
        backgroundColor: Colors.black,
        //other params
      ),
      appBar: MyAppBar(title: 'Home'),
      // drawer: const MyDrawer(),
      endDrawer: const MyDrawer(),
      endDrawerEnableOpenDragGesture: true,
      backgroundColor: Palette.greyDarker,
      body: children[_currentIndex],
    );
  }
}
