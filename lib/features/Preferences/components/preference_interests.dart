import 'package:budget_buddy/components/primary_btn.dart';
import 'package:budget_buddy/features/Main/home_screen.dart';
import 'package:budget_buddy/features/Preferences/preferences.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PreferenceInterests extends StatelessWidget {
  const PreferenceInterests(
      {super.key,
      required this.interests,
      required this.onSelected,
      required this.controller});
  final List<PreferenceItem> interests;
  final Function onSelected;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select upto 5 interests",
            style: TextStyle(
              fontSize: 22,
              color: Palette.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Center(
            child: LottieBuilder.asset(
              "assets/extras/lottie_interests.json",
              repeat: true,
            ),
          ),
          const Spacer(),
          const Text(
            "Choose your interests",
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
              interests.length,
              (index) => PreferenceCard(
                index: index,
                item: interests[index],
                onSelected: onSelected,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: PrimaryBtn(
                  title: "Back",
                  hasIcon: false,
                  padding: 0,
                  primaryColor: Palette.greyDark,
                  secondaryColor: Palette.greyDark.withOpacity(0.7),
                  titleColor: Palette.white,
                  tap: () {
                    controller.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: PrimaryBtn(
                  title: "Continue",
                  hasIcon: false,
                  padding: 0,
                  primaryColor: Palette.primary,
                  secondaryColor: Palette.primaryAccent,
                  titleColor: Palette.greyDarker,
                  tap: () {
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
