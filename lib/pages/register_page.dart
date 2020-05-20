import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}
//Agrego SingleTicker para obtener funcionalidad para animaciones
class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  // Defino el controller para Animation
  AnimationController controller;
  Animation animation;
  Animation animatedColor;

  String email;
  String password;

  //Sobreescribo initState e instancio AnimationController
  @override
  void initState() {
    super.initState();

    controller    = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation     = CurvedAnimation(parent: controller, curve: Curves.ease);
    animatedColor = ColorTween(begin: Colors.white, end: Colors.red).animate(controller);
    
    controller.forward();

    controller.addListener((){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:_register(context),
      ),
    );
  }

  Widget _register(BuildContext context){

    final size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
          height: animation.value,
        ),
        ),
        Container(
          // width: size.width * 0.85,
          width: animation.value * 300,
          height: size.height * 0.6,
          margin: EdgeInsets.symmetric(vertical: animation.value),
          padding: EdgeInsets.symmetric(vertical: animation.value),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 3.5,
                offset: Offset(0.0,2.5),
                spreadRadius: 0.6,
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(16.0)),
              ColorizeAnimatedTextKit(
                colors: [Colors.red[400],
                        Colors.red[300],
                        Colors.orange[50],
                        Colors.red[200]],
                text:['Register'], 
                speed: Duration(milliseconds: 250),
                totalRepeatCount: 1,
                textStyle: TextStyle(
                  color: Colors.red, 
                  fontSize: 19.0, 
                  fontWeight: FontWeight.bold
                ),
                 alignment: AlignmentDirectional.topStart
              ),
              _createEmail(),
              _createPassword(),
              SizedBox(height: 40.0),
              _crearBoton(),
            ],
          ),
        ),
        FlatButton(
          child: Text('Login in'),
          onPressed: () => Navigator.pushReplacementNamed(context, LoginPage.id),
        )
      ],
    ),
  );
  }

  Widget _createEmail(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        onChanged: (value){
          email = value;
        },
        decoration: InputDecoration(
        icon: Icon(Icons.alternate_email, color: Colors.red),
        hintText: 'test@test.com',
        labelText: 'Email',
        // counterText: snapshot.datam,
        // errorText: snapshot.error
        ) 
      ),
    );
  } 

  Widget _createPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        onChanged: (value){
          password = value;
        },
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.red),
          labelText: 'Password',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        // onChanged: bloc.changePassword,
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      onPressed: () async {
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          if(newUser != null){
            Navigator.pushNamed(context, ChatPage.id);
          }
        } catch (e) {
          print(e);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: animation.value * 20, vertical: animation.value * 10),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: animatedColor.value,
      textColor: Colors.white,
      // onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
    );
  }
}
