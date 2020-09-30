import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// Add your Mapbox access token here
const String ACCESS_TOKEN =
    "pk.eyJ1IjoidmFuaGVscGVyIiwiYSI6ImNrZDQ3OG8wZTAxcjIydHBocG96bmMxOXAifQ.WiswOkU69fhWpQMbRz-GLg";

class MapBoxView extends StatefulWidget {
//MapBoxView({Key key}) : super(key: key);

  @override
  _MapBoxViewState createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> {
  //int _symbolCount = 0;
  Symbol _selectedSymbol;
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    // добавляем маркеры
    mapController.onSymbolTapped.add(_markerTaped);
    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(59.9590, 30.3618),
        iconImage: "assets/images/map_marker_red.png",
        iconSize: 2,
        iconColor: '#3bb2d0',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController?.onSymbolTapped?.remove(_markerTaped);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      myLocationEnabled: true,
      myLocationRenderMode: MyLocationRenderMode.GPS,
      compassEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(3, 18),
      accessToken: ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      onMapClick: null,
      initialCameraPosition:
          const CameraPosition(target: LatLng(59.9590, 30.3618), zoom: 16),
    );
  }

  void _markerTaped(Symbol argument) {
    if (_selectedSymbol != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    print('--> ${argument.options.geometry}'); // координаты маркера
    setState(() {
      _selectedSymbol = argument;
    });
    _updateSelectedSymbol(
      SymbolOptions(
        iconSize: 1.4,
      ),
    );
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    mapController.updateSymbol(_selectedSymbol, changes);
  }
}

// https://github.com/tobrun/flutter-mapbox-gl/blob/master/example/lib/plase_symbol.dart
