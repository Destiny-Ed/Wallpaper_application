import 'package:flutter/material.dart';
import 'package:wallpaper_app/Screens/BottomNavPages/WallPaper_Page/add_wallpaper_page.dart';
import 'package:wallpaper_app/Utils/routers.dart';

class WallPaperHomePage extends StatefulWidget {
  const WallPaperHomePage({Key? key}) : super(key: key);

  @override
  State<WallPaperHomePage> createState() => _WallPaperHomePageState();
}

class _WallPaperHomePageState extends State<WallPaperHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("All Wallpaper")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            nextPage(context: context, page: const AddWallPaperPage());
          },
          label: const Text('Upload')),
    );
  }
}
