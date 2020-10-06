import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// controller
import 'package:go_travel/home/tab_bar/tab_bar_controller.dart';

class TabBarView extends StatefulWidget {

  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {


  @override
  Widget build(BuildContext context) {
    final TabBarController tabControl = Provider.of<TabBarController>(context);
    final List<Widget> listTab = List.generate(
        tabControl.tabs.length, 
        (index) => tabWidget(tabControl, index) // tabControl.tabs[index]
    );
    //t.insert(1, Container(color: Colors.grey[400], width: 2, height: 56,));
    //t.insert(3, Container(color: Colors.grey[400], width: 2, height: 56,));

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      constraints: BoxConstraints.expand(height: 56),
      child: Row( children: listTab ),
      decoration: BoxDecoration( 
        color: Theme.of(context).canvasColor, 
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]),
    );
  }

  // одна кнопка
  Widget tabWidget(TabBarController tab, int index) {
    Color selectColor = (tab.tabIndex == index) 
        ? Theme.of(context).accentColor 
        : Theme.of(context).hintColor;
    //var bColors = tabIndex == index
    //    ? Theme.of(context).accentColor
    //    : Theme.of(context).scaffoldBackgroundColor;

    return Expanded(
      child: FlatButton(
      //shape: Border(top: BorderSide(width: 4, color: bColors)),
      //borderSide: BorderSide.none,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tab.tabs[index]['icon'], size: 28, color: selectColor),
              Container( height: 4 ),
              Text(
                tab.tabs[index]['text'],
                style: TextStyle(fontSize: 12, color: selectColor),
              ),
            ],
          )),
        onPressed: () {
          //setState(() {
            tab.tabIndex = index;
          //});
        },
      ));
  }
}
