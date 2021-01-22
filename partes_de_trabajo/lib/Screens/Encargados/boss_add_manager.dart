import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import '../../main.dart';

class BossAddManager extends StatefulWidget {
  String company_name; String company_id;
  BossAddManager(this.company_name, this.company_id);
  @override
  _BossAddManagerState createState() => _BossAddManagerState();
}

class _BossAddManagerState extends State<BossAddManager> {
  var name_manager = TextEditingController();
  var email_manager = TextEditingController();
  var pass_manager = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(
        AppLocalizations.of(context).translate('create_manager'),
        style: TextStyle(fontWeight: FontWeight.w400,),),),
      body: SingleChildScrollView(
        child: Container( margin: EdgeInsets.all(22.0),
          child: Column(
            children: [
              TextFormField(
                controller: name_manager,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('name'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: email_manager,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('email'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                //  controller: _passwordController,
                // obscureText: true,
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: pass_manager,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('password'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                //  controller: _passwordController,
                // obscureText: true,
              ),
              SizedBox(height: 40.0,),
              RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {
                  if(name_manager.text.trim() == '' || email_manager.text.trim() == '' || pass_manager.text.trim() == ''){
                    Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('add_data'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                    ); return;
                  }
                  adminSaveNewManager(widget.company_id, widget.company_name, name_manager.text.trim(), email_manager.text.trim(), pass_manager.text).then((value){
                    if(value == 'ok'){
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('manager_added'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 19.0
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil('/encargados', (Route<dynamic> route) => false, arguments: ScreenArguments(widget.company_id, 'key', 'value'));
                    } else {
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('error'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                      ); return;
                    }
                  });
                },
                child: Text(
                  AppLocalizations.of(context).translate('save'),
                style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400,),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
