import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SavePurchasedProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void save({
    required String? wallpaperImage,
  }) async {
    CollectionReference _products = _firestore.collection("PurchasedWallpaper");

    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      ///Upload Preview Images

      ///Then add the download url and other string to cloud firestore
      Map<String, dynamic> data = <String, dynamic>{
        "price": '',
        "uid": uid,
        "wallpaper_image": wallpaperImage,
      };

      _products.doc(uid).collection('Wallpaper').add(data);
      // // print(data);

    } catch (e) {
      print(e);
    }

    ///
  }
}
