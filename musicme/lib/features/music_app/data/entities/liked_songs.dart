import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//NOT WORKING YET
// Hey Faith cool code. What does this do? I couldnt figure it out. Usually you wouldnt use any Statless widgets in
// the backend. also I thought we were not taking username and a password?

UsersPodo _usersPodo; // Users object to store users from json

// A function that converts a response body into a UsersPodo
UsersPodo parseJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return UsersPodo.fromJson(parsed);
}

class Demo extends StatelessWidget {
  final String localJson = '''
  {
    "users": [
        {
            "id": 1,
            "username": "steve",
            "password": "captainamerica"
        }
    ]
}'''; // local json string
  Future<UsersPodo> fetchJSON() async {
    return compute(parseJson, localJson);
  }

  Widget body() {
    return FutureBuilder<UsersPodo>(
      future: fetchJSON(),
      builder: (context, snapshot) {
        return snapshot.hasError
            ? Center(child: Text(snapshot.error.toString()))
            : snapshot.hasData
                ? _buildBody(usersList: snapshot.data)
                : Center(child: Text("Loading"));
      },
    );
  }

  Widget _buildBody({UsersPodo usersList}) {
    _usersPodo = usersList;

    _usersPodo.users.add(new Users(
        id: 1,
        username: "omishah",
        password: "somepassword")); // add new user to users array

    return Text(
        _usersPodo.users[1].toJson().toString()); // just for the demo output

    // use _usersPodo.toJson() to convert the users object to json
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff3f3f3),
        appBar: AppBar(backgroundColor: Colors.red[900], title: Text("DEMO")),
        body: body());
  }
}

// PODO Object class for the JSON mapping
class UsersPodo {
  List<Users> users;

  UsersPodo({this.users});

  UsersPodo.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      List<Users> users = [];
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int id;
  String username;
  String password;

  Users({this.id, this.username, this.password});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
