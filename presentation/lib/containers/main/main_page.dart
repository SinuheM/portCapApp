import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:presentation/containers/commons/messages/bloc/message_bloc.dart';
import 'package:presentation/containers/main/bloc/map_bloc.dart';
import 'package:geodesy/geodesy.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:presentation/containers/main/widgets/config_modal.dart';
import 'package:presentation/containers/main/widgets/draggable_info.dart';
import 'package:presentation/containers/main/widgets/floating_button.dart';
import 'package:presentation/styles/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _locationData;
  late MapBloc mapBloc;
  late MessageBloc messageBloc;
  MapController mapController = MapController();
  Geodesy geodesy = Geodesy();
  PolygonInfo? _polygonInfo;
  Polygon? selectedPolygon;

  @override
  void initState() {
    super.initState();
    mapBloc = context.read<MapBloc>();
    messageBloc = context.read<MessageBloc>();
    mapBloc
      ..add(const GetPolygonsEvent())
      ..add(const GetPolygonsInformationEvent());
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  _getLocation() async {
    _locationData = await location.getLocation();
    if (_locationData != null) {
      mapController.move(
          LatLng(_locationData!.latitude!, _locationData!.longitude!), 18);
    }
  }

  searchPointInPolygons(List<Polygon> polygons,
      List<PolygonInfo> polygonInformation, LatLng point) {
    for (var element in polygons) {
      bool isGeoPointInPolygon =
          geodesy.isGeoPointInPolygon(point, element.points);
      if (isGeoPointInPolygon) {
        mapController.move(geodesy.findPolygonCentroid(element.points), 18);
        final polygonInfo =
            polygonInformation.firstWhereOrNull((e) => e.zona == element.label);
        setState(() {
          _polygonInfo = polygonInfo;
          selectedPolygon = Polygon(
            color: orange.withOpacity(0.2),
            points: element.points,
            borderColor: orange,
            isFilled: true,
            borderStrokeWidth: 1,
          );
        });
      }
    }
  }

  showModal() {
    showDialog(
      barrierColor: black.withOpacity(0.3),
      context: context,
      builder: (context) {
        return const ConfigModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state.hasError) {
            messageBloc.add(
                ShowErrorMessageEvent((state.exception as dynamic).message));
          }
          if (state.isInfoRefreshed) {
            mapBloc.add(GetDateLastUpdateEvent());
            messageBloc.add(const ShowSuccessMessageEvent(
                'Información actualizada exitosamente.'));
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: const LatLng(-12.1145, -75.2145),
                      zoom: 16,
                      minZoom: 3,
                      maxZoom: 18,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      onTap: (tapPosition, point) {
                        searchPointInPolygons(
                            state.polygons, state.polygonsInformation, point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      PolygonLayer(
                        polygons: state.polygons,
                      ),
                      if (selectedPolygon != null)
                        PolygonLayer(
                          polygons: [selectedPolygon!],
                        )
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FloatingOptionButton(
                      onTap: showModal,
                      icon: Icons.settings,
                    ),
                  ),
                  Positioned(
                    top: 72,
                    right: 10,
                    child: FloatingOptionButton(
                      onTap: _getLocation,
                      icon: Icons.my_location,
                    ),
                  ),
                  if (_polygonInfo != null)
                    DraggableInfo(polygonInfo: _polygonInfo!)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
