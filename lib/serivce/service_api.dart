import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:form1/modal.dart';
import 'package:form1/newmodal.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ServiceApi extends StatefulWidget {
  const ServiceApi({Key? key}) : super(key: key);

  @override
  State<ServiceApi> createState() => _ServiceApiState();
}

class _ServiceApiState extends State<ServiceApi> {
  String jsondata = '';
  var jsonresponse;
  // Future save(ApplicationNew data) async {
  //   log(data.toJson().toString());
  //   await http.post(
  //       Uri.parse(
  //         "http://localhost:1337/api/application-forms",
  //       ),
  //       headers: <String, String>{
  //         'Context-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: {});
  // }

  List _jsonData = [];
  Map<String, dynamic>? newmap;

  Future<Map<String, dynamic>> getdata() async {
    final url =
        Uri.parse('https://herokunew123.herokuapp.com/api/application-forms');

    final res = await get(url);
    final jsonres = "[" + res.body + "]";

    if (res.statusCode == 200) {
      //List<dynamic> jsonresponse = json.decode(res.body);
      // setState(() {
      //   _jsonData = jsonresponse;
      //   print(_jsonData);
      // });
      return json.decode(res.body);

      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create ApplicationForm Form.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Postget DemoApp"),
          ),
          body: Column(
            children: [
              Text(jsondata),
              ElevatedButton(onPressed: getdata, child: Text("Get Data")),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _jsonData.length,
                  itemBuilder: (context, index) {
                    final post = _jsonData[index];
                    return Text(
                        "Name : ${post['name']}\n Email : ${post['email']}\n Password : ${post['password']}\nAddress : ${post['address']}\nPhone Number : ${post['number']}");
                  }),
            ],
          )),
    );
  }
}
