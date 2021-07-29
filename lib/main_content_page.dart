import 'package:flutter/material.dart';
import 'package:function_test/user.dart';

class MainContentPage extends StatefulWidget {
  final id;
  MainContentPage({this.id});
  @override
  _MainContentPageState createState() => _MainContentPageState();
}

class _MainContentPageState extends State<MainContentPage> {

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }
  Future<User> _getUserInfo() async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
