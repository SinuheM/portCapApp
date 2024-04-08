import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
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
    emit(state.copyWith(
      hasError: false,
      isInfoRefreshed: false,
      isInfoLoading: false,
    ));

    await emit.forEach<List<PolygonInfo>>(
        _mapRepository.getInformation(forceRefresh: event.forceRefresh),
        onData: (polygonsInformation) {
      return state.copyWith(
          polygonsInformation: polygonsInformation,
          isInfoRefreshed: event.forceRefresh ? true : false,
          isInfoLoading: false);
    }, onError: <Exception>(exception, __) {
      return state.copyWith(
          hasError: true, exception: exception, isInfoLoading: false);
    });
  }

  void _onGetPolygons(GetPolygonsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(
      hasError: false,
      isInfoRefreshed: false,
      isInfoLoading: true,
    ));

    await emit.forEach<GeoJsonParser>(
        _mapRepository.getPolygons(forceRefresh: event.forceRefresh),
        onData: (geoJsonParser) {
      return state.copyWith(
          polygons: geoJsonParser.polygons,
          isInfoRefreshed: event.forceRefresh ? true : false,
          isInfoLoading: false);
    }, onError: <Exception>(exception, __) {
      return state.copyWith(
        hasError: true,
        exception: exception,
        isInfoLoading: false,
      );
    });
    if (!event.forceRefresh) {
      add(GetDateLastUpdateEvent());
    }
  }
}
