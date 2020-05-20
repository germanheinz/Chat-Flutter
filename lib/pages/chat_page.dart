import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  final _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  @override
  void initState() { 
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
    final user = await _auth.currentUser();
      if(user != null){
        firebaseUser = user;
        print(firebaseUser.email);
      }  
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Chat Page'
      ),
    );
  }
}