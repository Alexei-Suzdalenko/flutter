import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import '../../main.dart';

class BossAddWorker extends StatefulWidget {
  String company_name; String company_id;
  BossAddWorker(this.company_name, this.company_id);
  @override
  _BossAddWorkerState createState() => _BossAddWorkerState();
}

class _BossAddWorkerState extends State<BossAddWorker> {
  var name_worker = TextEditingController();
  var email_worker = TextEditingController();
  var pass_worker = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( AppLocalizations.of(context).translate('create_worker'), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0,),),
      ),
      body: SingleChildScrollView(
        child: Container( margin: EdgeInsets.all(22.0),
          child: Column(
            children: [
              TextFormField(
                controller: name_worker,
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
                controller: email_worker,
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
                controller: pass_worker,
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
                  if(name_worker.text.trim() == '' || email_worker.text.trim() == '' || pass_worker.text.trim() == ''){
                    Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('add_data'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                    ); return;
                  }
                  adminSaveNewWorker(widget.company_id, widget.company_name, name_worker.text.trim(), email_worker.text.trim(), pass_worker.text, 'boss').then((value){
                    if(value == 'ok'){
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('created_worker'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 19.0
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil('/trabajadores', (Route<dynamic> route) => false, arguments: ScreenArguments(widget.company_id, 'key', 'value'));
                    } else {
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('error'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                      ); return;
                    }
                  });
                },
                child: Text(AppLocalizations.of(context).translate('save'), style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
