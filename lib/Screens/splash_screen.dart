import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/Authentication/auth_page.dart';
import 'package:wallpaper_app/Screens/main_activity.dart';
import 'package:wallpaper_app/Utils/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if(auth.currentUser == null){
        nextPageOnly(context: context, page: const AuthPage());
      }else {
        nextPageOnly(context: context, page: const MainActivityPage());
      }
    });

    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}
