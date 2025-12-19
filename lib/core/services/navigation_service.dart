
import 'package:flutter/material.dart';


class NavigationService {
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<Future<Object?>> push (Widget page) async {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => page)
      );
  }
  void pop() {
    navigatorKey.currentState?.pop();
  }

}



