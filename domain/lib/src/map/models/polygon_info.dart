// To parse this JSON data, do
//
//     final polygonInfo = polygonInfoFromJson(jsonString);

import 'dart:convert';

PolygonInfo polygonInfoFromJson(String str) =>
    PolygonInfo.fromJson(json.decode(str));

String polygonInfoToJson(PolygonInfo data) => json.encode(data.toJson());

class PolygonInfo {
  String? capacidadPortante;
  List<String>? cohesinYAnguloDeFriccin;
  String? contenidoDeHumedad;
  List<String>? limites;
  String? pesoEspecficoNatural;
  String? tipoDeSueloAashto;
  String? tipoDeSueloSucs;
  String? zona;
  String? id;
  List<String>? cimentacionSuperficialPropuesta;

  PolygonInfo({
    this.capacidadPortante,
    this.cohesinYAnguloDeFriccin,
    this.contenidoDeHumedad,
    this.limites,
    this.pesoEspecficoNatural,
    this.tipoDeSueloAashto,
    this.tipoDeSueloSucs,
    this.zona,
    this.id,
    this.cimentacionSuperficialPropuesta
  });

  PolygonInfo copyWith({
    String? capacidadPortante,
    List<String>? cohesinYAnguloDeFriccin,
    String? contenidoDeHumedad,
    List<String>? limites,
    String? pesoEspecficoNatural,
    String? tipoDeSueloAashto,
    String? tipoDeSueloSucs,
    String? zona,
    String? id,
    List<String>? cimentacionSuperficialPropuesta
  }) =>
      PolygonInfo(
        capacidadPortante: capacidadPortante ?? this.capacidadPortante,
        cohesinYAnguloDeFriccin:
            cohesinYAnguloDeFriccin ?? this.cohesinYAnguloDeFriccin,
        contenidoDeHumedad: contenidoDeHumedad ?? this.contenidoDeHumedad,
        limites: limites ?? this.limites,
        pesoEspecficoNatural: pesoEspecficoNatural ?? this.pesoEspecficoNatural,
        tipoDeSueloAashto: tipoDeSueloAashto ?? this.tipoDeSueloAashto,
        tipoDeSueloSucs: tipoDeSueloSucs ?? this.tipoDeSueloSucs,
        zona: zona ?? this.zona,
        id: id ?? this.id,
        cimentacionSuperficialPropuesta: cimentacionSuperficialPropuesta ?? this.cimentacionSuperficialPropuesta
      );

  factory PolygonInfo.fromJson(Map<String, dynamic> json) => PolygonInfo(
        capacidadPortante: json["Capacidad portante"],
        cohesinYAnguloDeFriccin: json["Cohesión y angulo de fricción"] == null
            ? []
            : List<String>.from(
                json["Cohesión y angulo de fricción"]!.map((x) => x)),
        contenidoDeHumedad: json["Contenido de humedad"],
        limites: json["Limites"] == null
            ? []
            : List<String>.from(json["Limites"]!.map((x) => x)),
        pesoEspecficoNatural: json["Peso específico natural"],
        tipoDeSueloAashto: json["Tipo de suelo Aashto"],
        tipoDeSueloSucs: json["Tipo de suelo Sucs"],
        zona: json["Zona"],
        id: json["ID"],
        cimentacionSuperficialPropuesta: json["Cimentación superficial propuesta"] == null
            ? []
            : List<String>.from(json["Cimentación superficial propuesta"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Capacidad portante": capacidadPortante,
        "Cohesión y angulo de fricción": cohesinYAnguloDeFriccin == null
            ? []
            : List<dynamic>.from(cohesinYAnguloDeFriccin!.map((x) => x)),
        "Contenido de humedad": contenidoDeHumedad,
        "Limites":
            limites == null ? [] : List<dynamic>.from(limites!.map((x) => x)),
        "Peso específico natural": pesoEspecficoNatural,
        "Tipo de suelo Aashto": tipoDeSueloAashto,
        "Tipo de suelo Sucs": tipoDeSueloSucs,
        "Zona": zona,
        "ID": id,
        "Cimentación superficial propuesta": 
          cimentacionSuperficialPropuesta == null ? [] : List<dynamic>.from(cimentacionSuperficialPropuesta!.map((x) => x)),
      };
}
