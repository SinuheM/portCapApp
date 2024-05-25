part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetDateLastUpdateEvent extends MapEvent {}

class GetPolygonsEvent extends MapEvent {
  final bool forceRefresh;
  const GetPolygonsEvent({this.forceRefresh = false});
}

class GetPolygonsInformationEvent extends MapEvent {
  final bool forceRefresh;
  const GetPolygonsInformationEvent({this.forceRefresh = false});
}

class GetConfigEvent extends MapEvent {
  final bool forceRefresh;
  const GetConfigEvent({this.forceRefresh = false});
}
