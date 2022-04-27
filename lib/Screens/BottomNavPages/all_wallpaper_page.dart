import 'package:flutter/material.dart';

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
          onPressed: () {}, label: const Text('Upload')),
    );
  }
}
