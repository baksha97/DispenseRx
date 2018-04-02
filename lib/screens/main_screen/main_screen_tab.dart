import 'package:dispenserx/screens/main_screen/off_duty/batch_screen_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
   const MainScreen({ Key key }) : super(key: key);
   @override
   MainScreenState createState() => new MainScreenState();
 }

 class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {

   TabController _tabController;
   int _currentIndex;

   final List<Tab> myTabs = <Tab>[
     new Tab(text: 'Cards', icon: const Icon(Icons.card_travel)), //index 0
     new Tab(text: 'Map', icon: const Icon(Icons.map)), //index 1
   ];

   Widget _tabScreenStack(){
     return new Stack(
       children: <Widget>[
         new Offstage(
           offstage: _currentIndex != 0,
           child: new TickerMode(
             enabled: _currentIndex == 0,
             child: new MaterialApp(home: new BatchScreen()),
           ),
         ),
         new Offstage(
           offstage: _currentIndex != 1,
           child: new TickerMode(
             enabled: _currentIndex == 1,
             child:
             //new MaterialApp(home: new HomePage()),
             new Center(child: new Text('TODO: Maps', textScaleFactor: 1.0)),
           ),
         ),
       ],
     );
   }

   @override
   void initState() {
     super.initState();
     _currentIndex = 0;
     _tabController = new TabController(vsync: this, length: myTabs.length);
     _tabController.addListener(_handleTabSelection);
   }

   @override
   void dispose() {
    _tabController.dispose();
    super.dispose();
  }

   void _handleTabSelection() {
     setState(() {
       _currentIndex = _tabController.index;
     });
   }


   @override
   Widget build(BuildContext context) {
     return new Scaffold(
       appBar: new AppBar(
         title: new Text('Batch Information'),
         bottom: new TabBar(
           controller: _tabController,
           tabs: myTabs,
         ),
       ),
       body: _tabScreenStack(),
//       new TabBarView( controller: _tabController, children: <Widget>[new Center(child: new Text(myTabs[0].text)),]// not using because stacks can maintain state.
     );
   }
 }