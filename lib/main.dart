import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = "";
  String _title="";
  String _method="";

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    _register();
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
            Text(
              _title,
            ),
            Text(
              _message,
            ),
            Text(
              _method,
            ),
          ],
        ),
      ),
    );
  }

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() {
            _message = message["notification"]["body"];
            _title=message["notification"]["title"];
            _method="on message";
          });

        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() {
        _message = message["data"]["body"];
        _title=message["data"]["title"];
        _method="on resume";
      });

    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() {
        _message = message["data"]["body"];
        _title=message["data"]["title"];
        _method="on launch";
      });

    });
  }
}
