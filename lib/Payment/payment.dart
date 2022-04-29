import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:wallpaper_app/Contansts/keys.dart';
import 'package:wallpaper_app/Provider/save_purchased_wallpaper.dart';
import 'package:wallpaper_app/Utils/show_alert.dart';

/// PayStack payment class
class MakePayment {
  ///
  MakePayment({this.ctx, this.image, this.amount});

  ///Context
  BuildContext? ctx;

  /// Customer Amount To Pay
  String? amount;

  String? image;

  ///PayStack instance
  PaystackPlugin paystack = PaystackPlugin();

  final User? _user = FirebaseAuth.instance.currentUser;

  ///Get the Reference
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  ///PayStack Payment Card widget UI
  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: "",
      cvc: "",
      expiryMonth: 0,
      expiryYear: 0,
      country: '',
      name: _user!.displayName,
    );
  }

  ///Initialize paystack public key
  Future initializePlugin() async {
    await paystack.initialize(publicKey: Constant.PAYSTACK_KEY);
  }

  ///Method for charging card
  chargeCardAndMakePayment() async {
    final String price = amount!.replaceAll(',', '');
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = int.parse(price) * 100 // In base currency
        ..email = _user!.email
        ..currency = 'NGN'
        ..reference = _getReference()
        ..card = _getCardFromUI();

      CheckoutResponse response = await paystack.checkout(
        ctx!,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        // logo: Image.asset("assets/logo.png", width: 50, height: 50),
      );

      print('Response = $response');

      final String message = response.message;

      if (response.status == true) {
        ///GENERATE USERS RECEIPT
        SavePurchasedProvider().save(wallpaperImage: image);

        showAlert(ctx!, 'Wall Paper Saved to Downloads');
      } else {
        // // print(false);
        showAlert(ctx!, message);
      }
    });
  }
}
