import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/Authentication/auth_page.dart';
import 'package:wallpaper_app/Utils/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 2), () {
      nextPageOnly(context: context, page: const AuthPage());
    });


    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}
