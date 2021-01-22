import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Boss/boss_drawer.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import 'package:share/share.dart';
import '../../main.dart';
import 'boss_add_workers.dart';

class Trabajadores extends StatefulWidget {
  @override
  _TrabajadoresState createState() => _TrabajadoresState();
}

class _TrabajadoresState extends State<Trabajadores> {
  var company_name = ''; var _company_id = '';

  @override
  void initState() {
    super.initState();
    getCompanyName().then((value) { setState(() { company_name = value; }); });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var company_id = args.id != null ? args.id : ''; _company_id = company_id;

    return  Scaffold(
      appBar: AppBar(
        title: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company_name, style: TextStyle(fontWeight: FontWeight.w400,),),
              Text(
                AppLocalizations.of(context).translate('workers'),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0,),),
            ]),
        actions: [ IconButton(
          icon: Icon(Icons.add, color: Colors.white,), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => BossAddWorker(company_name, company_id)));} ,
        ) ],
      ),
      drawer: MenuDrawer(),
      body: Container(
        child: FutureBuilder(
          future: getAllWorkers( company_id ),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate('loading'),
                  ),
                ),
              );
            }
            if(snapshot.data.length == 0){
              return Container(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate('dont_workers'),
                  ),
                ),
              );
            }
            return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index){
                  return Container( margin: EdgeInsets.all(11.0),
                    child:  SizedBox( height: 30,
                      child: ListView( scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: (){
                              var message = AppLocalizations.of(context).translate('data_users') + ' \n ' +
                                   AppLocalizations.of(context).translate('data_worker') + '\n ' +
                                   AppLocalizations.of(context).translate('name_m') + snapshot.data[index]['name'] + '\n ' +
                                   AppLocalizations.of(context).translate('email_m') + snapshot.data[index]['email'] + '\n ' +
                                   AppLocalizations.of(context).translate('password_m') + snapshot.data[index]['password'];
                              Share.share(message);
                            },
                            child: Padding( padding: EdgeInsets.all(3.0),
                              child: Icon(Icons.share, color: Colors.deepPurpleAccent, size: 21.0,),
                            ),
                          ),
                          Text(' ' + snapshot.data[index]['name'] + ' ', style: TextStyle(fontSize: 19.0, color: Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(bottom: 11.0, top: 5.0,),
                            child: Icon(Icons.email, color: Colors.deepPurpleAccent, size: 21.0,),
                          ),
                          Text(' ' + snapshot.data[index]['email'] + ' ', style: TextStyle(fontSize: 19.0, color: Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(bottom: 11.0, top: 5.0,),
                            child: Icon(Icons.vpn_key , color: Colors.deepPurpleAccent, size: 21.0,),
                          ),
                          Text(' ' + snapshot.data[index]['password']  + ' ', style: TextStyle(fontSize: 19.0, color: Colors.black),),
                          InkWell(
                            onTap: (){
                              deleteCustomWorker(context, snapshot.data[index]['name'], snapshot.data[index]['id'].toString());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 11.0, top: 5.0,),
                              child: Icon(Icons.delete_forever , color: Colors.red, size: 21.0,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }


  deleteCustomWorker(BuildContext context, worker_name, worker_id) {
    var inputManagerName = TextEditingController();

    Widget noButton = FlatButton(
      child: Text(
          AppLocalizations.of(context).translate('cancel'),
      ),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            AppLocalizations.of(context).translate('canceled')
        ),));
        Navigator.pop(context);
      },
    );
    Widget okButton = FlatButton(
      child: Text(
          AppLocalizations.of(context).translate('delete')
      ),
      onPressed: () {
        if (inputManagerName.text == worker_name){
          deleteWorkerId(worker_id)
              .then((value) {
            if(value == 'ok'){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(
                  AppLocalizations.of(context).translate('deleted'),
              ),));
              Navigator.of(context).pushNamedAndRemoveUntil('/trabajadores', (Route<dynamic> route) => false, arguments: ScreenArguments(_company_id, 'key', 'value'));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(
                  AppLocalizations.of(context).translate('error'),
              ),));
            }
          });
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(
              AppLocalizations.of(context).translate('dont_name'),
          ),));
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context).translate('delete'),),
      content: Container(
        child: SingleChildScrollView(
          child: Column( children: [ Text(
              AppLocalizations.of(context).translate('insert_name_work') + ' ( '+ worker_name  +' ) ' + AppLocalizations.of(context).translate('for_delete'),
          ),
            TextField( controller: inputManagerName, style: TextStyle(fontSize: 18.0,), decoration: InputDecoration(border: InputBorder.none, hintText:
            AppLocalizations.of(context).translate('name_worker'),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),),],
          ),
        ),
      ),
      actions: [ noButton, okButton,],
    );

    showDialog(context: context, builder: (BuildContext context) {return alert; },);
  }


}

