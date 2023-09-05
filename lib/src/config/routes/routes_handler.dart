import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:presentation/containers/main/main_page.dart';

class RoutesHandler {
  // static var notFoundHandler = Handler(
  //     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  //   return const NotFoundPage();
  // });

  static var rootHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const MainPage();
  });
}
