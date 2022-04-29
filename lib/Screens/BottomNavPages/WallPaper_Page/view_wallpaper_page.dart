import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Payment/payment.dart';
import 'package:wallpaper_app/Provider/apply_wallpaper_provider.dart';
import 'package:wallpaper_app/Utils/show_alert.dart';

class ViewWallPaperPage extends StatefulWidget {
  const ViewWallPaperPage({Key? key, this.data, this.path = ''})
      : super(key: key);

  final QueryDocumentSnapshot<Object?>? data;
  final String? path;

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
                onTap: () {
                  if (widget.data!.get('price') != '') {
                    ///Make payment with paystack
                    MakePayment(
                            ctx: context,
                            amount: widget.data!.get('price'),
                            image: widget.data!.get('wallpaper_image'))
                        .chargeCardAndMakePayment();
                  } else {
                    ///Show modal
                    showModal();
                  }
                },
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

  void showModal() {
    List<String> applyText = ['Home Screen', 'Lock Screen', 'Both'];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: Consumer<ApplyWallpaperProvider>(
                builder: (context, applyProvider, child) {
              WidgetsBinding.instance!.addPostFrameCallback(
                (timeStamp) {
                  if (applyProvider.message != '') {
                    showAlert(context, applyProvider.message);
                    applyProvider.clearMessage();
                    Navigator.pop(context);
                  }
                },
              );
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(applyProvider.status == true
                        ? 'Please wait... Applying'
                        : 'Apply'),
                  ),
                  ...List.generate(applyText.length, (index) {
                    final data = applyText[index];
                    return GestureDetector(
                      onTap: () {
                        print(index);
                        final image = widget.data!.get('wallpaper_image');
                        switch (index) {
                          case 0:

                            ///home
                            applyProvider.apply(image,
                                WallpaperManager.HOME_SCREEN, widget.path);
                            break;
                          case 1:

                            ///lock
                            applyProvider.apply(image,
                                WallpaperManager.LOCK_SCREEN, widget.path);
                            break;
                          case 2:

                            ///both
                            applyProvider.apply(image,
                                WallpaperManager.BOTH_SCREEN, widget.path);
                            break;
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width - 50,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          data,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    );
                  })
                ],
              );
            }),
          );
        });
  }
}
