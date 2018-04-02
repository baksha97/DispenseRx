// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Delivery {
  const Delivery({
    this.patientName,
    this.patientAddress1,
    this.patientAddress2,
    this.patientNumber,
    this.imageLocation
  });

  final String patientName;
  final String patientAddress1;
  final String patientAddress2;
  final String patientNumber;
  final String imageLocation;

  bool get isValid => patientName != null && patientNumber != null; //&& description?.length == 3;
}

final List<Delivery> deliveries = <Delivery>[
  const Delivery(
    patientName: 'Dem Destin',
    patientAddress1: '123 D Drive',
    patientAddress2: 'Town, City, State',
    patientNumber: '123 456 1234',
    imageLocation: 'https://maps.googleapis.com/maps/api/streetview?size=600x300&location=8828+Parsons+Blvd+11432',
  ),
  const Delivery(
    patientName: 'Dem Destin',
    patientAddress1: '123 D Drive',
    patientAddress2: 'Town, City, State',
    patientNumber: '123 456 1234',
    imageLocation: 'https://maps.googleapis.com/maps/api/streetview?size=600x300&location=8828+Parsons+Blvd+11432',
  )
];

class DeliveryItemCard extends StatelessWidget {
  DeliveryItemCard({ Key key, @required this.destination })
      : assert(destination != null && destination.isValid),
        super(key: key);

  static const double height = 400.0;
  final Delivery destination;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.black);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        height: height,
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(
                child:
                new Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: new Text(
                        destination.patientName,
                        style: descriptionStyle.copyWith(color: Colors.blueGrey, fontSize: 15.0))
                ), //---
              ),
              // photo and title
              new SizedBox(
                height: 184.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                      child: new Image.network(
                        destination.imageLocation,
                        fit: BoxFit.cover,
                      ),
                    ),
                    new Positioned(
                      bottom: 4.0,
                      //top: 4.0,
                      left: 4.0,
                      right: 4.0,
                      child: new FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: new Text('Estimated distance, hopefully',
                          style: titleStyle,
                          textScaleFactor: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // description and share/explore buttons
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: new DefaultTextStyle(
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // three line description
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            'Patient Delivery',
                            style: descriptionStyle.copyWith(color: Colors.black54),
                          ),
                        ),
//TODO: add other informations
                        new Text(destination.patientAddress1),
                        new Text(destination.patientAddress2),
//                        new Text(batch.estimatedMileage),
//                        new Text(batch.estimatedCompensation),
                      ],
                    ),
                  ),
                ),
              ),
              // share, explore buttons
              new ButtonTheme.bar(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('Map'),
                      textColor: Colors.blue.shade500,
                      onPressed: () { /* do nothing */ },
                    ),
                    new FlatButton(
                      child: const Text('Call'),
                      textColor: Colors.blue.shade500,
                      onPressed: () { /* do nothing */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryScreen extends StatelessWidget {
  static const String routeName = '/screens/bottom_navigation/main_screen/delivery_screen';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
            itemExtent: DeliveryItemCard.height,
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            children: deliveries.map((Delivery destination) {
              return new Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: new DeliveryItemCard(destination: destination)
              );
            }).toList()
        )
    );
  }
}