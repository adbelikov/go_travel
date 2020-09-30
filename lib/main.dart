// Copyright 2020 Andrey Belikov. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:go_travel/view/map_mapbox_view.dart';
// import 'package:sliding_sheet/sliding_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO Travel',
      // ThemeData.light(),
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.amber,
        primaryColor: Colors.lightBlue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GO Travel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PanelController _pc = new PanelController();

  // final List<Widget> _widgetOptions = <Widget>[];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SlidingUpPanel(
        controller: _pc,
        parallaxEnabled: true,
        parallaxOffset: 0.6,
        panelSnapping: true,
        color: Theme.of(context).primaryColor,
        slideDirection: SlideDirection.DOWN,
        minHeight: 20,
        maxHeight: MediaQuery.of(context).size.height * 0.6, //- 140, //600,
        backdropEnabled: true,
        collapsed: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              color: Theme.of(context).accentColor,
              width: 100,
              height: 6,
            ),
          ),
        ),
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: Center(
          child: MapBoxView(),
          //child: Text("This is the Widget behind the sliding panel", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map, size: 28),
            title: Text('Map', style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder, size: 28),
            title: Text('List', style: optionStyle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            title: Text('Tools', style: optionStyle),
          ),
        ],
        currentIndex: _selectedIndex,
        //fixedColor: Colors.red,
        selectedItemColor: Theme.of(context).accentColor, //Colors.amber[800],
        onTap: null,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor, //.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pc.isPanelShown ? _pc.hide() : _pc.show();
        },
      ),
    );
  }
}

/*
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SlidingSheet(
        elevation: 4,
        cornerRadius: 0,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.03, 0.6, 1.0],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Center(
          child: Text('This widget is below the SlidingSheet'),
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return Container(
            height: 1500,
            child: Center(
              child: Text('This is the content of the sheet'),
            ),
          );
        },
        headerBuilder: (context, state) {
          return Container(
            height: 56,
            width: double.infinity,
            color: Colors.white60,
            alignment: Alignment.center,
            child: Text(
              'This is the header',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black),
            ),
          );
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
                  .bodyText1
                  .copyWith(color: Colors.black),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: null,
        elevation: 12,
      ),
    );
  }
}
*/
