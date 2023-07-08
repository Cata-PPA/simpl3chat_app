import 'dart:developer';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:chat_app/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final _mainUrl = 'https://pub.dev';
  final _facebookUrl = 'https://www.facebook.com/';
  final _twitterUrl = 'https://www.twitter.com/';

  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      if (userNameController.text.length < 3) {}
      if (passwordController.text.length < 5) {}

      await context.read<AuthService>().loginUser(userNameController.text);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/chat', arguments: userNameController.text);
      }
    } else {
      log('not successful');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Let\'s sign you in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Welcome back! \nYou we\'re missed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                verticalSpacing(24),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: const DecorationImage(image: AssetImage('assets/pngwing.png')),
                      borderRadius: BorderRadius.circular(12)),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      LoginTextField(
                        hintText: "Enter your username",
                        validator: (value) {
                          if (value != null && value.isNotEmpty && value.length < 3) {
                            return "Your username should be more than 5 characters";
                          } else if (value != null && value.isEmpty) {
                            return "Please type your username";
                          }
                          return null;
                        },
                        controller: userNameController,
                      ),
                      verticalSpacing(12),
                      LoginTextField(
                        hasAsterisks: true,
                        controller: passwordController,
                        hintText: "Enter your password",
                      ),
                    ],
                  ),
                ),
                verticalSpacing(12),
                ElevatedButton(
                  onPressed: () async {
                    await loginUser(context);
                  },
                  child: const Text('Login'),
                ),
                verticalSpacing(12),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(_facebookUrl))) {
                      throw 'Could not launch this';
                    }
                  },
                  // child: const Text(
                  //   'Login',
                  //   style: TextStyle(fontSize: 25),
                  // ),
                ),
                verticalSpacing(12),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.twitter,
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(_twitterUrl))) {
                      throw 'Could not launch this';
                    }
                  },
                  // child: const Text(
                  //   'Login',
                  //   style: TextStyle(fontSize: 25),
                  // ),
                ),
                verticalSpacing(12),
                GestureDetector(
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(_mainUrl))) {
                      throw 'Could not launch this';
                    }
                  },
                  child: const Column(
                    children: [
                      Text(
                        'Find us on',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Linkedin Learning',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
