import 'package:flutter/foundation.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:wallpaper_app/Provider/save_purchased_wallpaper.dart';
import 'package:wallpaper_app/Utils/convert_url_to_file.dart';

class ApplyWallpaperProvider extends ChangeNotifier {
  String _message = '';
  bool _status = false;

  String get message => _message;
  bool get status => _status;

  void apply(String? image, int? location, String? path) async {
    _status = true;
    notifyListeners();

    try {
      final file = await converUrlToFile(image!);
      await WallpaperManager.setWallpaperFromFile(file.path, location!);

      if (path != 'saved') {
        SavePurchasedProvider().save(wallpaperImage: image);
      }

      _status = false;
      _message = 'Applied';
      notifyListeners();
    } catch (e) {
      print(e);
      _status = false;
      _message = 'Error occured';
      notifyListeners();
    }
  }

  void clearMessage() {
    _message = '';
    notifyListeners();
  }
}
