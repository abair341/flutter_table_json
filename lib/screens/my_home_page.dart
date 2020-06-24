import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //http://abair.gq/db_dept_info_all.php

  List _data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      appBar: AppBar(
        title: Text("Json Data"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _data != null
            ? JsonTable(
                _data,
              )
            : Text("Loading..."),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get("http://abair.gq/db_dept_info_all.php");
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          _data = jsonDecode(response.body) as List;
        });
      } else {
        print("Some error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}
