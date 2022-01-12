import 'package:flutter/material.dart';
class padwid extends StatelessWidget {
  padwid({this.label,this.onPressed,this.color});
  String label;
  Function onPressed;
  Color color;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:
          onPressed,

          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
