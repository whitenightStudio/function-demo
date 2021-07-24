import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
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
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // String newPath = path.join(dir, 'hangang.jpg');
    // _image = await File(image.path).copy(newPath);
    // 위와 같은 방법으로도 파일의 이름을 변경할 수 있다.!
    setState(() {
      // _image = newImage as File;
      // print(_image.name);
      _image = image;
    });
  }
  uploadImage(XFile imageFile) async{
      var request = http.MultipartRequest('POST',Uri.parse('http://nacha01.dothome.co.kr/sin/save_image_file.php'));
      request.fields['name'] = 'hangang';

      var pic = await http.MultipartFile.fromPath("file_field", imageFile.path,filename: 'hahaha2.jpg');
      // ㅡㅡ.. 파일 이름 변경 기능이 여기에 간단하게 있었네..

      request.files.add(pic);
      print(imageFile.path);
      var response = await request.send();

      print(response.headers);
      print(response.statusCode);
      var responseData = await response.stream.toBytes();

      var responseString = String.fromCharCodes(responseData);
      print(responseString);
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

            FlatButton(onPressed: (){
              uploadImage(_image);
            }, child: Text('upload image')),
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