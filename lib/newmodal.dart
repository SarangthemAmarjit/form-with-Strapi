// To parse this JSON data, do
//
//     final applicationNew = applicationNewFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PostData {
  final String name;
  final String post;
  final String email;
  final String password;
  final String number;
  final String address;
  final String qualification;
  final String gender;

  PostData({
    required this.name,
    required this.post,
    required this.email,
    required this.password,
    required this.number,
    required this.address,
    required this.qualification,
    required this.gender,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        name: json["name"],
        post: json["post"],
        email: json["email"],
        password: json["password"],
        number: json["number"],
        address: json["address"],
        qualification: json["qualification"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "post": post,
        "email": email,
        "password": password,
        "number": number,
        "address": address,
        "qualification": qualification,
        "gender": gender,
      };
}
