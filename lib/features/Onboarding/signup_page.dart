import 'package:flutter/material.dart';
import '../../themes/palette.dart';
import 'package:provider/provider.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';
import '../../models/User.dart';
import '../../providers/AuthProvider.dart';
import '../../providers/UserProvider.dart';
import '../../widgets/labeledTextFormField.dart';

import 'splash_screen.dart';

class SignupPage extends StatefulWidget {
  static const String id = '/signup';

  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool loading = false;

  // Text Editing Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      Future<void> doRegister() async {
        loading = true;
        setState(() {});

        final Future<Map<String, dynamic>> successfulMessage = auth.register(
          usernameController.text.toString(),
          emailController.text.toString(),
          password1Controller.text.toString(),
          password2Controller.text.toString(),
        );

        await successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/home');
          } else if (response['status'] == false) {
            if (response['emailError'] != null) {
              SnackBar snackBar = SnackBar(
                content: Text(response['emailError']),
                backgroundColor: Colors.black87,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (response['passwordError'] != null) {
              SnackBar snackBar = SnackBar(
                content: Text(response['passwordError']),
                backgroundColor: Colors.black87,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (response['usernameError'] != null) {
              SnackBar snackBar = SnackBar(
                content: Text(response['usernameError']),
                backgroundColor: Colors.black87,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              SnackBar snackBar = SnackBar(
                content: Text(response.toString()),
                backgroundColor: Colors.black87,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            SnackBar snackBar = SnackBar(
              content: Text(response['message']),
              backgroundColor: Colors.black87,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
        loading = false;
        setState(() {});
      }

      ;

      return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome back to Tech Mentors',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: password1Controller,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: password2Controller,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // forgot password

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
                          : Text('Register'),
                      onTap: doRegister),

                  const SizedBox(height: 50),

                  const SizedBox(height: 50),

                  // not a member? register now
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Login now',
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
