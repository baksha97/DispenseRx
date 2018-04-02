import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class _ProfileCategory extends StatelessWidget {
  const _ProfileCategory({ Key key, this.icon, this.children }) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: themeData.dividerColor))
      ),
      child: new DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: new Icon(icon, color: themeData.primaryColor)
              ),
              new Expanded(child: new Column(children: children))
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  _ProfileItem({ Key key, this.icon, this.lines, this.tooltip, this.onPressed })
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines.sublist(0, lines.length - 1).map((String line) => new Text(line)).toList();
    columnChildren.add(new Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren
          )
      )
    ];
    if (icon != null) {
      rowChildren.add(new SizedBox(
          width: 72.0,
          child: new IconButton(
              icon: new Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed
          )
      ));
    }
    return new MergeSemantics(
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren
          )
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  //TODO: EDIT
  //static const String routeName = '/contacts';
  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class ProfileScreenState extends State<ProfileScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _currentUser = FirebaseAuth.instance.currentUser();
  //TODO: Remove dummy data:
  //Dummy Data
   //photo must access height, so we must enter it in the body...
  static const String courierName =  ('Courier Name');
  static const String uid = ('*Firebase UID*');
  static const String phoneNo = ('(234) 567-9876');
  static const String address = ('123 Q Lane');
  static const String address2 = ('New York, New York, USA.');
  static const String email = ('example@example.com');
  static const String status = ('Online');
  static const String joinDate = 'Mar 03, 2018';
  static const String dateOfBirth = 'June 06, 1997';

  @override
  void initState() {
    super.initState();
    //TODO: GRAB UID
    //FirebaseAuth.instance.currentUser().;
//    UserInfo.uid;
//    var ref = _currentUser.providerData[0].uid;
//    var _userData = Firestore.instance.document('drivers/$_currentUser.uid'),
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        platform: Theme.of(context).platform,
      ),
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: 'History',
                  onPressed: () {
                    _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: const Text('This will open delivery history.')
                    ));
                  },
                ),
              ],
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text(courierName),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Image.asset(
                      'assets/courier_example.jpg',
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.4),
                          colors: const <Color>[const Color(0x60000000), const Color(0x00000000)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[

              //uid, email, password category
                new _ProfileCategory(
                  icon: Icons.account_box,
                  children: <Widget>[
                    new _ProfileItem(
                      //icon: Icons.person_pin_circle,
                      tooltip: 'Name',
                      lines: const <String>[
                        courierName,
                        'Name',
                      ],
                    ),
                    new _ProfileItem(
                      icon: Icons.edit,
                      tooltip: 'E-mail',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text('This button will update your email.')
                        ));
                      },
                      lines: const <String>[
                        email,
                        'Personal',
                      ],
                    ),
                    new _ProfileItem(
                      icon: Icons.edit,
                      tooltip: 'Password',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text('This button will update your password.')
                        ));
                      },
                      lines: const <String>[
                        '•••••••',
                        'Password',
                      ],
                    ),
                  ],
                ),




                //personal information: phone no, address
                new _ProfileCategory(
                  icon: Icons.contact_mail,
                  children: <Widget>[

                    new _ProfileItem(
                      tooltip: 'Phone Number',
                      lines: const <String>[
                        phoneNo,
                        'Phone Number',
                      ],
                    ),
                    new _ProfileItem(
                      tooltip: 'Address',
                      lines: const <String>[
                        address,
                        address2,
                        'Address',
                      ],
                    ),
                    new _ProfileItem(
                      icon: Icons.date_range,
                      tooltip: 'Date of Birth',
                      lines: const <String>[
                        dateOfBirth,
                        'Date of Birth',
                      ],
                    ),
                  ],
                ),



                //courier status
                new _ProfileCategory(
                  icon: Icons.system_update_alt,
                  children: <Widget>[

                    new _ProfileItem(
                      icon: Icons.check_circle,
                      tooltip: 'Status',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text('This is your current status')
                        ));
                      },
                      lines: const <String>[
                        status,
                        'Current Status',
                      ],
                    ),

                    new _ProfileItem(
                      icon: Icons.check,
                      tooltip: 'Verified',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text('You may begin working!')
                        ));
                      },
                      lines: const <String>[
                        'Verified',
                        'Current Verification Status',
                      ],
                    ),

                    new _ProfileItem(
                      icon: Icons.date_range,
                      tooltip: 'Date joined',
                      lines: const <String>[
                        joinDate,
                        'Date Joined',
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}