import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  String message;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          
          children: <Widget>[
            _inputMessage(),
          ],
        ),
      ),
      // floatingActionButton: Icon(Icons.send),
    );
  }
  Widget _inputMessage(){
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 0.0,bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
              hintText: 'Write a Message',
              border: OutlineInputBorder(),
              ),
            onChanged:(value){
              message = value;
            } 
            ),
          ),
          FlatButton(
              onPressed: (){
                _fireStore.collection('messages').add({'message': message ,'sender': firebaseUser.email});
              },
              child: Text('Send'),
          ),
        ],
      ),
    );
  }
}