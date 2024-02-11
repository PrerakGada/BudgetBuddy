import 'package:budget_buddy/features/BucketList/bucket_list.dart';
import 'package:budget_buddy/features/BucketList/create_bucket_list.dart';
import 'package:budget_buddy/features/Home/dashboard.dart';
import 'package:budget_buddy/features/Main/home_screen.dart';
import 'package:budget_buddy/features/OCR/ocr.dart';
import 'package:budget_buddy/features/Onboarding/login_screen.dart';
import 'package:budget_buddy/features/Onboarding/onboarding_screen.dart';
import 'package:budget_buddy/features/Onboarding/signup_page.dart';
import 'package:budget_buddy/features/Onboarding/splash_screen.dart';
import 'package:budget_buddy/features/Profile/profile_screen.dart';
import 'package:budget_buddy/features/budget/budget_screen.dart';
import 'package:budget_buddy/features/groups/groups.dart';
import 'package:flutter/material.dart';

import '../features/offers_coupons/offers.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.id: (context) => const SplashScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignupPage.id: (context) => const SignupPage(),
  OnboardingScreen.id: (context) => const OnboardingScreen(),
  HomeScreen.id: (context) => const HomeScreen(),
  ProfileScreen.id: (context) => const ProfileScreen(),
  Dashboard.id: (context) => const Dashboard(),
  CreateBucketList.id: (context) => const CreateBucketList(),
  BudgetScreen.id: (context) => const BudgetScreen(),
  Groups.id: (context) => const Groups(),
  OfferScreen.id: (context) => const OfferScreen(),
  BucketList.id: (context) => const BucketList(),
  Pres.id: (context) => const Pres(),
};
