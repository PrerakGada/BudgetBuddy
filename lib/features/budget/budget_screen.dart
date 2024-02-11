import 'package:budget_buddy/components/my_appbar.dart';
import 'package:budget_buddy/features/Home/fab.dart';
import 'package:budget_buddy/features/Home/weekly_chart.dart';
import 'package:budget_buddy/features/budget/analytic_charts.dart';
import 'package:budget_buddy/features/budget/circular_chart.dart';
import 'package:budget_buddy/features/expense_tracker/expense_tracker.dart';
import 'package:budget_buddy/main.dart';
import 'package:budget_buddy/models/Budget.dart';
import 'package:budget_buddy/providers/BudgetProvider.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});
  static const String id = '/budget_screen';

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  // late Notificator notification;

  String notificationKey = 'key';
  String _bodyText = 'notification test';

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // notification = Notificator(
    //   onPermissionDecline: () {
    //     // ignore: avoid_print
    //     print('permission decline');
    //   },
    //   onNotificationTapCallback: (notificationData) {
    //     setState(
    //       () {
    //         _bodyText = 'notification open: '
    //             '${notificationData[notificationKey].toString()}';
    //       },
    //     );
    //   },
    // )..requestPermissions(
    //     requestSoundPermission: true,
    //     requestAlertPermission: true,
    //   );
  }

  String currentBudgetSorting = "Today";

  List<Transaction> categories = [];

  List<CircularStocks> budgetChart = [];

  final List<String> months = [
    'Today',
    'Last 7 days',
    'This week',
    'Last 30 days',
    'This month',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(builder: (context, budgetProvider, child) {
      categories = [];
      budgetChart = [];
      final budgets = budgetProvider.budgets;

      Budget budget = budgets[months.indexOf(currentBudgetSorting)];

      for (Transaction transaction in budget.transactions) {
        categories.add(Transaction(
            name: transaction.name,
            amount: transaction.amount,
            category: transaction.category,
            date: transaction.date));
      }

      Map<String, double> categoricalExpense =
          budgetProvider.getCategoricalExpense(budget.transactions);
      categoricalExpense.keys.forEach((k) {
        print(k);
        print(categoricalExpense[k]);
        budgetChart.add(CircularStocks(
          stockName: k,
          investedPartition: categoricalExpense[k]!,
        ));
      });

      return Scaffold(
        appBar: MyAppBar(
          title: 'Reports and Analytics',
          canPop: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "₹",
                            style: TextStyle(
                              fontSize: 16,
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            budget.amount.toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              letterSpacing: 2,
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CustomDropdownButton2(
                        hint: currentBudgetSorting,
                        value: currentBudgetSorting,
                        buttonWidth: 150,
                        buttonHeight: 50,
                        dropdownItems: months,
                        iconEnabledColor: Palette.white,
                        buttonDecoration: BoxDecoration(
                          color: Palette.greyDarker,
                          border: Border.all(
                            color: Palette.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dropdownDecoration: BoxDecoration(
                          color: Palette.greyDarker,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: const FaIcon(Icons.arrow_drop_down_rounded),
                        iconSize: 20,
                        onChanged: (value) async {
                          if (mounted) {
                            setState(() {
                              currentBudgetSorting = value!;
                            });
                            // wait 5 seconds
                            Future.delayed(const Duration(seconds: 5), () {
                              // show notification
                              flutterLocalNotificationsPlugin.show(
                                1,
                                'hello',
                                'this is test',
                                notificationDetails,
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        PageView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: AnalyticCharts(),
                            ),
                            CiruclarChart(investedStocks: budgetChart),
                            ExpenseTracker(),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            effect: const WormEffect(
                              dotColor: Palette.greyDarker,
                              activeDotColor: Palette.white,
                              dotHeight: 8,
                              dotWidth: 8,
                              strokeWidth: 2,
                            ),
                            count: 3,
                            controller: _pageController,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // ...List.generate(
                  //   categories.length,
                  //   (index) => BudgetCard(
                  //     categories: categories[index],
                  //     index: index,
                  //     length: categories.length,
                  //   ),
                  // ),
                    ...List.generate(
                    categories.length,
                    (index) => BudgetCard(
                      categories: categories[index],
                      index: index,
                      length: categories.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.categories,
    required this.index,
    required this.length,
  });

  final Transaction categories;
  final int index, length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.home_outlined),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        categories.name,
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        categories.amount.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      color: Palette.green,
                      backgroundColor: Palette.greyDarker,
                      value: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (index < length - 1) const SizedBox(height: 10),
        if (index < length - 1) const Divider(color: Palette.greyDark),
        if (index < length - 1) const SizedBox(height: 10),
      ],
    );
  }
}
