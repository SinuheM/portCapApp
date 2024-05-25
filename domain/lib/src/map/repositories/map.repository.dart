library domain;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/map/providers/date.provider.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class MapRepository {
  final MapProvider _mapProvider;
  final DateProvider _dateProvider;
  final MapMapping _mapMapping;
  final ErrorMapping _errorMapping;
  MapRepository(this._mapProvider, this._dateProvider, this._mapMapping,
      this._errorMapping);

  final String keyCache = 'dio_cache_header_key_data_source';

  Stream<DateTime?> getDateLastUpdate({bool forceRefresh = false}) {
    return Stream.fromFuture(_dateProvider.read())
        .handleError(_errorMapping.toThrow);
  }

  Stream<GeoJsonParser> getPolygons({bool forceRefresh = false}) {
    return Stream.fromFuture(_mapProvider.getPolygons(forceRefresh))
        .doOnData((response) {
          final cachedResponse = response.headers.value(keyCache);
          if (cachedResponse == null) {
            _dateProvider.save(DateTime.now());
          }
        })
        .map((Response response) => _mapMapping.toPolygons(response.data))
        .handleError(_errorMapping.toThrow);
  }

  Stream<List<PolygonInfo>> getInformation({bool forceRefresh = false}) {
    return Stream.fromFuture(_mapProvider.getInformation(forceRefresh))
        .doOnData((response) {
          final cachedResponse = response.headers.value(keyCache);
          if (cachedResponse == null) {
            _dateProvider.save(DateTime.now());
          }
        })
        .map((Response response) => _mapMapping.parsePolygonInfo(response.data))
        .handleError(_errorMapping.toThrow);
  }

  Stream<Config> getConfig({bool forceRefresh = false}) {
    return Stream.fromFuture(_mapProvider.getConfig(forceRefresh))
        .doOnData((response) {
          final cachedResponse = response.headers.value(keyCache);
          if (cachedResponse == null) {
            _dateProvider.saveConfigDate(DateTime.now());
          }
        })
        .map((Response response) => _mapMapping.parseConfig(response.data))
        .handleError(_errorMapping.toThrow);
  }
}
