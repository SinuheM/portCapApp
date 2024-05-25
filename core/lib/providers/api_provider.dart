import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_http_cache_fix/dio_http_cache.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class ApiProvider {
  late Dio api;
  ApiProvider({String urlServer = ''}) {
    var options = BaseOptions(
        baseUrl: urlServer,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    api = Dio(options);

    api.interceptors.add(DioCacheManager(CacheConfig(
      baseUrl: urlServer,
    )).interceptor);

    api.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    configCache();
  }

  configCache() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var cacheStore = HiveCacheStore(tempPath);
    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: true,
    );
    api.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      bool forceRefresh = false}) {
    return api.get(url,
        queryParameters: queryParameters,
        options: forceRefresh
            ? options
            : buildCacheOptions(const Duration(days: 7), options: options));
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? data,
      List<Map<String, dynamic>>? arrayData,
      FormData? multiPartData,
      Options? options,
      bool useCache = false}) {
    return api.post(url,
        data: data ?? multiPartData ?? arrayData,
        options: useCache
            ? buildCacheOptions(const Duration(days: 1), options: options)
            : options);
  }

  Future<Response> put(String url,
      {Map<String, dynamic>? data, Options? options, bool useCache = false}) {
    return api.put(url,
        data: data,
        options: useCache
            ? buildCacheOptions(const Duration(days: 1), options: options)
            : options);
  }

  Future<Response> delete(String url,
      {Map<String, dynamic>? data, Options? options}) {
    return api.delete(url, data: data, options: options);
  }

  Future<Response> patch(String url,
      {Map<String, dynamic>? data, Options? options}) {
    return api.patch(url, data: data, options: options);
  }
}
