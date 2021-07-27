import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  Future<void> _loginGetRequest(String id, String pw) async{
    String uri = 'http://nacha01.dothome.co.kr/sin/func_test/login.php?uid=$id&pw=$pw';
    var response = await http.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type' : 'application/x-www-form-urlencoded',
    });

    if(response.statusCode == 200){
      print(utf8.decode(response.bodyBytes));

    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('로그인'),),
        body: Column(
          children: [
            TextField(
              controller: _idController,
              onChanged: (text) {},
              decoration: InputDecoration(icon: Icon(Icons.account_circle)),
            ),
            TextField(
              controller: _pwController,
              onChanged: (text) {},
              decoration: InputDecoration(icon: Icon(Icons.vpn_key)),
            ),
            FlatButton(onPressed: () {
              _loginGetRequest(_idController.text.toString(), _pwController.text.toString());
            }, child: Text('로그인'))
          ],
        ),
      ),
    );
  }
}
