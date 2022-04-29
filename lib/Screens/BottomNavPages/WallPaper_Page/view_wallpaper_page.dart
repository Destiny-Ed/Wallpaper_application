import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewWallPaperPage extends StatefulWidget {
  const ViewWallPaperPage({Key? key, this.data}) : super(key: key);

  final QueryDocumentSnapshot<Object?>? data;

  @override
  State<ViewWallPaperPage> createState() => _ViewWallPaperPageState();
}

class _ViewWallPaperPageState extends State<ViewWallPaperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            widget.data!.get('wallpaper_image'),
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    widget.data!.get('price') == '' ? 'Apply' : 'Purchase',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
