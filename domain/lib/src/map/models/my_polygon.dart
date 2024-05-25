import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MyPolygon extends Polygon {
  final String key;

  MyPolygon({
    required this.key,
    required List<LatLng> points,
    List<List<LatLng>>? holePointsList,
    Color color = const Color(0xFF00FF00),
    double borderStrokeWidth = 0.0,
    Color borderColor = const Color(0xFFFFFF00),
    bool disableHolesBorder = false,
    bool isDotted = false,
    bool isFilled = false,
    StrokeCap strokeCap = StrokeCap.round,
    StrokeJoin strokeJoin = StrokeJoin.round,
    String? label,
    TextStyle labelStyle = const TextStyle(),
    PolygonLabelPlacement labelPlacement = PolygonLabelPlacement.centroid,
    bool rotateLabel = false,
  }) : super(
    points: points,
    holePointsList: holePointsList,
    color: color,
    borderStrokeWidth: borderStrokeWidth,
    borderColor: borderColor,
    disableHolesBorder: disableHolesBorder,
    isDotted: isDotted,
    isFilled: isFilled,
    strokeCap: strokeCap,
    strokeJoin: strokeJoin,
    label: label,
    labelStyle: labelStyle,
    labelPlacement: labelPlacement,
    rotateLabel: rotateLabel,
  );
}
