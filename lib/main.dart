import 'package:chat/chat_page.dart';
import 'package:chat/login_page.dart';
import 'package:chat/register_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home'    : (BuildContext context) => HomePage(),
        'register': (BuildContext context) => RegisterPage(),
        'login'   : (BuildContext context) => LoginPage(),
        'chat'    : (BuildContext context) => ChatPage(),
      },
      initialRoute: 'home',
    );
  }
}