part of 'map_bloc.dart';

class MapState extends Equatable {
  final List<MyPolygon> polygons;
  final List<PolygonInfo> polygonsInformation;
  final bool hasError;
  final bool isInfoLoading;

  final bool isInfoRefreshed;
  final Exception? exception;
  final DateTime? dateLastUpdate;

  const MapState({
    this.polygons = const [],
    this.polygonsInformation = const [],
    this.hasError = false,
    this.isInfoRefreshed = false,
    this.isInfoLoading = false,
    this.exception,
    this.dateLastUpdate,
  });
  const MapState._(
      {this.polygons = const [],
      this.polygonsInformation = const [],
      this.hasError = false,
      this.isInfoRefreshed = false,
      this.isInfoLoading = false,
      this.dateLastUpdate,
      this.exception});
  const MapState.initial()
      : this._(
            polygons: const [],
            polygonsInformation: const [],
            hasError: false,
            isInfoLoading: false,
            isInfoRefreshed: false,
            exception: null,
            dateLastUpdate: null);

  MapState copyWith(
      {List<MyPolygon>? polygons,
      List<PolygonInfo>? polygonsInformation,
      bool? hasError,
      bool? isInfoRefreshed,
      bool? isInfoLoading,
      Exception? exception,
      DateTime? dateLastUpdate}) {
    return MapState(
      polygons: polygons ?? this.polygons,
      polygonsInformation: polygonsInformation ?? this.polygonsInformation,
      hasError: hasError ?? this.hasError,
      exception: exception ?? this.exception,
      isInfoRefreshed: isInfoRefreshed ?? this.isInfoRefreshed,
      dateLastUpdate: dateLastUpdate ?? this.dateLastUpdate,
      isInfoLoading: isInfoLoading ?? this.isInfoLoading,
    );
  }

  @override
  List<Object?> get props => [
        polygons,
        polygonsInformation,
        hasError,
        isInfoRefreshed,
        dateLastUpdate
      ];
}

class MapInitial extends MapState {}
