import 'package:flutter/material.dart';
import '../../themes/palette.dart';

class CreateBucketList extends StatefulWidget {
  const CreateBucketList({super.key});
  static const String id = '/create_bucket_list';

  @override
  State<CreateBucketList> createState() => _CreateBucketListState();
}

class _CreateBucketListState extends State<CreateBucketList> {
  bool readyToSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.white,
                        ),
                      ),
                      Text(
                        "Bucket list",
                        style: TextStyle(
                          fontSize: 26,
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.done,
                        color: readyToSubmit
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.5),
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Title",
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.white,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                    onChanged: (value) {},
                    keyboardType: TextInputType.text,
                    cursorRadius: const Radius.circular(8),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New home",
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Budget",
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.white,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    cursorRadius: const Radius.circular(8),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "₹ 80,000",
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Select category",
                style: TextStyle(
                  fontSize: 16,
                  color: Palette.white,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    // context and builder are
                    // required properties in this widget
                    context: context,
                    builder: (BuildContext context) {
                      // we set up a container inside which
                      // we create center column and display text

                      // Returning SizedBox instead of a Container
                      return SizedBox(
                        height: 300,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                itemCount: 20,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoryItem(
                                    index: index,
                                    length: 20,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Personal",
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.index,
    required this.length,
  }) : super(key: key);

  final int index, length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8,
              color: Palette.white,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.home_rounded,
                    color: Colors.blue,
                    size: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Personal",
                  style: TextStyle(
                    fontSize: 10,
                    color: Palette.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
