// To parse this JSON data, do
//
//     final polygonInfo = polygonInfoFromJson(jsonString);

import 'dart:convert';

List<PolygonInfo> polygonInfoFromJson(String str) => List<PolygonInfo>.from(
    json.decode(str).map((x) => PolygonInfo.fromJson(x)));

String polygonInfoToJson(List<PolygonInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PolygonInfo {
  String? capacidadPortante;
  List<String>? cimentacinSuperficialPropuesta;
  CohesinYAnguloDeFriccin? cohesinYAnguloDeFriccin;
  String? contenidoDeHumedad;
  String? id;
  List<String>? limites;
  double? pesoEspecficoNatural;
  String? tipoDeSueloAashto;
  String? tipoDeSueloSucs;
  String? zona;

  PolygonInfo({
    this.capacidadPortante,
    this.cimentacinSuperficialPropuesta,
    this.cohesinYAnguloDeFriccin,
    this.contenidoDeHumedad,
    this.id,
    this.limites,
    this.pesoEspecficoNatural,
    this.tipoDeSueloAashto,
    this.tipoDeSueloSucs,
    this.zona,
  });

  factory PolygonInfo.fromJson(Map<String, dynamic> json) => PolygonInfo(
        capacidadPortante: json["Capacidad portante"],
        cimentacinSuperficialPropuesta:
            json["Cimentación superficial propuesta"] == null
                ? []
                : List<String>.from(
                    json["Cimentación superficial propuesta"]!.map((x) => x)),
        cohesinYAnguloDeFriccin: json["Cohesión y angulo de fricción"] == null
            ? null
            : CohesinYAnguloDeFriccin.fromJson(
                json["Cohesión y angulo de fricción"]),
        contenidoDeHumedad: json["Contenido de humedad"],
        id: json["ID"],
        limites: json["Limites"] == null
            ? []
            : List<String>.from(json["Limites"]!.map((x) => x)),
        pesoEspecficoNatural: json["Peso específico natural"]?.toDouble(),
        tipoDeSueloAashto: json["Tipo de suelo Aashto"],
        tipoDeSueloSucs: json["Tipo de suelo Sucs"],
        zona: json["Zona"],
      );

  Map<String, dynamic> toJson() => {
        "Capacidad portante": capacidadPortante,
        "Cimentación superficial propuesta": cimentacinSuperficialPropuesta ==
                null
            ? []
            : List<dynamic>.from(cimentacinSuperficialPropuesta!.map((x) => x)),
        "Cohesión y angulo de fricción": cohesinYAnguloDeFriccin?.toJson(),
        "Contenido de humedad": contenidoDeHumedad,
        "ID": id,
        "Limites":
            limites == null ? [] : List<dynamic>.from(limites!.map((x) => x)),
        "Peso específico natural": pesoEspecficoNatural,
        "Tipo de suelo Aashto": tipoDeSueloAashto,
        "Tipo de suelo Sucs": tipoDeSueloSucs,
        "Zona": zona,
      };
}

class CohesinYAnguloDeFriccin {
  double? c;
  double? q;

  CohesinYAnguloDeFriccin({
    this.c,
    this.q,
  });

  factory CohesinYAnguloDeFriccin.fromJson(Map<String, dynamic> json) =>
      CohesinYAnguloDeFriccin(
        c: json["c"]?.toDouble(),
        q: json["q"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "c": c,
        "q": q,
      };
}
