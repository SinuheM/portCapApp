import 'package:domain/di/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(Map<String, String> env) {
  $initGetIt(getIt, env: env);
}
