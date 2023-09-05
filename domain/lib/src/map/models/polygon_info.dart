class PolygonInfo {
  int? capacidadPortante;
  String? contenidoDeHumedad;
  String? densidad;
  String? tipoDeSuelo;
  String? zona;

  PolygonInfo({
    this.capacidadPortante,
    this.contenidoDeHumedad,
    this.densidad,
    this.tipoDeSuelo,
    this.zona,
  });

  factory PolygonInfo.fromJson(Map<String, dynamic> json) => PolygonInfo(
        capacidadPortante: json["Capacidad portante"],
        contenidoDeHumedad: json["Contenido de humedad"],
        densidad: json["Densidad"],
        tipoDeSuelo: json["Tipo de suelo"],
        zona: json["Zona"],
      );

  Map<String, dynamic> toJson() => {
        "Capacidad portante": capacidadPortante,
        "Contenido de humedad": contenidoDeHumedad,
        "Densidad": densidad,
        "Tipo de suelo": tipoDeSuelo,
        "Zona": zona,
      };
}
