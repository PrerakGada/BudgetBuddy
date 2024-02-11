// ignore_for_file: use_build_context_synchronously

import 'package:budget_buddy/features/budget/budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';
import '../../models/User.dart';
import '../../providers/AuthProvider.dart';
import '../../providers/UserProvider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      Future<void> login() async {
        loading = true;
        setState(() {});
        // wait 10 seconds
        // final response = await auth.login(emailController.text.toString(),
        //     passwordController.text.toString());
        final response = await auth.login('s@s.com', 'someone');
        if (response['status']) {
          User user = response['user'];
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          if (user.emailVerified == 'true') {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          } else {
            Navigator.pushReplacementNamed(context, '/homescreen');
          }
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.black87,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          loading = false;
        });
      }

      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: LottieBuilder.asset(
                      "assets/extras/dark_logo.json",
                      repeat: true,
                    ),
                  ),
                  // const Icon(
                  //   Icons.lock,
                  //   size: 100,
                  //   color: Colors.black,
                  // ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome back to Budget Buddy',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot your password?',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  // sized box
                  const SizedBox(height: 25),

                  // login
                  MyButton(
                      text: loading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                      onTap: login),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                                thickness: 0.5, color: Colors.grey[400])),
                        Text(
                          ' Or continue with ',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        Expanded(
                            child: Divider(
                                thickness: 0.5, color: Colors.grey[400])),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + apple sign in buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // google button
                        SquareTile(imagePath: 'assets/images/apple.png'),

                        SizedBox(width: 50),

                        // apple button
                        SquareTile(imagePath: 'assets/images/google.png')
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // not a member? register now
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )));
    });
  }
}
