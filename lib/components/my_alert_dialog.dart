// a reusable dark mode compatible alert dialog in flutter 
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:share_plus/share_plus.dart';



class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String defaultActionText;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.defaultActionText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

void SaveMoney(context) {
  Dialogs.materialDialog(
                        msg: "You may have lost some money in this transaction, this is not a part of your budget and counts as miscellanous.",
                        title: "Unnecessary Expense Detected",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/money_gone.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "Learn how I can save more!!",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

void AcquiredMoney(context) {
  Dialogs.materialDialog(
                        msg: "This money allows for more room in your budget and more space to invest your money to achieve your financial goals.",
                        title: "Congratulations, let's make the most of this",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/cong_example.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "Help me invest",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

void StockGone(context) {
  Dialogs.materialDialog(
                        msg: "Your friends and family are having their money make them more, do the same to achieve your wish of owning a car sooner.",
                        title: "You're missing out",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/cong_example.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "How can I invest securely?",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

void Budget(context) {
  Dialogs.materialDialog(
                        msg: "Learn how your spending habits are preventing you from retiring early.",
                        title: "Plan your spending",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/cong_example.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "Let's make a budget!",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

void madeExtraMoneyThisWeek(context) {
  Dialogs.materialDialog(
                        msg: "Looks like your portfolio is pretty hot right now, share your tips and secrets with your friends.",
                        title: "Hey, you made bank!!!",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/momoney.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Share.share('check out my website https://example.com');
                              Navigator.of(context).pop();
                            },
                            text: "Share",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

void weeklyReport(context) {
  Dialogs.materialDialog(
                        msg: "Your weekly financial report, hot off the AI press. Learn how you can save more, and where you can invest.",
                        title: "Here's how you did this week",
                        color: Colors.black,
                        lottieBuilder: Lottie.asset(
                            'assets/learn_money.json',
                            fit: BoxFit.contain,
                            ),
                        context: context,
                        actions: [
                          IconsButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "Educate me",
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ],
                      );
}

