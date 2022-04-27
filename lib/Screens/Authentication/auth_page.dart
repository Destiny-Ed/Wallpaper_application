import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/main_activity.dart';
import 'package:wallpaper_app/Utils/routers.dart';
import 'package:wallpaper_app/Widget/custom_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: customButtom(
                text: 'Continue with google',
                onTap: () {
                  nextPage(page: const MainActivityPage(), context: context);
                },
                textColor: Colors.white,
                bgColor: Colors.blue,
                icon: const Icon(
                  Icons.mail_outline,
                  color: Colors.red,
                ))),
      ),
    );
  }
}
