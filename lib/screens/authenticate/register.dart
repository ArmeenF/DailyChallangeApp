import 'package:flutter/material.dart';
import 'package:thedailychallenge/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<Register> {

   final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        elevation: 0.0,
        title: Text('Sign up to The Daily Challenge App'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: ()
            {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0)
                    ),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val)
                {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val)
                {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async
                {
                  if(_formKey.currentState.validate())
                  {
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null)
                    {
                      setState(() => error = 'please supply a valid email');
                    }
                  }
                }
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      )
    );
  }
}