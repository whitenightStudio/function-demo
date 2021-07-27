import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  Future<void> _registerPostRequest() async{
    String url = 'http://nacha01.dothome.co.kr/sin/func_test/register.php';
    http.Response response = await http.post(Uri.parse(url), headers: <String, String>{
      'Content-Type' : 'application/x-www-form-urlencoded',
    },
    body: <String,String>{
      'uid' : _idController.text.toString(),
      'pw'  : _pwController.text.toString(),
      'name' : _nameController.text.toString(),
      'tel' : _telController.text.toString(),
      'address' : _addressController.text.toString()
    });

    if(response.statusCode == 200){
      print(response.body);
      if(response.body.contains('PRIMARY')){
        print('이미 사용중인 아이디입니다.');
      }
    }
    else{
      print(response.statusCode);
    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('회원가입'),),
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
            TextField(
              controller: _nameController,
              onChanged: (text) {},
              decoration: InputDecoration(icon: Icon(Icons.account_circle)),
            ),
            TextField(
              controller: _telController,
              onChanged: (text) {},
              decoration: InputDecoration(icon: Icon(Icons.vpn_key)),
            ),
            TextField(
              controller: _addressController,
              onChanged: (text) {},
              decoration: InputDecoration(icon: Icon(Icons.account_circle)),
            ),
            FlatButton(onPressed: (){
                _registerPostRequest();
            }, child: Text('회원가입'))

          ],
        ),
      ),
    );
  }
}
