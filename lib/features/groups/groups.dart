import 'package:budget_buddy/providers/GroupProvider.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:budget_buddy/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Groups extends StatefulWidget {
  static const String id = "/groups_screen";
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  int gindex = 0;
  // final List<String> groupTitle = [
  //   "My Room",
  //   "Friends",
  //   "V5",
  // ];

  // final List<GroupPayment> payments = [
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", false),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar",
  //       "Are vo us din ka dgt rt d r drg df sdf se e sdf sf se d sf ", false),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  //   GroupPayment(425, "Akshay Vhatkar", "Are vo us din ka", true),
  // ];

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return Consumer<GroupProvider>(builder: (context, value, child) {
      List<Group> groups = value.groups;
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Your Groups",
                  style: TextStyle(
                    fontSize: 18,
                    color: Palette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: groups.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GroupItem(
                    index: index,
                    length: groups.length,
                    title: groups[index].name,
                    onTap: (index) {
                      gindex = index;
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Spacer(),
              Container(
                height: SizeConfig.height * 0.7,
                decoration: const BoxDecoration(
                  color: Palette.greyDarker,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Palette.white, width: 0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Palette.white.withOpacity(0.7),
                                    ),
                                  ),
                                  const Text(
                                    "4535.98",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Palette.white, width: 0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Budget",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Palette.white.withOpacity(0.7),
                                    ),
                                  ),
                                  const Text(
                                    "4535.98",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Palette.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ...List.generate(
                        groups[gindex].expenses.length,
                        (index) => groups[gindex].expenses[index].username ==
                                "Anjali Gupta"
                            ? GroupOutgoingChatCard(
                                index: index,
                                length: groups[0].expenses.length,
                                username: groups[0].expenses[index].username,
                                title: groups[0].expenses[index].title,
                                desc: groups[0].expenses[index].description,
                                amount: groups[0].expenses[index].amount,
                              )
                            : GroupIncomingChatCard(
                                index: index,
                                length: groups.length,
                                username: groups[0].expenses[index].username,
                                title: groups[0].expenses[index].title,
                                desc: groups[0].expenses[index].description,
                                amount: groups[0].expenses[index].amount,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class GroupIncomingChatCard extends StatelessWidget {
  const GroupIncomingChatCard({
    super.key,
    required this.index,
    required this.length,
    required this.title,
    required this.username,
    required this.desc,
    required this.amount,
  });
  final int index, length;
  final String title, desc, username;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: SizeConfig.width * 0.7),
                decoration: BoxDecoration(
                  color: Palette.greyDark.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Palette.primary,
                        ),
                      ),
                      Text(
                        amount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 12,
                          color: Palette.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupItem extends StatelessWidget {
  const GroupItem(
      {super.key,
      required this.index,
      required this.length,
      required this.onTap,
      required this.title});
  final int index, length;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Row(
        children: [
          if (index == 0) const SizedBox(width: 10),
          const SizedBox(width: 10),
          if (index < length - 1)
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (index == length - 1)
            Container(
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Center(
                  child: Icon(
                    Icons.add_outlined,
                    color: Palette.white,
                  ),
                ),
              ),
            ),
          if (index == length - 1) const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class GroupOutgoingChatCard extends StatelessWidget {
  const GroupOutgoingChatCard(
      {super.key,
      required this.index,
      required this.username,
      required this.length,
      required this.title,
      required this.desc,
      required this.amount});
  final int index, length;
  final String title, desc, username;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: SizeConfig.width * 0.7),
                decoration: BoxDecoration(
                  color: Palette.greyDark.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        this.username,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Palette.primary,
                        ),
                      ),
                      Text(
                        this.amount.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        this.desc,
                        style: TextStyle(
                          fontSize: 12,
                          color: Palette.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupPayment {
  final double amount;
  final String name, desc;
  final bool payedByMe;

  GroupPayment(this.amount, this.name, this.desc, this.payedByMe);
}
