library domain;

import 'package:domain/di/locator.dart';

export './src/commons/commons.dart';
export 'src/map/map.dart';

class Domain {
  static void init(Map<String, String> env) {
    /// setup required locators for domain module
    configureDependencies(env);
  }
}
