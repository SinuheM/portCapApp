import 'package:domain/src/map/models/config.dart';
import 'package:domain/src/map/models/geojson.dart';
import 'package:domain/src/map/models/polygon_info.dart';
import 'package:flutter/material.dart';

class MapMapping {
  GeoJsonParser toPolygons(Map<String, dynamic> geojson) {
    GeoJsonParser myGeoJson = GeoJsonParser(
        defaultMarkerColor: const Color(0XFF68aecb),
        defaultPolygonBorderColor: Colors.blue);
    myGeoJson.parseGeoJson(geojson);
    return myGeoJson;
  }

  List<PolygonInfo> parsePolygonInfo(Map<String, dynamic> geojson) {
    List<PolygonInfo> listInformation = [];
    List<dynamic> data = geojson.values.first as List<dynamic>;
    for (var element in data) {
      listInformation
          .add(PolygonInfo.fromJson(element as Map<String, dynamic>));
    }
    return listInformation;
  }

  Config parseConfig(Map<String, dynamic> geojson) {
    return Config.fromJson(geojson);
  }
}
