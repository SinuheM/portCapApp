import 'dart:convert';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  Units? units;
  Values? values;

  Config({
    this.units,
    this.values,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        units: json["units"] == null ? null : Units.fromJson(json["units"]),
        values: json["values"] == null ? null : Values.fromJson(json["values"]),
      );

  Map<String, dynamic> toJson() => {
        "units": units?.toJson(),
        "values": values?.toJson(),
      };
}

class Units {
  String? cSymbol;
  String? cUnit;
  String? naturalWeightUnit;
  String? qSymbol;
  String? qUnit;

  Units({
    this.cSymbol,
    this.cUnit,
    this.naturalWeightUnit,
    this.qSymbol,
    this.qUnit,
  });

  factory Units.fromJson(Map<String, dynamic> json) => Units(
        cSymbol: json["c_symbol"],
        cUnit: json["c_unit"],
        naturalWeightUnit: json["natural_weight_unit"],
        qSymbol: json["q_symbol"],
        qUnit: json["q_unit"],
      );

  Map<String, dynamic> toJson() => {
        "c_symbol": cSymbol,
        "c_unit": cUnit,
        "natural_weight_unit": naturalWeightUnit,
        "q_symbol": qSymbol,
        "q_unit": qUnit,
      };
}

class Values {
  double? beta;
  double? fs;
  double? fd;

  Values({
    this.beta,
    this.fs,
    this.fd,
  });

  factory Values.fromJson(Map<String, dynamic> json) => Values(
        beta: json["beta"]?.toDouble(),
        fs: json["fs"]?.toDouble(),
        fd: json["fγd"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "beta": beta,
        "fs": fs,
        "fγd": fd,
      };
}
