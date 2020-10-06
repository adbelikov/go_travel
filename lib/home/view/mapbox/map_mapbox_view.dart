//import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
//import 'package:provider/provider.dart';

// Add your Mapbox access token here
const String ACCESS_TOKEN =
    "pk.eyJ1IjoidmFuaGVscGVyIiwiYSI6ImNrZnZiOGVjbzE1M3QyenN2dGFrcnFuZTgifQ.yapxpspbl5zq44hXA29FCQ";

class MapBoxView extends StatefulWidget {
  MapBoxView({Key key}) : super(key: key);

  @override
  _MapBoxViewState createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> {
  Symbol _selectedSymbol;
  MapboxMapController mapController;

  //BuildContext _sheetContext;
  SheetController sheetController;

  @override
  void initState() {
    super.initState();
    internetAccess();
    sheetController = SheetController();
    sheetController.hide();
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
    //mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return viewMap();
    return SlidingSheet(
      //duration: const Duration(milliseconds: 900),
      controller: sheetController,
      shadowColor: Colors.black26,
      elevation: 8,
      //cornerRadius: 16,
      //cornerRadiusOnFullscreen: 0.0,
      //closeOnBackButtonPressed: true,
      //addTopViewPaddingOnFullscreen: true,
      //isBackdropInteractable: true,
      //liftOnScrollFooterElevation: 4.0,
      snapSpec: const SnapSpec(
        snap: true,
        snappings: [0.0, SnapSpec.headerSnap, 0.75, 1.0], // double.infinity
        positioning: SnapPositioning.relativeToAvailableSpace, //.pixelOffset,
      ),
      body: viewMap(),
      builder: (context, state) {
        return Container(
          height: 2500,
          child: Center(
            child: Text('This is the content of the sheet'),
          ),
        );
      },
      headerBuilder: (context, state) {
        return Container(
            height: 112,
            color: Colors.green,
            child: InkWell(
                onTap: () {
                  sheetController?.hide();
                },
                child: Center(
                  child: Text('Header'),
                )));
      },
      footerBuilder: (context, state) {
        return Container(
          height: 56,
          width: double.infinity,
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Text(
            'This is the footer',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.black),
          ),
        );
      },
    );
  }

  Widget viewMap() {
    print('--> Height = ${MediaQuery.of(context).size.height}');
    print('--> Width  = ${MediaQuery.of(context).size.width}');
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
    if (_selectedSymbol != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    sheetController?.snapToExtent(SnapSpec.headerSnap, duration: Duration(milliseconds: 500)); //.expand();
    setState(() {
      _selectedSymbol = argument;
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
    mapController.updateSymbol(_selectedSymbol, changes);
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
            //CircularProgressIndicator(),
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
