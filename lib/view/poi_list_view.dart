import 'package:flutter/cupertino.dart';

class PoiListView extends StatefulWidget {
  @override
  _PoiListViewState createState() => _PoiListViewState();
}

class _PoiListViewState extends State<PoiListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text('Poi List Page'),));
  }
}