import 'package:budget_buddy/themes/palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'expense_chart.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});
  static const String id = '/expense_tracker';

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<ExpenseTracker> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Text(
                "Track your expense",
                style: TextStyle(
                  fontSize: 22,
                  color: Palette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color:
                      Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                ),
                onPressed: () {
                  setState(() {
                    isShowingMainData = !isShowingMainData;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ExpenseChart(isShowingMainData: isShowingMainData),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
