import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/boss.dart';
import 'package:partes_de_trabajo/Screens/Register/register.dart';
import 'package:partes_de_trabajo/Screens/Register/register_variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import '../../main.dart';
import '../components.dart';
import '../variables.dart';
import 'login_sharedpref.dart';
class Login extends StatefulWidget {
 bool exito;     String email; String password;
 Login(this.exito, this.email,   this.password);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Login> {
  var role = 'none';
  var role_login = 'boss';
  var loginProcess = false;
  var user_no_exist = false;

  @override
  void initState() {
    email_login    = TextEditingController(text: widget.email);
    password_login = TextEditingController(text: widget.password);
    super.initState();
  }

  sentLoginToServer(role, email, password) async {
    var map = new Map<String, dynamic>();
    map['role'] = role; map['email'] = email; map['password'] = password;

    try {
      var response = await http.post(url_login, body: map,);                    setState(() { loginProcess = false; });
      var result = json.decode(response.body);
      if(result['enter'] == 'ok'){
        savedDataShareprecerences(result);
          switch(role){
            case 'boss' :
              Navigator.of(context).pushNamedAndRemoveUntil('/boss', (Route<dynamic> route) => false, arguments: ScreenArguments(result['id'].toString(), 'key', 'value'));
              break;
            case 'manager':
              Navigator.of(context).pushNamedAndRemoveUntil('/manager', (Route<dynamic> route) => false, arguments: ScreenArguments(result['id'].toString(), 'key', 'value'));
              break;
            case 'worker':
              Navigator.of(context).pushNamedAndRemoveUntil('/worker', (Route<dynamic> route) => false, arguments: ScreenArguments(result['id'].toString(), 'key', 'value'));
              break;
          }
      }
      if(result['error'] == true){
        setState(() { user_no_exist = true; });
        log('USER NO EXIST');
      }
    } catch(e) {log(e);}
  }

  @override
  Widget build(BuildContext context) {
    if (role == 'none'){ role = AppLocalizations.of(context).translate('admin'); }

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DoubleImage(width),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.exito ? Text(
                    AppLocalizations.of(context).translate('exit'),
                    style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),) :
                                 Text(
                                   AppLocalizations.of(context).translate('enter'),
                                   style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 30,),
                  user_no_exist ? Container( padding: EdgeInsets.all(11.0), width: double.infinity, margin: EdgeInsets.only(bottom: 22.0, top: 22.0,), decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(1.0), color: Colors.red,),
                    child: Text(
                      AppLocalizations.of(context).translate('no_user'),
                      style: TextStyle(fontSize: 18.0, color: Colors.white, ),),
                  ) : SizedBox(height: 0,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(38, 9, 53, 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration( border: Border(bottom: BorderSide( color: Colors.grey[200]),),),
                                child:   DropdownButton<String>(
                                  value: role,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container( height: 0, color: Colors.white,),
                                  onChanged: (String newValue) {
                                    setState(() { role = newValue; });
                                  },
                                  items: <String>[
                                    AppLocalizations.of(context).translate('admin'),
                                    AppLocalizations.of(context).translate('manager'),
                                    AppLocalizations.of(context).translate('worker'),
                                    ]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Colors.black, fontSize: 18.0,),),
                                    );
                                  }).toList(),
                                ),
                    ),
                        Container(padding: EdgeInsets.all(10), decoration: BoxDecoration( border: Border(bottom: BorderSide( color: Colors.grey[200]),),),
                          child: TextField(
                            controller: email_login,
                            style: TextStyle(fontSize: 18.0,),
                            decoration: InputDecoration(border: InputBorder.none, hintText:
                            AppLocalizations.of(context).translate('email'),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),
                          ),
                        ),
                        Container( padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: password_login,
                            style: TextStyle(fontSize: 18.0,),
                            decoration: InputDecoration(border: InputBorder.none, hintText:
                            AppLocalizations.of(context).translate('password'),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  loginProcess ? Center( child: CircularProgressIndicator(),) : SizedBox(height: 0,),
                  SizedBox(height: 30,),
                  Center(
                      child: OutlineButton(
                        onPressed: (){
                          setState(() { loginProcess = true; user_no_exist = false; });
                          switch(role){
                            case 'Administrator'         : role_login = 'boss';    break;
                            case 'Manager'               : role_login = 'manager'; break;
                            case 'Worker'                : role_login = 'worker';  break;

                            case 'Gerente-administrador' : role_login = 'boss';    break;
                            case 'Encargado'             : role_login = 'manager'; break;
                            case 'Trabajador'            : role_login = 'worker';  break;

                            case 'Администратор'        : role_login = 'boss';    break;
                            case 'Менеджер'             : role_login = 'manager'; break;
                            case 'Рабочий'              : role_login = 'worker';  break;
                          }
                          sentLoginToServer(role_login, email_login.text.trim(), password_login.text.trim());
                        },
                        highlightElevation: 120.0,
                        borderSide: BorderSide(color: Color.fromRGBO(54, 5, 79, 1), width: 1.0),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('enter'),
                          style: TextStyle( color: Color.fromRGBO(45, 18, 58, 1), fontSize: 18.0,),),
                      ),
                    ),
                  SizedBox(height: 40,),
                  Center(child: new InkWell( onTap: (){
                    Navigator.push( context, MaterialPageRoute(builder: (context) => Register()), );
                    },
                      child: Text(
                        AppLocalizations.of(context).translate('no_have'),
                        style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),),
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
