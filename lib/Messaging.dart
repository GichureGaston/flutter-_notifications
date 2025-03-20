import 'package:flutter/material.dart';

class Messaging {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get openContext => navigatorKey.currentContext;
}
