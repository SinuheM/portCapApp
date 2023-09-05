import 'package:fluro/fluro.dart';
import '../routes/routes_handler.dart';

class Routes {
  static String root = "/";
  static String home = "/home";

  static void configureRoutes(FluroRouter router) {
    router.define(
      root,
      handler: RoutesHandler.rootHandler,
    );

    // router.define(home,
    //     handler: RoutesHandler.homeScreen,
    //     transitionType: TransitionType.inFromLeft);
  }
}
