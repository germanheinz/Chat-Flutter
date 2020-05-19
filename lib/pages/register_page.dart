import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);
  static const String id = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _register(context)
        ],
      ),
    );
  }

  Widget _register(BuildContext context){

    final size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
      children: <Widget>[
        SafeArea(child: Container(
          height: 100.0,
        ),
        ),
        Container(
          width: size.width * 0.85,
          height: size.height * 0.6,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
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
              Text('Register', style: TextStyle(color: Colors.red, fontSize: 19.0),),
              _createEmail(),
              _createPassword(),
              SizedBox(height: 50.0),
              _crearBoton(),
            ],
          ),
        ),
        FlatButton(
          child: Text('Create Account'),
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
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
        padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.red,
      textColor: Colors.white,
      // onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
    );
  }
}
