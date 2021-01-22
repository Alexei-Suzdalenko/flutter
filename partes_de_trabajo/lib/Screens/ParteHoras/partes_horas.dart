import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/NewPart/new_part.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import '../../main.dart';

class ParteHoras extends StatefulWidget {
  String work_id;
  String work_name;
  String work_hours;
  ParteHoras (this.work_id, this.work_name, this.work_hours);
  @override
  _ParteHorasState createState() => _ParteHorasState();
}

class _ParteHorasState extends State<ParteHoras> {
  var subtitle = ''; // loading
  var par_tes = '';
  var hor_as = '';
  var list = [];
  var company_id = 'no';

  @override
  void initState() {
    super.initState();
    adminGetParts(widget.work_id).then((value) {
      setState(() {
        subtitle = par_tes + ': ' + value.length.toString()  + ',  ' + hor_as + ': ' + widget.work_hours.toString();
        list = value;
      });
    });
    getCompaniId().then((value) => company_id = value);
  }

  Future<bool> _onBackPressed() {
    if(company_id != 'no')  Navigator.of(context).pushNamedAndRemoveUntil('/boss', (Route<dynamic> route) => false, arguments: ScreenArguments(company_id, 'key', 'value'));
  }


  @override
  Widget build(BuildContext context) {
    if(subtitle == '') {
      subtitle = AppLocalizations.of(context).translate('loading');
      par_tes = AppLocalizations.of(context).translate('par_tes');
      hor_as = AppLocalizations.of(context).translate('hor_as');
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
           appBar: new AppBar(
                 title: Column( crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     Text(widget.work_name,),
                     Text(subtitle, style: TextStyle(fontSize: 16.0,),),
                 ]),
             actions: [ IconButton(
               icon: Icon(Icons.add, color: Colors.white,), onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                 NewPart(
                     AppLocalizations.of(context).translate('boss'),
                     widget.work_id,
                     AppLocalizations.of(context).translate('boss'),
                     widget.work_name)));}  // user(name) , workid , createdfor(id), work_name
             ) ],
             leading: new IconButton(
               icon: new Icon(Icons.arrow_back),
               onPressed: _onBackPressed,
             ),
           ),

          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0,),
                  child:  SizedBox( // Horizontal ListView
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                       children: [
                         Padding(
                           padding: EdgeInsets.only(bottom: 11.0),
                           child: Icon(Icons.today, color: Colors.blue, size: 18.0,),
                         ),
                         Text(' ' + list[index]['data'].toString() + ' ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                         Padding(
                           padding: EdgeInsets.only(bottom: 11.0),
                           child: Icon(Icons.person_pin , color: Colors.blue, size: 18.0,),
                         ),
                         Text(' ' + list[index]['user'].toString() + ' ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                         Padding(
                           padding: EdgeInsets.only(bottom: 11.0),
                           child: Icon(Icons.watch , color: Colors.blue, size: 18.0,),
                         ),
                         Text(' ' + list[index]['time'].toString() + ' ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                         Padding(
                           padding: EdgeInsets.only(bottom: 11.0),
                           child: Icon(Icons.build , color: Colors.blue, size: 18.0,),
                         ),
                         Text(' ' + list[index]['todo'].toString() + ' ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                         Padding(
                           padding: EdgeInsets.only(bottom: 11.0),
                           child: Icon(Icons.mode_edit , color: Colors.blue, size: 18.0,),
                         ),
                         Text(' ' + list[index]['material'].toString() + ' ', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                         InkWell(onTap: (){
                           deleteCustomPart(context, list[index]['data'].toString(), list[index]['id'].toString());
                         },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Icon(Icons.delete_forever, color: Colors.red, size: 22.0,),
                            ),
                         ),
                       ],
                    ),
                  ),
              );
            },
          ),
        ),
    );
  }

  deleteCustomPart(BuildContext context, data_part, id_part) {
    var inputDataPart = TextEditingController();

    Widget noButton = FlatButton(
      child: Text(
          AppLocalizations.of(context).translate('cancel'),
      ),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(
          AppLocalizations.of(context).translate('canceled'),
        ),));
        Navigator.pop(context);
      },
    );
    Widget okButton = FlatButton(
      child: Text(
          AppLocalizations.of(context).translate('delete'),
      ),
      onPressed: () {
        if (inputDataPart.text == data_part) {
          deletePartId(id_part)
              .then((value) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(
              AppLocalizations.of(context).translate('deleted'),
            ),));
            Navigator.push(context, MaterialPageRoute(builder: (context) => ParteHoras(widget.work_id, widget.work_name, value.toString())));
          });
          return;
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(
            AppLocalizations.of(context).translate('dont_deleted_date'),
          ),));
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
          AppLocalizations.of(context).translate('delete'),
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column( children: [ Text(
              AppLocalizations.of(context).translate('insert_date') + ' ( '+ data_part  +' ) ' + AppLocalizations.of(context).translate('for_delete')
          ),
            TextField( controller: inputDataPart, style: TextStyle(fontSize: 18.0,), decoration: InputDecoration(border: InputBorder.none, hintText: AppLocalizations.of(context).translate('insert_date'), hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),),],
          ),
        ),
      ),
      actions: [ noButton, okButton,],
    );
    showDialog(context: context, builder: (BuildContext context) {return alert; },);
  }



}

