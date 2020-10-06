import 'package:flutter/material.dart';
import 'package:go_travel/home/tab_bar/tab_bar_view.dart' as tabs;

class AppBarView extends StatefulWidget {
  AppBarView({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _AppBarViewState createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(widget.title),
        elevation: 2.0,
        bottom: PreferredSize(
          child: tabs.TabBarView(),
          preferredSize: Size.fromHeight(56),
        ), 
    );
  }
}

/*
// добавление TabBara
AppBar(
  title: Text(widget.title),
  elevation: 2.0,
  bottom: PreferredSize(
    child: TabsBarView(),
    preferredSize: Size.fromHeight(56), //112 если добавлять все как виджет
  )
)
*/