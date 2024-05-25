part of 'map_bloc.dart';

enum DataState { initial, loading, loaded, refreshed, error }

class MapState extends Equatable {
  final List<MyPolygon> polygons;
  final List<PolygonInfo> polygonsInformation;
  final DataState dataState;
  final Exception? exception;
  final DateTime? dateLastUpdate;
  final DateTime? configLastUpdateDate;
  final Config? config;

  const MapState(
      {this.polygons = const [],
      this.polygonsInformation = const [],
      this.dataState = DataState.initial,
      this.exception,
      this.dateLastUpdate,
      this.configLastUpdateDate,
      this.config});
  const MapState._(
      {this.polygons = const [],
      this.polygonsInformation = const [],
      this.dataState = DataState.initial,
      this.dateLastUpdate,
      this.exception,
      this.configLastUpdateDate,
      this.config});
  const MapState.initial()
      : this._(
            polygons: const [],
            polygonsInformation: const [],
            dataState: DataState.initial,
            exception: null,
            dateLastUpdate: null,
            configLastUpdateDate: null,
            config: null);

  MapState copyWith(
      {List<MyPolygon>? polygons,
      List<PolygonInfo>? polygonsInformation,
      DataState? dataState,
      Exception? exception,
      DateTime? dateLastUpdate,
      DateTime? configLastUpdateDate,
      Config? config}) {
    return MapState(
      polygons: polygons ?? this.polygons,
      polygonsInformation: polygonsInformation ?? this.polygonsInformation,
      exception: exception ?? this.exception,
      dateLastUpdate: dateLastUpdate ?? this.dateLastUpdate,
      configLastUpdateDate: configLastUpdateDate ?? this.configLastUpdateDate,
      config: config ?? this.config,
      dataState: dataState ?? this.dataState,
    );
  }

  @override
  List<Object?> get props => [
        polygons,
        polygonsInformation,
        dataState,
        dateLastUpdate,
        configLastUpdateDate,
        config
      ];
}

class MapInitial extends MapState {}
