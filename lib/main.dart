// Copyright (c) 2015, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_rest/firebase_rest.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Demo",
      routes: {
        '/': (RouteArguments args) => const FirebaseDemo()
      }
    )
  );
}

class FirebaseDemo extends StatefulComponent {
  const FirebaseDemo();
  FirebaseDemoState createState() => new FirebaseDemoState();
}

class FirebaseDemoState extends State<FirebaseDemo> {

  double _cloudCover = null;

  void initState() {
    _refresh();
    super.initState();
  }

  void _refresh() {
    setState(() {
      _cloudCover = null;
    });
    var ref = new Firebase(Uri.parse("https://publicdata-weather.firebaseio.com/sanfrancisco/currently/cloudCover"));
    ref.get().then((snapshot) {
      setState(() {
        _cloudCover = snapshot.val;
      });
    });
  }

  Widget build(BuildContext context)  {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("San Francisco Cloud Cover")
      ),
      body: new Material(
        child: new Center(
          child: new Text(
            "${_cloudCover ?? 'Loading...'}",
            style: Typography.black.display3
          )
        )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          icon: 'navigation/refresh'
        ),
        onPressed: _refresh
      )
    );
  }
}
