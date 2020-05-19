import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
   static const String id = 'login';

  // Defino el controller para Animation
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;
  Animation animatedColor;

  @override
  void initState() {
    super.initState();

    controller    = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation     = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animatedColor = ColorTween(begin: Colors.white, end: Colors.red).animate(controller);
    
    controller.forward();

    controller.addListener((){
      setState(() {
        
      });
      print(controller.value);
      
    });
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
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
                color: Colors.grey,
                blurRadius: 1.0,
                offset: Offset(0.0,2.5),
                spreadRadius: 0.5,
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Text('Login', style: TextStyle(color: animatedColor.value, fontSize: 19.0, fontWeight: FontWeight.bold),),
              _createEmail(),
              _createPassword(),
              SizedBox(height: 40.0),
              _crearBoton(),
            ],
          ),
        ),
        FlatButton(
          child: Text('Create Account'),
          onPressed: () => Navigator.pushReplacementNamed(context, RegisterPage.id),
        )
      ],
    ),
  );
  }

  Widget _createEmail(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
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
      onPressed: (){},
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