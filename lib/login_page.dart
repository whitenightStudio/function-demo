import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:function_test/main_content_page.dart';
import 'package:function_test/user.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  Future<String> _loginGetRequest(String id, String pw) async{
    String uri = 'http://nacha01.dothome.co.kr/sin/func_test/login.php?uid=$id&pw=$pw';
    var response = await http.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type' : 'application/x-www-form-urlencoded',
    });

    if(response.statusCode == 200){
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    }
    else{
      return "-1";
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
            FlatButton(onPressed: () async{
              String result = await _loginGetRequest(_idController.text.toString(), _pwController.text.toString());
              print(result);
              String message = result;
              /*switch(result){
                case -1: //http error
                message = '통신 에러';
                  break;
                case 0: // not exist account
                message = '존재하지 않는 계정입니다.';
                  break;
                case 1: // exist account
                message ='존재하는 계정입니다. 로그인 성공!';
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainContentPage()));
                break;
              }*/
              showDialog(context: context, builder: (context){
                return AlertDialog(title: Text(message),);
              });

            }, child: Text('로그인'))
          ],
        ),
      ),
    );
  }
}
