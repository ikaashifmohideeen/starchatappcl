import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import "package:flash_chat/components/round_button.dart";
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id="registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth= FirebaseAuth.instance; ////llmll
  String email;
  bool setspinner=false;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: setspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(

                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  email=value;
                },
                decoration: ktextfeildbox,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  password=value;
                },
                decoration: ktextfeildbox.copyWith(hintText: "Password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              padwid(
                label: 'Register',
                onPressed:
                    () async {
                      setState(() {
                        setspinner=true;
                      });
                      // print(email);
                      // print(password);
                  try  {


                    final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if (newUser !=null)
                      {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    setState(() {
                      setspinner=false;
                    });

                  }
                  catch(e)
                      {
                        print(e);
                      }


                },
                color:  Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
