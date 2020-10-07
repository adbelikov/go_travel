import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
//import 'package:provider/provider.dart';
// view
import 'package:go_travel/home/view/sheet/sheet_view.dart';

// Add your Mapbox access token here
const String ACCESS_TOKEN =
    "pk.eyJ1IjoidmFuaGVscGVyIiwiYSI6ImNrZnZiOGVjbzE1M3QyenN2dGFrcnFuZTgifQ.yapxpspbl5zq44hXA29FCQ";

class MapBoxView extends StatefulWidget {
  MapBoxView({Key key}) : super(key: key);

  @override
  _MapBoxViewState createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> {
  Symbol _selectedMarker;
  MapboxMapController mapController;

  @override
  void initState() {
    super.initState();
    internetAccess();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    // слушаем тапы на маркеры
    mapController.onSymbolTapped.add(_markerTaped);
    // добавляем маркеры - задержка нужна из особенностей MAPBOX
    // без неё происходит крах при повторном заходе на страницу
    Future.delayed(Duration(milliseconds: 500), () async {
      mapController.addSymbol(
        SymbolOptions(
          geometry: LatLng(59.9590, 30.3618),
          iconImage: "assets/image/map_marker_red.png",
          iconSize: 1.0,
          //iconColor: '#3bb2d0',
        ),
      );
    });
  }

  @override
  void dispose() {
    mapController?.onSymbolTapped?.remove(_markerTaped);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return viewMap();
  }

  Widget viewMap() {
    return MapboxMap(
      myLocationEnabled: true,
      myLocationRenderMode: MyLocationRenderMode.GPS,
      //compassEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(3, 18),
      accessToken: ACCESS_TOKEN,
      trackCameraPosition: true,
      onMapCreated: _onMapCreated,
      onMapClick: (point, latLng) async {
        print(
            '--> Map press: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}');
      },
      onMapLongClick: (point, latLng) async {
        print(
            "--> Map long press: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}");
        //Point convertedPoint = await mapController.toScreenLocation(latLng);
        //LatLng convertedLatLng = await mapController.toLatLng(point);
        //print("Map long press converted: ${convertedPoint.x},${convertedPoint.y}   ${convertedLatLng.latitude}/${convertedLatLng.longitude}");

        List features =
            await mapController.queryRenderedFeatures(point, [], null);
        if (features.length > 0) {
          print(features[0]);
        }
      },
      initialCameraPosition:
          const CameraPosition(target: LatLng(59.9590, 30.3618), zoom: 15),
    );
  }

  void _markerTaped(Symbol argument) {
    // снимаем выделение с текущего маркера
    if (_selectedMarker != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    sheetView(context);
    //sheetController?.snapToExtent(SnapSpec.headerSnap, duration: Duration(milliseconds: 500)); //.expand();
    setState(() {
      _selectedMarker = argument;
    });
    // добавить появление информации по точке !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //_sheetController.show();

    // координаты маркера
    // print('marker press --> ${argument.options.geometry}');
    // выделяем новый маркер
    _updateSelectedSymbol(
      SymbolOptions(
        iconSize: 1.4,
      ),
    );
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    mapController.updateSymbol(_selectedMarker, changes);
  }

  // проверка наличия интернета
  internetAccess() {
    Future.delayed(Duration(milliseconds: 1000), () async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty || result[0].rawAddress.isNotEmpty) return;
      } on SocketException catch (_) {
        print('--> Eror Internet access');
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        //action: SnackBarAction(label: 'Ok', onPressed: () { homeScaffoldKey.currentState.hideCurrentSnackBar(); } ),
        // Scaffold.of(context).hideCurrentSnackBar();
        content: Row(
          children: [
            Icon(
              Icons.wifi_off,
              size: 32,
            ),
            Container(
              width: 16,
              height: 0,
            ),
            Text(
              'No Internet access',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ));
    });
  }
}

/*


view

Widget viewMap() {
    return MapboxMap(
      myLocationEnabled: true,
      myLocationRenderMode: MyLocationRenderMode.GPS,
      //compassEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(3, 18),
      accessToken: ACCESS_TOKEN,
      trackCameraPosition: true,
      onMapCreated: _onMapCreated,
      onMapClick: (point, latLng) async {
        print(
            '--> Map press: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}');
      },
      onMapLongClick: (point, latLng) async {
        print(
            "--> Map long press: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}");
        //Point convertedPoint = await mapController.toScreenLocation(latLng);
        //LatLng convertedLatLng = await mapController.toLatLng(point);
        //print("Map long press converted: ${convertedPoint.x},${convertedPoint.y}   ${convertedLatLng.latitude}/${convertedLatLng.longitude}");

        List features =
            await mapController.queryRenderedFeatures(point, [], null);
        if (features.length > 0) {
          print(features[0]);
        }
      },
      initialCameraPosition:
          const CameraPosition(target: LatLng(59.9590, 30.3618), zoom: 15),
    );
  }
  

    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(59.9590, 30.3618),
        iconImage: "assets/images/map_marker_red.png",
        iconSize: 2,
        iconColor: '#3bb2d0',
      ),
    );

    mapController.onSymbolTapped.add(_markerTaped);
    

return Container(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Container(height: 24),
          Text('no internet access'),
        ],
      ),
    );


      /*  
      internet().then((value) {
      if (value) { } else {
        return Center(child: Text('Not connect Internet'),);
      }
      */
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
*/

// https://github.com/tobrun/flutter-mapbox-gl/blob/master/example/lib/plase_symbol.dart
