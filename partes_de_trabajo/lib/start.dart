import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'Screens/Login/login_sharedpref.dart';
import 'main.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
   getRole().then((value) {
     switch(value){
       case 'register' : Navigator.of(context).pushNamedAndRemoveUntil( '/login',  (Route<dynamic> route) => false);
         break;
       case 'boss' : getCompaniId().then((value) =>
           Navigator.of(context).pushNamedAndRemoveUntil('/boss', (Route<dynamic> route) => false, arguments: ScreenArguments(value.toString(), 'key', 'value')));
         break;
       case 'manager' : getCompaniId().then((value) =>
           Navigator.of(context).pushNamedAndRemoveUntil('/manager', (Route<dynamic> route) => false, arguments: ScreenArguments(value.toString(), 'key', 'value')));
         break;
       case 'worker' : getCompaniId().then((value) =>
           Navigator.of(context).pushNamedAndRemoveUntil('/worker', (Route<dynamic> route) => false, arguments: ScreenArguments(value.toString(), 'key', 'value')));
         break;
     }
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}
