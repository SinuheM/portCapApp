import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
// ignore: implementation_imports
import 'package:domain/src/map/models/my_polygon.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository _mapRepository;

  MapBloc({
    required MapRepository mapRepository,
  })  : _mapRepository = mapRepository,
        super(const MapState.initial()) {
    on<GetDateLastUpdateEvent>(_onGetDateLastUpdate);

    on<GetPolygonsEvent>(_onGetPolygons);
    on<GetPolygonsInformationEvent>(_onGetPolygonsInformation);
    on<GetConfigEvent>(_onGetConfig);
  }

  void _onGetDateLastUpdate(
      GetDateLastUpdateEvent event, Emitter<MapState> emit) async {
    await emit.forEach<DateTime?>(_mapRepository.getDateLastUpdate(),
        onData: (dateTime) {
      return state.copyWith(dateLastUpdate: dateTime);
    }, onError: <Exception>(exception, __) {
      return state.copyWith(
        exception: exception,
      );
    });
  }

  void _onGetPolygonsInformation(
      GetPolygonsInformationEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(dataState: DataState.loading));
    await emit.forEach<List<PolygonInfo>>(
        _mapRepository.getInformation(forceRefresh: event.forceRefresh),
        onData: (polygonsInformation) {
      return state.copyWith(polygonsInformation: polygonsInformation);
    }, onError: <Exception>(exception, __) {
      return state.copyWith(dataState: DataState.error, exception: exception);
    });
    add(GetConfigEvent(forceRefresh: event.forceRefresh));
  }

  void _onGetConfig(GetConfigEvent event, Emitter<MapState> emit) async {
    await emit.forEach<Config>(
        _mapRepository.getConfig(forceRefresh: event.forceRefresh),
        onData: (config) {
      return state.copyWith(config: config);
    }, onError: <Exception>(exception, __) {
      return state.copyWith(dataState: DataState.error, exception: exception);
    });
    emit(state.copyWith(
        dataState:
            event.forceRefresh ? DataState.refreshed : DataState.loaded));
  }

  void _onGetPolygons(GetPolygonsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(dataState: DataState.loading));

    await emit.forEach<GeoJsonParser>(
        _mapRepository.getPolygons(forceRefresh: event.forceRefresh),
        onData: (geoJsonParser) {
      return state.copyWith(
        polygons: geoJsonParser.polygons,
      );
    }, onError: <Exception>(exception, __) {
      return state.copyWith(
        exception: exception,
      );
    });
    if (!event.forceRefresh) {
      add(GetDateLastUpdateEvent());
    }
  }
}
