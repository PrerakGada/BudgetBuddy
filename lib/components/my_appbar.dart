import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../models/User.dart';
import '../utils/shared_preference.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.canPop = false,
  });

  final String title;
  final bool canPop;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = doSomeLongRunningCalculation();
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = widget.canPop;

    return FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AppBar(
              title: Text(widget.title, style: GoogleFonts.openSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              centerTitle: false,
              foregroundColor: Colors.white,
              // backgroundColor: Colors.grey.shade900,
              leading: canPop
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                  : null,
              elevation: 0,
              actions: [
                GestureDetector(
                  onLongPressStart: (details) async {
                    // wait 5 seconds
                    await Future.delayed(const Duration(seconds: 6));
                    Dialogs.materialDialog(
                      msg: "Hey there, it seems like your deadline on the broadband bill is approaching.",
                      title: "Payment deadline approaching",
                      color: Colors.black,
                      lottieBuilder: Lottie.asset(
                        'assets/time_running_out.json',
                        fit: BoxFit.contain,
                      ),
                      context: context,
                      actions: [
                        Column(
                          children: [
                            IconsButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: "Remind me again in an hour",
                              iconData: Icons.timelapse,
                              color: Colors.blue,
                              textStyle: const TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                            IconsButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: "Ok!!",
                              iconData: Icons.done,
                              color: Colors.blue,
                              textStyle: const TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage("https://cdn.discordapp.com/attachments/1089788425319747616/1092005872437305414/image.png"),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text("shit gone sideways");
          }
        });
  }
}

Future<User> doSomeLongRunningCalculation() async {
  final user = await UserPreferences().getUser();
  return user;
}
