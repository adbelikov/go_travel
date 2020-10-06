// Copyright 2020 Andrey Belikov. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

//import 'dart:io';

import 'package:flutter/material.dart';
// controller
// views
import 'package:go_travel/home/home_page_view.dart';


//enum ThemeName { Internrt, NoInternrt, Unknown }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'GO Travel',
      // ThemeData.light(),
      theme: ThemeData(
        brightness: Brightness.light, //.dark, //.light,//
        //accentColor: Colors.amber,
        //primaryColor: Colors.lightBlue[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,  
      ),
      home: HomePage(title: 'Go Travel'),
    );
  }
}

