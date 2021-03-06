import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flash_chat/components/round_button.dart";

class WelcomeScreen extends StatefulWidget {
  static const String id="welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController Controller;
  Animation animation;
  @override
  void initState() {

    super.initState();
    Controller=AnimationController(

      duration:Duration(seconds: 1),
      vsync: this,


    );
    animation=CurvedAnimation(parent: Controller,curve: Curves.decelerate);
    Controller.forward();
    Controller.addStatusListener((status) {
      setState(() {
        print(animation.value);
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value*100,

                  ),

                ),

                TypewriterAnimatedTextKit(

                  text:['tar Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            padwid(
              label: "login",
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              color: Colors.lightBlueAccent,
            ),
            padwid(
              label: 'Register',
              onPressed:
                    () {
                  Navigator.pushNamed(context,RegistrationScreen.id);

              },
              color:  Colors.blueAccent,
            ),

          ],
        ),
      ),
    );
  }
}

