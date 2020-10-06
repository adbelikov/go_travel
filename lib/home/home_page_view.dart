import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// controller
import 'package:go_travel/home/tab_bar/tab_bar_controller.dart';
// views
import 'package:go_travel/home/tab_bar/tab_bar_view.dart' as tabs;
import 'package:go_travel/home/view/mapbox/map_mapbox_view.dart';
import 'package:go_travel/home/view/poi_list_view.dart';
import 'package:go_travel/home/view/tools_list_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // with TickerProviderStateMixin {
  final List<Widget> pages = [MapBoxView(), PoiListView(), ToolsListView()];

  //@override
  //void initState() {
  //  super.initState();
  //}

  //@override
  //void dispose() {
  //  super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (context) => TabBarController(),
            dispose: (context, TabBarController t) => t.dispose(),
          ),
        ],
        child: Consumer<TabBarController>(builder: (context, tab, child) {
          return StreamBuilder<int>(
              stream: tab.tabControl,
              initialData: null,
              builder: (context, tab) {
                if (tab.hasData && tab.data != null) {
                  return Scaffold(
                    //backgroundColor: Colors.grey.shade200,
                    appBar: AppBar(
                      title: Text(widget.title),
                    ),
                    body: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: pages[tab.data],
                    ),
                    bottomNavigationBar: tabs.TabBarView(),
                  );
                } else {
                  return Scaffold(body: Center(child: Text('Loading App...')));
                }
              });
        }));
  }
}

/*
SlidingUpPanel(
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

                //bottom: PreferredSize(
                //  child: TabsBarView(),
                //  preferredSize: Size.fromHeight(56),
                //),

FadeTransition(
                opacity: _animation,
                child: pages[tab.data],
              ),

Scaffold(
      //backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.title),
        //bottom: PreferredSize(
        //  child: TabsBarView(),
        //  preferredSize: Size.fromHeight(56),
        //),
      ),
      body: MapBoxView(),
      bottomNavigationBar: TabsBarView(),
    );





*/
