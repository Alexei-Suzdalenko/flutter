import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partes_de_trabajo/Manager/part_horas_manager.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/NewPart/calendar.dart';
import 'package:partes_de_trabajo/Screens/ParteHoras/partes_horas.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';

class managerNewkPart extends StatefulWidget {
  String workid; String createdfor; String work_name;
  managerNewkPart (this.workid, this.createdfor, this.work_name);

  @override
  _managerNewWorkPartState createState() => _managerNewWorkPartState();
}

class _managerNewWorkPartState extends State<managerNewkPart> {
  var horas = TextEditingController();
  var material = TextEditingController();
  var trabajo = TextEditingController();
  var work_hours = 0; var name_manager = '';

  @override
  void initState() {
    getManagerName().then((value) => name_manager = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.work_name,),
              Text(AppLocalizations.of(context).translate('new_part'), style: TextStyle(fontSize: 16.0,),),
            ]),
      ),
      body:SingleChildScrollView(
        child: Container( margin: EdgeInsets.all(22.0),
          child: Column( // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Calendar(),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: horas,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('hour'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                keyboardType: TextInputType.number,
                //   inputFormatters: <TextInputFormatter>[
                //     FilteringTextInputFormatter.digitsOnly
                //   ],
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: material,
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                decoration: new InputDecoration(labelText: AppLocalizations.of(context).translate('material'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                ), // Only num
                keyboardType: TextInputType.multiline, maxLines: 3,
              ),
              TextFormField(
                controller: trabajo,
                style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),
                decoration: new InputDecoration(labelText: AppLocalizations.of(context).translate('work_released'),
                  labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 18.0, fontFamily: 'AvenirLight'),
                  focusedBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.deepPurpleAccent),),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),), // Only numbers can be entered
                keyboardType: TextInputType.multiline, maxLines: 3,
              ),
              SizedBox(height: 40.0,),
              RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {
                  if(calendar_data == ''){
                    Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('add_data'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0
                    ); return;
                  }
                  adminSaveNewPart(calendar_data.toString(), name_manager, horas.text.toString(), trabajo.text.trim(), material.text.trim(), widget.workid, widget.createdfor).then((value){
                    if(value >= 0){
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('new_part_created'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 3, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 19.0
                      );
                      calendar_data = '';
                      horas.text = '';
                      material.text = '';
                      trabajo.text = '';
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => managerPartHoras (widget.workid, widget.work_name, value.toString())));
                      return;
                    } else {
                      Fluttertoast.showToast(msg: AppLocalizations.of(context).translate('error'), toastLength: Toast.LENGTH_LONG , gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 19.0); return;
                    }
                  });
                },
                child: Text(AppLocalizations.of(context).translate('save'), style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

