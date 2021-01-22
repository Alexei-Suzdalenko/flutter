import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';

import '../main.dart';

class managerNewWork extends StatefulWidget {
  String company_id;
  managerNewWork(this.company_id);
  @override
  _managerNewWorkState createState() => _managerNewWorkState();
}

class _managerNewWorkState extends State<managerNewWork> {
  var manager_id = '';
  var workName = TextEditingController();
  var workAdress = TextEditingController();
  var workPrice = TextEditingController();

  @override
  void initState() {
    getIdManager().then((value) {  manager_id = value; });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(AppLocalizations.of(context).translate('new_work'), style: TextStyle(fontWeight: FontWeight.w400,),),),
      body: SingleChildScrollView(
        child: Container( margin: EdgeInsets.all(22.0),
          child: Column(
            children: [
              TextFormField(
                controller: workName,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('name_work'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: workAdress,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('address'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: workPrice,
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                decoration: new InputDecoration(labelText: AppLocalizations.of(context).translate('value'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40.0,),
              RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {
                  if(workName.text.trim() == '' || workAdress.text.trim() == ''){
                    Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('add_data'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                    ); return;
                  }
                  adminSaveNewWork(widget.company_id , workName.text.trim(), workAdress.text.trim(), workPrice.text, manager_id).then((value){
                    if(value == 'ok'){
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('work_added'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 19.0
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil('/manager', (Route<dynamic> route) => false, arguments: ScreenArguments(widget.company_id, 'key', 'value'));
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
