import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class MapProvider {
  final ApiProvider _apiProvider;
  MapProvider(this._apiProvider);

  Future<Response> getPolygons(bool forceRefresh) async {
    return _apiProvider.get('/geojson.json', forceRefresh: forceRefresh);
  }

  Future<Response> getInformation(bool forceRefresh) async {
    return _apiProvider.get('/cap_data_test.json', forceRefresh: forceRefresh);
  }

  Future<Response> getConfig(bool forceRefresh) async {
    return _apiProvider.get('/config.json', forceRefresh: forceRefresh);
  }
}
