import 'package:budget_buddy/features/BucketList/bucket_list.dart';
import 'package:budget_buddy/features/groups/groups.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/User.dart';
import '../utils/shared_preference.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = doSomeLongRunningCalculation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: 250,
          child: FutureBuilder(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Drawer(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Palette.greyDark.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    "https://mustansirg.in/static/assets/img/bg.webp"),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Mustansir",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Palette.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('Groups'),
                              onTap: () {
                                Navigator.pushNamed(context, Groups.id);
                              },
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.list_outlined),
                              title: const Text('Bucket list'),
                              onTap: () {
                                Navigator.pushNamed(context, BucketList.id);
                              },
                            ),
                            const Divider(),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.whatsapp),
                              title: const Text('Message on Whatsapp'),
                              onTap: () {},
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.edit_outlined),
                              title: const Text('Edit preferences'),
                              onTap: () {},
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('Settings'),
                              leading: const Icon(Icons.settings),
                              onTap: () {},
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text('Log out'),
                              leading: const Icon(Icons.logout_rounded),
                              onTap: () {},
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}

Future<User> doSomeLongRunningCalculation() async {
  final user = await UserPreferences().getUser();
  return user;
}
