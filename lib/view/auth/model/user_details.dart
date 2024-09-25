import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String? name;
  String? email;
  String? password;

  UserDetails({this.name, this.email, this.password});

  UserDetails.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    name = doc.data()?['name'];
    email = doc.data()?['email'];
    password = doc.data()?['password'];
  }

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
