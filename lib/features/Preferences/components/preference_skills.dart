import 'package:budget_buddy/components/primary_btn.dart';
import 'package:budget_buddy/features/Preferences/preferences.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PreferenceSkills extends StatelessWidget {
  const PreferenceSkills({super.key, required this.skills, required this.onSelected, required this.controller});
  final List<PreferenceItem> skills;
  final Function onSelected;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select upto 5 skills",
            style: TextStyle(
              fontSize: 22,
              color: Palette.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Center(
            child: LottieBuilder.asset(
              "assets/extras/lottie_skills.json",
              repeat: true,
            ),
          ),
          const Spacer(),
          const Text(
            "Choose your skills",
            style: TextStyle(
              fontSize: 18,
              color: Palette.white,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              skills.length,
              (index) => PreferenceCard(
                index: index,
                item: skills[index],
                onSelected: onSelected,
              ),
            ),
          ),
          const SizedBox(height: 40),
          PrimaryBtn(
            title: "Continue",
            hasIcon: false,
            padding: 0,
            primaryColor: Palette.primary,
            secondaryColor: Palette.primaryAccent,
            titleColor: Palette.greyDarker,
            tap: () {
              controller.animateToPage(1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }
}
