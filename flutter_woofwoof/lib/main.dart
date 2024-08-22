import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = 'Loading...';
  String db_api_url = dotenv.get('DB_API_URL');

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  Future<void> fetchMessage() async {
    final response = await http.get(Uri.parse(db_api_url));

    if (response.statusCode == 200) {
      setState(() {
        message = jsonDecode(response.body)['message'];
      });
    } else {
      setState(() {
        message = 'Failed to load message';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Hello World'),
        ),
        body: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
