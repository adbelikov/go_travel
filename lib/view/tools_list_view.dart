import 'package:flutter/cupertino.dart';

class ToolsListView extends StatefulWidget {
  @override
  _ToolsListViewState createState() => _ToolsListViewState();
}

class _ToolsListViewState extends State<ToolsListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text('Tools List Page'),));
  }
}