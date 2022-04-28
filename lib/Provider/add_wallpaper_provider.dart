import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadWallPaperProvider extends ChangeNotifier {
  String _message = "";

  bool _status = false;

  String get message => _message;

  bool get status => _status;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Cloud Storage Instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void clear() {
    _message = "";
    notifyListeners();
  }

  void addWallPaper({
    File? wallPaperImage,
    String? uid,
    String? price,
  }) async {
    _status = true;
    notifyListeners();

    CollectionReference _products =
        _firestore.collection("AllWallpaper");

    String imagePath = '';

    try {
      _message = 'Uploading Image...';
      notifyListeners();

      final imageName = wallPaperImage!.path.split('/').last;

      await _storage
          .ref()
          .child("$uid/WallPaper/$imageName")
          .putFile(wallPaperImage)
          .whenComplete(() async {
        await _storage
            .ref()
            .child("$uid/WallPaper/$imageName")
            .getDownloadURL()
            .then((value) {
          imagePath = value;
        });

        final data = {'price': price, 'uid': uid, 'wallpaper_image': imagePath};

        ///Save to database
        await _products.add(data);

        _status = false;
        _message = 'Successful';
        notifyListeners();

        ///
      });
    } on FirebaseException catch (e) {
      _status = false;
      _message = e.message.toString();
      notifyListeners();
    } on SocketException catch (_) {
      _status = false;
      _message = "Internet is required to perform this action";
      notifyListeners();
    } catch (e) {
      print(e);
      _status = false;
      _message = "Please try again...";
      notifyListeners();
    }
  }
}
