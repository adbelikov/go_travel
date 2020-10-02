import 'package:flutter/material.dart';

class TabsBarView extends StatefulWidget {
  //implements PreferredSizeWidget
  //TabsBarView({Key key})
  //    : preferredSize = Size.fromHeight(100),
  //      super(key: key);

  //@override
  //final Size preferredSize;

  @override
  _TabsBarViewState createState() => _TabsBarViewState();
}

class _TabsBarViewState extends State<TabsBarView> {
  int tabIndex = 0;

  final tabs = [
    {'icon': Icons.map, 'text': 'Map'},
    {'icon': Icons.pin_drop, 'text': 'Poi'},
    {'icon': Icons.toys_outlined, 'text': 'Setting'}
  ];

  @override
  Widget build(BuildContext context) {
    var t =
        List.generate(tabs.length, (index) => tabWidget3(tabs[index], index));
    //t.insert(1, Container(color: Colors.grey[400], width: 2, height: 64,));
    //t.insert(3, Container(color: Colors.grey[400], width: 2, height: 64,));

    return Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        constraints: BoxConstraints.expand(height: 60),
        //height: 64,
        decoration: BoxDecoration(
            color: Theme.of(context)
                .canvasColor, //.primaryColor, //.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Row(
          children: t,
        ));
  }

  Widget tabWidget3(Map<String, dynamic> tab, int index) {
    var colors = (tabIndex == index) ? Theme.of(context).accentColor : null;
     //Theme.of(context);
    //.unselectedWidgetColor,// .primaryColorLight;
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
            Icon(tab['icon'], size: 30, color: colors),
            Container(
              height: 4,
            ),
            Text(
              tab['text'],
              style: TextStyle(fontSize: 12, color: colors),
            )
          ],
        )),
      onPressed: () {
        setState(() {
          tabIndex = index;
        });
      },
    ));
  }
}

/*
Widget tabWidget(Map<String, dynamic> tab, int index) {
    return Expanded(
        child: FlatButton.icon(
            textColor: tabIndex == index ? Theme.of(context).accentColor : null,
            onPressed: () {
              // Respond to button press
              setState(() {
                tabIndex = index;
              });
            },
            icon: Icon(
              tab['icon'],
              size: 24,
              color: Colors.amber,
            ),
            label: Text(tab['text'])));
  }

  Widget tabWidget2(Map<String, dynamic> tab, int index) {
    return Expanded(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.map, size: 18), Text(tab['text'])],
        ),
        onTap: () {
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }



Expanded(
          child: FlatButton.icon(
            textColor: Theme.of(context).accentColor,
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(Icons.map, size: 18),
            label: Text("MAP"),
          ),
        ),
        Expanded(
          child: FlatButton.icon(
            textColor: Theme.of(context).textSelectionHandleColor,
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(Icons.pin_drop, size: 18),
            label: Text("POI"),
          ),
        )
        */
