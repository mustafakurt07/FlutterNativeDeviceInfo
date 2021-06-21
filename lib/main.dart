import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}
//Android tarafında channel olusturup gerekli bilgilei hash map ile flutter a gönderip flutterde aynı channel ile karsılıyorum . Ve basit bir şekilde ekranda gösteriyorum.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  static const platform =
  const MethodChannel('com.example.flutter/device_info');
  String deviceInfo = "";

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  Future<void> _getDeviceInfo() async {
    String result;
    try {
      platform.invokeMethod('getDeviceInfo').then((value) {
        result = value.toString();
        setState(() {
          deviceInfo = result;
        });
      });
    } on PlatformException catch (e) {
      print("_getDeviceInfo==>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text(deviceInfo)),
    );
  }
}
