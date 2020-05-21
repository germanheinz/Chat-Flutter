import 'package:chat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser firebaseUser;
final dateTime = DateTime.now();

class ChatPage extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final textEditingController = TextEditingController();
  
  String message;

  @override
  void initState() { 
    super.initState();
    getCurrentUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close), 
            onPressed:(){ 
              _auth.signOut();
              Navigator.popAndPushNamed(context, LoginPage.id);
            } 
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _getMessages(),
            _inputMessage(),
          ],
        ),
      ),
      // floatingActionButton: Icon(Icons.send),
    );
  }

  StreamBuilder<QuerySnapshot> _getMessages() {
    return StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('messages').orderBy('time', descending: true).snapshots(), 

            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final messages = snapshot.data.documents.reversed;
              List<MessageBubble> messageBubble = [];
              for(var message in messages){
                final messageText   = message.data['text'];
                final messageSender = message.data['sender'];
                final dateTime      = message.data['dateTime'];

                final currentUser = firebaseUser.email;
                
                final messageWidget = MessageBubble(text: messageText ,sender: messageSender,date: dateTime, isMe: currentUser == messageSender,);
                messageBubble.add(messageWidget);
              }
              return Expanded(
                  child: ListView(
                  reverse: false,  
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  children: messageBubble,
                ),
              ); 
            },
          );
  }
  
  Widget _inputMessage(){
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 0.0,bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
              hintText: 'Write a Message',
              border: InputBorder.none,
              // focusedBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //     borderSide: BorderSide(color: Colors.red)
              // ),
              filled: true,
              contentPadding:
              EdgeInsets.only(bottom: 0.0, left: 15.0, right: 10.0),
              ),
              onChanged:(value){
              message = value;
            } 
            ),
          ),
          FlatButton(
              onPressed: (){
                textEditingController.clear();
                _fireStore.collection('messages').add({'text': message ,'sender': firebaseUser.email, 'time': FieldValue.serverTimestamp(),});
              },
              child: Text('Send'),
          ),
        ],
      ),
    );
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

}

class MessageBubble extends StatelessWidget {

  MessageBubble({this.text, this.sender,this.date, this.isMe});

  final String sender;
  final String text;
  final DateTime date;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
          Text(sender, style: TextStyle(fontSize: 12.0, color: Colors.black54)),
          Material(
          borderRadius: isMe ? BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0))
                             : BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
          elevation: 5.0,
          // color: Colors.redAccent,
          color: isMe ? Colors.redAccent : Colors.deepOrange,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text('$text',style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),))),
          ],
        ),
    );
  }

}