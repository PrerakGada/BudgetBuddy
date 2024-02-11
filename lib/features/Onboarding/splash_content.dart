import 'package:budget_buddy/themes/palette.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.opacity,
  }) : super(key: key);
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DropShadow(
            //   opacity: 0.5,
            //   blurRadius: 7,
            //   offset: const Offset(0, 5),
            //   child: Opacity(
            //     opacity: opacity,
            //     child: Lottie.asset(
            //       "assets/icons/logo.svg",
            //       width: 80,
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 160,
              height: 160,
              child: LottieBuilder.asset(
                "assets/extras/lottie_logo.json",
                repeat: true,
              ),
            ),
            const SizedBox(height: 10),
            Opacity(
              opacity: opacity,
              child: const Text(
                "Budget Buddy",
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
