import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Login/login.dart';
import 'package:partes_de_trabajo/Screens/Register/register_variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../components.dart';
import '../variables.dart';
class Register extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Register> {
  var registeringProcess = false;
  var usuario_exist = false;
  var haveError = false;

  _launchURL() async {
    const url = 'https://partesdetrabajo.eu/info';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
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
                  haveError ? Container( padding: EdgeInsets.all(11.0), margin: EdgeInsets.only(bottom: 22.0, top: 22.0,),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(1.0),
                      color: Colors.red,
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('add_data'),
                      style: TextStyle(fontSize: 18.0, color: Colors.white, ),),
                  ) : Text(
                    AppLocalizations.of(context).translate('reg'),
                    style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),),
                  usuario_exist ? Container( padding: EdgeInsets.all(11.0), margin: EdgeInsets.only(bottom: 22.0, top: 22.0,),
                    decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(1.0), color: Colors.red,),
                    child: Text(
                      AppLocalizations.of(context).translate('user_exist'),
                      style: TextStyle(fontSize: 18.0, color: Colors.white, ),),
                  ) : SizedBox(height: 0,),
                  SizedBox(height: 30,),
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
                        Container(padding: EdgeInsets.all(10), decoration: BoxDecoration( border: Border(bottom: BorderSide( color: Colors.grey[200]),),),
                          child: TextField(
                            controller: register_company,
                            style: TextStyle(fontSize: 18.0,),
                            decoration: InputDecoration(border: InputBorder.none, hintText:
                             AppLocalizations.of(context).translate('company_name'),
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),
                          ),
                        ),
                        Container(padding: EdgeInsets.all(10), decoration: BoxDecoration( border: Border(bottom: BorderSide( color: Colors.grey[200]),),),
                          child: TextField(
                            controller: register_email,
                            style: TextStyle(fontSize: 18.0,),
                            decoration: InputDecoration(border: InputBorder.none, hintText:
                            AppLocalizations.of(context).translate('email'),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),
                          ),
                        ),
                        Container( padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: register_password,
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
                  registeringProcess ? Center( child: CircularProgressIndicator(),) : SizedBox(height: 0,),
                  SizedBox(height: 30,),
                  Center(
                    child: RaisedButton(
                             padding: EdgeInsets.all(15.0),
                             highlightElevation: 20.0,
                             splashColor: Colors.white,
                             elevation: 20.0,
                             color: blueGreyColor,
                             shape: RoundedRectangleBorder(
                                 borderRadius: new BorderRadius.circular(30.0)),
                             child: Text(
                               AppLocalizations.of(context).translate('reg'),
                               style: TextStyle( color: Colors.white, fontSize: 18.0, ),),
                             onPressed: () {
                                        if(register_company.text == '' || register_email.text == '' || register_password.text == ''){
                                            setState(() { haveError = true; registeringProcess = false; });
                                        } else {
                                          setState(() { haveError = false; registeringProcess = true; usuario_exist = false; });
                                          sentRegisterData(register_company.text.trim(), register_email.text.trim(), register_password.text.trim())
                                              .then((value){
                                                  setState(() { registeringProcess = false; });
                                                  if(value == 'ok'){
                                                    // saved login to sharedpreferences
                                                    Navigator.push( context, MaterialPageRoute(builder: (context) => Login(true, register_email.text.trim(), register_password.text.trim())),);
                                                  }
                                                  if( 'usuario_exist' == value ) {
                                                    setState(() { usuario_exist = true; });
                                                  }
                                          });
                                        }
                                        },
                    ),
                  ),
                  SizedBox(height: 40,),
                  Center(child: new InkWell( onTap: (){
                    if(register_email.text.trim() == '' && register_password.text.trim() == ''){
                      Navigator.push( context, MaterialPageRoute(builder: (context) => Login(false, '', '')),);
                    }
                     else {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => Login(false, register_email.text.trim(), register_password.text.trim())),);
                     }
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('have'),
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontSize: 16.0,),),
                     ),
                  ),
                  SizedBox(height: 50,),
                  Center(child:  Text(
                    AppLocalizations.of(context).translate('legenda'),
                    style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontSize: 16.0,),),),
                  SizedBox(height: 10,),
                  SizedBox(height: 50,),
                  Center(child: new InkWell( child: Text(
                    AppLocalizations.of(context).translate('info'),
                    style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1),fontSize: 16.0,),),
                       onTap: (){ _launchURL(); },
                     ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}