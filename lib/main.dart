import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: ChatPage.id,
      routes: {
        HomePage.id     : (BuildContext context) => HomePage(),
        RegisterPage.id : (BuildContext context) => RegisterPage(),
        LoginPage.id    : (BuildContext context) => LoginPage(),
        ChatPage.id     : (BuildContext context) => ChatPage(),
      },
    );
  }
}