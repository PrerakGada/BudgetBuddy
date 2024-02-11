import 'package:budget_buddy/components/my_alert_dialog.dart';
import 'package:budget_buddy/features/Home/pay_period_circular.dart';
import 'package:budget_buddy/features/budget/budget_screen.dart';
import 'package:budget_buddy/providers/PostProvider.dart';

import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'weekly_chart.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const String id = '/home';

  @override
  Widget build(BuildContext context) {
    List<Post> post = Provider.of<PostProvider>(context, listen: false).postes;
    List<Map<String, dynamic>> transactions = [
      {
        'title': 'Coffee',
        'amount': '-3.50',
        'icon': Icons.local_cafe,
      },
      {
        'title': 'Grocery',
        'amount': '-52.18',
        'icon': Icons.shopping_cart,
      },
      {
        'title': 'Gas',
        'amount': '-32.45',
        'icon': Icons.local_gas_station,
      },
      {
        'title': 'Restaurant',
        'amount': '-22.90',
        'icon': Icons.restaurant,
      },
      {
        'title': 'Movie',
        'amount': '-16.75',
        'icon': Icons.movie,
      },
      {
        'title': 'Online',
        'amount': '-98.55',
        'icon': Icons.shopping_basket,
      },
      {
        'title': 'Gym',
        'amount': '-79.99',
        'icon': Icons.fitness_center,
      },
      {
        'title': 'Pharmacy',
        'amount': '-12.30',
        'icon': Icons.local_pharmacy,
      },
      {
        'title': 'Fast Food',
        'amount': '-9.95',
        'icon': Icons.fastfood,
      },
      {
        'title': 'Parking',
        'amount': '-7.50',
        'icon': Icons.local_parking,
      },
      {
        'title': 'Laundry',
        'amount': '-25.75',
        'icon': Icons.local_laundry_service,
      },
      {
        'title': 'Bookstore',
        'amount': '-18.90',
        'icon': Icons.book,
      },
      {
        'title': 'Movie Rent',
        'amount': '-5.99',
        'icon': Icons.movie_filter,
      },
      {
        'title': 'Pet Store',
        'amount': '-37.55',
        'icon': Icons.pets,
      },
    ];

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(BudgetScreen.id);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: const Color(0xff15D7D7).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xff15D7D7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.home_outlined),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Expanded(
                                    child: Text(
                                      "This week you spend",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const StylishRupees(
                                amount: 30500,
                                size1: 16,
                                size2: 22,
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: WeeklyChart(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        color: Palette.greyDarker,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CardTwoItem(
                              icon: Icons.account_balance,
                              title: "Balance",
                              amount: 14000,
                              color: Palette.greyDark,
                            ),
                            SizedBox(height: 10),
                            CardTwoItem(
                              icon: Icons.credit_card,
                              title: "Avail. Credits",
                              amount: 10000,
                              color: Palette.greyDark,
                            ),
                            SizedBox(height: 10),
                            CardTwoItem(
                              icon: Icons.payment,
                              title: "Loans & EMIs",
                              amount: 12000,
                              color: Palette.greyDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        color: Palette.greyDarker,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.home),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: Text(
                                    "Recent Transactions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  return RecentTransactionItem(
                                    index: index,
                                    length: transactions.length,
                                    title: transactions[index]['title'],
                                    amount: transactions[index]['amount'],
                                    icon: transactions[index]['icon'],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SaveMoney(context);
                      },
                      child: Container(
                        height: 240,
                        decoration: BoxDecoration(
                          color: const Color(0xff1A27CB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.home),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Expanded(
                                    child: Text(
                                      "This Pay Period",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const StylishRupees(
                                amount: 30500,
                                size1: 16,
                                size2: 22,
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: PayPeriodCircular(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Posts",
                  style: TextStyle(
                    fontSize: 20,
                    color: Palette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                post.length,
                (index) => Posts(
                  item: post[index],
                  index: index,
                  length: post.length,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class RecentTransactionItem extends StatelessWidget {
  final int index, length;
  final String title;
  final String amount;
  final IconData icon;

  const RecentTransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.index,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 5),
        Row(
          children: [
            Icon(
              icon,
              color: Palette.white,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              amount.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CardTwoItem extends StatelessWidget {
  const CardTwoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.color,
  });

  final IconData icon;
  final String title;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Palette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            StylishRupees(
              amount: amount,
              size1: 12,
              size2: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class StylishRupees extends StatelessWidget {
  const StylishRupees({
    super.key,
    required this.amount,
    required this.size1,
    required this.size2,
  });

  final double amount;
  final double size1, size2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "₹",
          style: TextStyle(
            fontSize: size1,
            color: Palette.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          amount.toString(),
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: size2,
            letterSpacing: 1.2,
            color: Palette.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({
    super.key,
    required this.item,
    required this.index,
    required this.length,
  });

  final Post item;
  final int index, length;

  // final double amount;
  // final double size1, size2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/icons/avatar.svg",
          width: 40,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != 0) const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.desc,
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontSize: 16,
                  color: Palette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.timelapse_outlined,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item.time,
                    style: TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 12,
                      color: Palette.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
