import 'package:flutter/cupertino.dart';

void nextPage({Widget? page, BuildContext? context}) {
  Navigator.push(context!, CupertinoPageRoute(builder: (_) => page!));
}

void nextPageOnly({Widget? page, BuildContext? context}) {
  Navigator.pushAndRemoveUntil(context!,
      CupertinoPageRoute(builder: (_) => page!), (route) => false);
}
