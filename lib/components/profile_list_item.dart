import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10 * 5.5,
      margin: const EdgeInsets.symmetric(
      ).copyWith(
        bottom: 10 * 2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10 * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * 3),
        color: Colors.transparent,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 10 * 2.5,
          ),
          const SizedBox(width: 10 * 1.5),
          Text(
            text,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          if (hasNavigation)
            const Icon(
              LineAwesomeIcons.angle_right,
              size: 10 * 2.5,
            ),
        ],
      ),
    );
  }
}