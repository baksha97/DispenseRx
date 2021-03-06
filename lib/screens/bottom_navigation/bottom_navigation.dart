import 'package:dispenserx/constants.dart';
import 'package:dispenserx/screens/bottom_navigation/navigation_icon_view.dart';
import 'package:dispenserx/screens/main_screen/main_screen_tab.dart';
import 'package:dispenserx/screens/profile/profile_tab_screen.dart';
// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  static const String route = '/screens/bottom_navigation';

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {

  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();

    Color barColor = Constants.rxColor;

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.work),
        title: 'Main',
        view: new MainScreen(),
        color: barColor,
        vsync: this,
      ),

      new NavigationIconView(
        icon: const Icon(Icons.message),
        title: 'Messages',
        color: barColor,
        vsync: this,
      ),

      new NavigationIconView(
        icon: const Icon(Icons.person_outline),
        title: 'Profile',
        view: new ProfileScreen(),
        color: barColor,
        vsync: this,
      ),
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }



  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      fixedColor: Constants.rxColor,
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      appBar: null,
      body: new Center(
          child: _buildTransitionsStack()
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}