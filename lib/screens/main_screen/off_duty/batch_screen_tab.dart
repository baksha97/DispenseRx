// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;
import 'package:dispenserx/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//TODO: remove with batch map view images.

class Batch {
  const Batch({
    this.id,
    this.pharmacyId,
    this.pharmacyName,
    this.pharmacyPhone,
    this.imageLocation,
    this.imageLocation2,
    this.pharmacyAddress1,
    this.pharmacyAddress2,
    this.amountOfDeliveries,
    this.estimatedDeliveryTime,
    this.estimatedMileage,
    this.estimatedCompensation,
    this.status
  });

  final String id;
  final String pharmacyId;
  final String pharmacyName;
  final String pharmacyPhone;
  final String imageLocation;
  final String imageLocation2;
  final String pharmacyAddress1;
  final String pharmacyAddress2;
  final String amountOfDeliveries;
  final String estimatedDeliveryTime;
  final String estimatedMileage;
  final String estimatedCompensation;
  final String status;

  bool get isValid => pharmacyName != null
                 && pharmacyAddress1 != null
                 && pharmacyAddress2 != null
                 && amountOfDeliveries != null
                 && estimatedDeliveryTime != null
                 && estimatedMileage != null;
}

final List<Batch> batches = <Batch>[
  const Batch(
    id: 'b1',
    pharmacyId: 'p1',
    pharmacyName: 'Medicine Cabinet Pharmacy',
    pharmacyPhone: '123 456 7765',
    imageLocation: 'https://maps.googleapis.com/maps/api/staticmap?autoscale=1&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C88-28+Parsons+Blvd,+Jamaica,+NY+11432',
    imageLocation2: 'https://maps.googleapis.com/maps/api/streetview?size=600x300&location=8828+Parsons+Blvd+11432',
    pharmacyAddress1: 'Pharmacy Address: ',
    pharmacyAddress2: 'Pharmacy Town: ',
    amountOfDeliveries: 'Amount of deliveries: ',
    estimatedDeliveryTime: 'Estimated delivery time: ',
    estimatedMileage: 'Estimated mileage: ',
    estimatedCompensation: 'Estimated compensation: \$2.50',
    status: 'pending',
  ),
  const Batch(
    id: 'b2',
    pharmacyId: 'p2',
    pharmacyName: 'Medicine Cabinet Pharmacy',
    pharmacyPhone: '123 456 7765',
    imageLocation: 'https://maps.googleapis.com/maps/api/staticmap?autoscale=1&size=600x300&maptype=roadmap&format=png&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C88-28+Parsons+Blvd,+Jamaica,+NY+11432',
    imageLocation2: 'https://maps.googleapis.com/maps/api/streetview?size=600x300&location=8828+Parsons+Blvd+11432',
    pharmacyAddress1: 'Pharmacy Address: ',
    pharmacyAddress2: 'Pharmacy Town: ',
    amountOfDeliveries: 'Amount of deliveries: ',
    estimatedDeliveryTime: 'Estimated delivery time: ',
    estimatedMileage: 'Estimated mileage: ',
    estimatedCompensation: 'Estimated compensation: \$2.50',
    status: 'pending',
  ),
    ];

class BatchItemCard extends StatelessWidget {
  BatchItemCard({ Key key, @required this.batch })
      : assert(batch != null && batch.isValid),
        super(key: key);

  static const double height = 425.0;
  final Batch batch;

  @override
  Widget build(BuildContext context) {
    //set context

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
                    batch.pharmacyName,
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
                        batch.imageLocation,
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
                            batch.pharmacyAddress2,
                            style: descriptionStyle.copyWith(color: Colors.black54),
                          ),
                        ),
                        new Text(batch.amountOfDeliveries),
                        new Text(batch.estimatedDeliveryTime),
                        new Text(batch.estimatedMileage),
                        new Text(batch.estimatedCompensation),
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
                      child: const Text('INFO'),
                      textColor: Colors.blue.shade500,
                      onPressed: () {
                        //todo: fix and add specific delivery screen for each batch
                        appRouter.push(context, '/screens/bottom_navigation/main_screen/delivery_screen');
                        /* do nothing */
                        },
                    ),
                    new FlatButton(
                      child: const Text('ACCEPT'),
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

class BatchScreen extends StatelessWidget {
 //todo: static const String routeName = '/material/cards';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
            itemExtent: BatchItemCard.height,
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            children: batches.map((Batch destination) {
              return new Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: new BatchItemCard(batch: destination)
              );
            }).toList()
        )
    );
  }
}