import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isLoaded = false;
  String resultQuery;
  var _image;
  @override
  void initState() {
    super.initState();
    _getRequest();
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _getRequest() async{
    String url = 'http://nacha01.dothome.co.kr/sin/insert_image.php';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      print(response.body);
      setState(() {
        _isLoaded = true;
        resultQuery = response.body.split('\n')[1];
        print(resultQuery);
      });
    }
  }
  Future _getImage() async{
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: _getImage, child: Text('select images')),
            _image == null ? Text('no image') : Image.file(File((_image as XFile).path)),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            _isLoaded ?
            Image.network(resultQuery,) : Text('ttt')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}