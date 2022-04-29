import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Provider/add_wallpaper_provider.dart';
import 'package:wallpaper_app/Provider/apply_wallpaper_provider.dart';
import 'package:wallpaper_app/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UploadWallPaperProvider()),
        ChangeNotifierProvider(create: (_) => ApplyWallpaperProvider()),
      ],
      child: const MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
