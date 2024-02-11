import 'package:flutter/material.dart';
// import google fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/profile_list_item.dart';
import '../../models/User.dart';
import '../../providers/AuthProvider.dart';
import '../../utils/shared_preference.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const kSpacingUnit = 9;

  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var profileInfo = Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: 9 * 9,
                  width: 9 * 9,
                  margin: const EdgeInsetsDirectional.only(top: 30),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 9 * 5,
                        backgroundImage:
                            NetworkImage(snapshot.data!.profilePhoto!),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 9 * 2.5,
                          width: 9 * 2.5,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            heightFactor: 9 * 1.5,
                            widthFactor: 9 * 1.5,
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9 * 2),
                Text(
                  snapshot.data!.userName!,
                  style: GoogleFonts.openSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 9 * 0.5),
                Text(
                  snapshot.data!.email!,
                  style: GoogleFonts.openSans(color: Colors.black),
                ),
                const SizedBox(height: 9 * 2),
                Container(
                  height: 9 * 4,
                  width: 10 * 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9 * 3),
                      color: Colors.grey[600]),
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.openSans(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 25 * 2),
              ],
            ),
          );

          var header = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  LineAwesomeIcons.arrow_left,
                ),
              ),
              profileInfo,
              const SizedBox(width: 5),
              const Icon(
                Icons.refresh,
              ),
              const SizedBox(width: 20),
            ],
          );

          return SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 2 * 5),
                header,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ListView(
                      children: <Widget>[
                        const ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Privacy',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.history,
                          text: 'Purchase History',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Help & Support',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.cog,
                          text: 'Settings',
                        ),
                        const ProfileListItem(
                          icon: LineAwesomeIcons.user_plus,
                          text: 'Invite a Friend',
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: const ProfileListItem(
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Logout',
                            hasNavigation: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    ));
  }

  Future<User> getUser() async {
    final user = await UserPreferences().getUser();
    return user;
  }
}
