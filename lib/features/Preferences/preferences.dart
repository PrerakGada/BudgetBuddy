import 'package:budget_buddy/components/primary_btn.dart';
import 'package:budget_buddy/features/Preferences/components/preference_interests.dart';
import 'package:budget_buddy/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'components/preference_skills.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  late PageController controller;

  int currentIndex = 0;

  int skillsLimit = 0, interestLimit = 0;

  final List<PreferenceItem> skills = [
    PreferenceItem('Programming'),
    PreferenceItem('Photography'),
    PreferenceItem('Auditing'),
    PreferenceItem('Pharmacology'),
    PreferenceItem('Finance'),
    PreferenceItem('Cybersecurity'),
    PreferenceItem('Accounting'),
    PreferenceItem('DevOps'),
    PreferenceItem('AIML'),
    PreferenceItem('Marketing'),
    PreferenceItem('Sales'),
  ];
  final List<PreferenceItem> interests = [
    PreferenceItem('Art'),
    PreferenceItem('Beauty'),
    PreferenceItem('Books'),
    PreferenceItem('Makeup'),
    PreferenceItem('Movies'),
    PreferenceItem('Reading'),
    PreferenceItem('Running'),
    PreferenceItem('Singing'),
    PreferenceItem('Sports'),
    PreferenceItem('Theater'),
    PreferenceItem('Writing'),
    PreferenceItem('Coding'),
  ];

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  void onSelected(PreferenceItem item) {
    if (currentIndex == 0) {
      if (skillsLimit == 5) {
        if (item.isSelected) {
          setState(() {
            item.isSelected = !item.isSelected;
            skillsLimit--;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Can't add more than 5 skills")));
        }
      } else {
        setState(() {
          item.isSelected = !item.isSelected;
          if (item.isSelected) {
            skillsLimit++;
          } else {
            skillsLimit--;
          }
        });
      }
    } else {
      if (interestLimit == 5) {
        if (item.isSelected) {
          setState(() {
            item.isSelected = !item.isSelected;
            interestLimit--;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Can't add more than 5 interests")));
        }
      } else {
        setState(() {
          item.isSelected = !item.isSelected;
          if (item.isSelected) {
            interestLimit++;
          } else {
            interestLimit--;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                children: [
                  PreferenceSkills(
                    skills: skills,
                    controller: controller,
                    onSelected: onSelected,
                  ),
                  PreferenceInterests(
                    interests: interests,
                    controller: controller,
                    onSelected: onSelected,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class PreferenceCard extends StatefulWidget {
  PreferenceCard({
    super.key,
    required this.index,
    required this.item,
    required this.onSelected,
  });
  final int index;
  PreferenceItem item;
  final Function onSelected;

  @override
  State<PreferenceCard> createState() => _PreferenceCardState();
}

class _PreferenceCardState extends State<PreferenceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onSelected(widget.item),
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.item.isSelected ? Palette.primary : null,
          border: Border.all(color: Palette.white, width: 0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.item.isSelected ? Colors.black : Palette.white,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                widget.item.isSelected
                    ? Icons.check_outlined
                    : Icons.add_outlined,
                size: 18,
                color: widget.item.isSelected ? Colors.black : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceItem {
  final String title;
  bool isSelected = false;

  PreferenceItem(this.title);
}
