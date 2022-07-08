import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form1/modal.dart';
import 'package:form1/newmodal.dart';
import 'package:form1/page2.dart';
import 'package:form1/serivce/service_api.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'display.dart';
import 'personal.dart';
import 'package:marquee/marquee.dart';
import 'doc1.dart';
import 'doc2.dart';
import 'doc3.dart';
import 'doc4.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

Future<PostData> submitData(
  String username,
  String email,
  String password,
) async {
  var body = {
    {"username": username, "email": email, "password": password}
  };

  final response = await http.post(
      Uri.parse('https://herokunew123.herokuapp.com/api/auth/local/registers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body));
  var data = response.body;
  print(data);

  if (response.statusCode == 200) {
    print('Successfully Post');
    log(response.body);

    return PostData.fromJson(jsonDecode(response.body));

    // If the server did return a 201 CREATED response,
    // then parse the JSON.

  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create ApplicationForm Form.');
  }
}

class _FormScreenState extends State<FormScreen> {
  String name1 = '';
  String email1 = '';
  String password1 = '';

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();

  genderok _character = genderok.male;
  List<String> listitem = [
    'App Developer',
    'Website developer',
    'Graphic Designer',
    'Video Editing',
    'Other'
  ];
  String? itemvalue;
  String? itemvalue2;
  List<String> listitem2 = [
    'BCA',
    'B.TECH',
    'MCA',
    'MSC IT',
    'M.TECH',
    'OTHER'
  ];

  var format = DateFormat("yyyy-MM-dd");

  DateTime? birthDate;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.black),
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              )),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name is required';
            }
            if (!RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                .hasMatch(value)) {
              return "Please Enter a Valid Name";
            }
          }),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.mail,
              color: Colors.red,
            )),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return "Please Enter a Valid Email Address";
          }
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            )),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
        },
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _numberController,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.black),
            icon: Icon(
              Icons.phone,
              color: Colors.green,
            )),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          }
          if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
            return "Please Enter a Valid Phone Number";
          }
        },
      ),
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          labelText: 'Address',
          labelStyle: TextStyle(color: Colors.black),
          icon: Icon(
            Icons.place,
            color: Colors.pink[900],
          )),
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Address is required';
        }
      },
    );
  }

  Widget _buildQualification() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.cast_for_education_outlined,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          "Qualification",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton<String>(
              value: itemvalue2,
              hint: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Select"),
              ),
              items: listitem2.map((item2) {
                return DropdownMenuItem<String>(
                  value: item2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(item2),
                  ),
                );
              }).toList(),
              onChanged: (String? newchange1) {
                setState(() {
                  itemvalue2 = newchange1!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAge() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Date of Birth ",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42, bottom: 10),
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2025),
                    helpText: "SELECT DATE OF BIRTH",
                    cancelText: "CANCEL",
                    confirmText: "OK",
                    fieldHintText: "DATE/MONTH/YEAR",
                    fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                    errorFormatText: "Enter a Valid Date",
                    errorInvalidText: "Date Out of Range");
              },
            ),
          ),
        ]);
  }

  Widget _buildGender() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.male_sharp,
              color: Colors.deepOrange,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: Text(
                "Gender",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
        RadioListTile(
            toggleable: true,
            title: Text("Male"),
            value: genderok.male,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as genderok;
              });
            }),
        RadioListTile(
            title: Text("Female"),
            value: genderok.female,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as genderok;
              });
            }),
        RadioListTile(
            title: Text("Other"),
            value: genderok.other,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value as genderok;
              });
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Marquee(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),

                blankSpace: 200,

                velocity: 150,
                textScaleFactor: 1.06,
                pauseAfterRound: Duration(seconds: 1),
                showFadingOnlyWhenScrolling: true,
                //fadingEdgeStartFraction: 0.1,
                //fadingEdgeEndFraction: 0.1,
                startPadding: 10,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 600),
                decelerationCurve: Curves.easeOut,

                text: 'Last date of Registration is 25th May 2022',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "APPLICATION FORM",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("POST APPLIED FOR :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.all(16),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DropdownButton<String>(
                        value: itemvalue,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Select Your Post"),
                        ),
                        items: listitem.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(item),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newchange) {
                          setState(() {
                            itemvalue = newchange!;
                          });
                        },
                      ),
                    ),
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildNameField(),
                    _buildEmail(),
                    _buildPassword(),
                    _buildPhoneNumber(),
                    _buildAddress(),
                    _buildQualification(),
                    _buildAge(),
                    _buildGender(),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: (() {
                              name1 = _usernameController.text;
                              email1 = _emailController.text;
                              password1 = _passwordController.text;

                              submitData(name1, email1, password1);
                            }),
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ))
                      ],
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}
