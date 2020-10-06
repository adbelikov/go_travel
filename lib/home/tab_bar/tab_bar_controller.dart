import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyTabIndex = 'GoTabIndex';

class TabBarController {
  int _tabIndex;

  TabBarController() {
    _tabIndex = 0;
    _load();
  }

  // описание stream controllers //.broadcast();
  final StreamController<int> _tabControl = StreamController<int>();
  get tabControl => _tabControl.stream;

  dispose() {
    _tabControl?.close();
  }

  get tabIndex => this._tabIndex;

  set tabIndex(int val) {
    this._tabIndex = val;
    _tabControl.add(this._tabIndex);
    SharedPreferences.getInstance().then((_pref) {
      _pref.setInt(keyTabIndex, this._tabIndex);
    });
  }

  void _load() async {
    //Future.delayed(Duration(seconds: 5), () async {
    var _pref = await SharedPreferences.getInstance();
    _pref.containsKey(keyTabIndex)
        ? this._tabIndex = _pref.getInt(keyTabIndex) ?? 0
        : _pref.setInt(keyTabIndex, this._tabIndex);
    _tabControl.add(this._tabIndex);
    //});
  }

  final tabs = [
    {'icon': Icons.map, 'text': 'Map'},
    {'icon': Icons.pin_drop, 'text': 'Poi'},
    {'icon': Icons.toys_outlined, 'text': 'Setting'}
  ];
}
