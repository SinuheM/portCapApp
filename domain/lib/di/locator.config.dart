import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/map/providers/date.provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// const secureStorage = FlutterSecureStorage();
GetIt $initGetIt(GetIt getIt,
    {String? environment,
    EnvironmentFilter? environmentFilter,
    Map<String, String>? env}) {
  final gh = GetItHelper(getIt, environment);

  gh.factory<ApiProvider>(
      () => ApiProvider(urlServer: env?['API_URL'] as String));

  // Config config = Config(
  //   tenant: env?['OAUTH_TENANT'] as String,
  //   clientId: env?['OAUTH_CLIENTID'] as String,
  //   scope: env?['OAUTH_SCOPE'] as String,
  //   redirectUri: env?['OAUTH_REDIRECT_URI'] as String,
  //   navigatorKey: GlobalNavigator.navigatorKey,
  // );

  //commons
  gh.factory<ErrorMapping>(() => ErrorMapping());
  gh.factory<DateProvider>(() => DateProvider());

  // map
  gh.factory<MapProvider>(() => MapProvider(getIt<ApiProvider>()));
  gh.factory<MapMapping>(() => MapMapping());
  gh.factory<MapRepository>(() => MapRepository(
        getIt<MapProvider>(),
        getIt<DateProvider>(),
        getIt<MapMapping>(),
        getIt<ErrorMapping>(),
      ));

  return getIt;
}
