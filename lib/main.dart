import 'package:flutter/material.dart';
import 'package:reminderapplatest/screens/contact-us.dart';
import 'screens/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        ContactUs.id: (context) => ContactUs(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
}


