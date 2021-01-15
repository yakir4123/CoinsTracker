import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyState createState() => new MyState();
}

class MyState extends State<MyApp> {

  Map _countries = new Map();

  void _getData() async {
    var url = 'http://country.io/names.json';

    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _countries = json.decode(response.body);
      });
    }
  }


  @override
  void initState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('My First App')
        ),
        body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text('Hello world'),
                new Expanded(
                  child: new ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = _countries.keys.elementAt(index);
                      return new Text("$key : ${_countries[key]}");
                    },
                  ),
                )
              ],
            ),
          ),
        )
      );
    }
}