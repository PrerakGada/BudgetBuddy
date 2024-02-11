import 'package:budget_buddy/providers/WishProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../themes/palette.dart';

class BucketList extends StatelessWidget {
  const BucketList({super.key});
  static const String id = '/bucket_list';

  @override
  Widget build(BuildContext context) {
    List<Wish> wish = Provider.of<WishProvider>(context, listen: false).wishes;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You've already saved:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "₹",
                            style: TextStyle(
                              fontSize: 16,
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "30,500",
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 2,
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/avatar.svg",
                    width: 50,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "Your bucket list",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Palette.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: wish.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BucketListItem(
                    index: index,
                    length: wish.length,
                    item: wish[index],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BucketListItem extends StatelessWidget {
  const BucketListItem({
    Key? key,
    required this.item,
    required this.index,
    required this.length,
  }) : super(key: key);

  final int index, length;
  final Wish item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index != 0) const SizedBox(height: 10),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Palette.greyDarker,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.greyDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home_outlined,
                          color: Palette.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Palette.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Palette.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    color: Colors.blue,
                    value: item.reached / item.goal,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${item.reached}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Palette.white,
                      ),
                    ),
                    Text(
                      "₹ ${item.goal}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Palette.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
