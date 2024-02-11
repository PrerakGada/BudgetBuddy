import 'package:budget_buddy/features/Home/dashboard.dart';
import 'package:budget_buddy/features/Home/pay_period_circular.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../../themes/palette.dart';

class StudentLoan extends StatelessWidget {
  static const String id = '/student_loan';
  const StudentLoan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
              color: Palette.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            height: MediaQuery.of(context).size.height * 0.43,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text('Current Balance',
                                        style: TextStyle(fontSize: 20)),
                                    SizedBox(height: 10),
                                    StylishRupees(
                                      amount: 10456,
                                      size1: 18,
                                      size2: 28,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Principal Balance',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              StylishRupees(
                                amount: 134200,
                                size1: 16,
                                size2: 24,
                              ),
                            ],
                          ),
                          Spacer(),
                          const Expanded(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: PayPeriodCircular(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Current Month EMI',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '₹10000',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 50, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Average EMI Rate',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '6.23%',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 50, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Payoff Date',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Dec 2025',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                    color: Palette.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.arrow_right_alt),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Make a Loan Payment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 70, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child:
                                      const Icon(Icons.u_turn_right_outlined),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Make a Savings Deposit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 70, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.payment),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Add a Payment Account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 1, width: 80, color: Palette.greyDarker),
                          Container(
                              height: 1, width: 75, color: Palette.greyDarker),
                          Container(
                              height: 1, width: 80, color: Palette.greyDarker),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.roundabout_left),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Roundups',
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 70, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.calendar_month),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Automatic Payments',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 70, width: 1, color: Palette.greyDarker),
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.recycling),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Cash Back',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
