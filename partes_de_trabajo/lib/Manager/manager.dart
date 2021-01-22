import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import '../main.dart';
import 'manager_new_work.dart';
import 'menu_drawer_manager.dart';
import 'part_horas_manager.dart';

class Manager extends StatefulWidget {
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  var company_name = ''; var company_id = ''; var manager_id = '_';

  @override
  void initState() {
    super.initState();
    getCompanyName().then((value) { setState(() { company_name = value; }); });
    getIdManager().then((value) { setState(() { manager_id = value; }); });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    company_id = args.id != null ? args.id : '';

    return Scaffold(
      appBar: AppBar(
        title: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company_name, style: TextStyle(fontWeight: FontWeight.w400,),),
              Text(AppLocalizations.of(context).translate('object_work'), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0,),),
            ]),
        actions: [ IconButton(
          icon: Icon(Icons.create_new_folder, color: Colors.white,), onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => managerNewWork( company_id )));
             } ,
        ) ],
      ),
      drawer: MenuDrawerManager(),
      body: Container(
        child: FutureBuilder(
          future: getAllWorks( company_id ),
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
                  child: Text(AppLocalizations.of(context).translate('dont_have_work'),),
                ),
              );
            }
            return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => managerPartHoras(snapshot.data[index].id, snapshot.data[index].name, snapshot.data[index].hours.toString())));
                              },
                              child: Container( margin: EdgeInsets.only(right: 5.0, top: 11.0,),
                                  decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.all(Radius.circular(5.0),),),
                                  child: Padding( padding: EdgeInsets.all(3.0),
                                    child: Icon(Icons.content_paste, color: Colors.white, size: 18.0,),
                                  )
                              ),
                            ),
                            Expanded(
                              child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 17.0, color: blueGreyColor,), overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false,),
                            ),
                            Text(snapshot.data[index].hours.toString() + ' ' + AppLocalizations.of(context).translate('hours'), style : TextStyle(fontSize: 17.0, color: blueGreyColor), overflow: TextOverflow.ellipsis,),
                            manager_id == snapshot.data[index].createdfor.toString() ?  InkWell(onTap: (){ deleteCustomWork(context, snapshot.data[index].name, snapshot.data[index].id);},
                              child: Icon(Icons.delete_forever, color: Colors.red, size: 24.0,),) :  SizedBox(height: 1, width: 22.0,),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 1, width: 22.0,),
                            Expanded(
                              child: Container( margin: EdgeInsets.only(left: 7.0,),
                                child:   Text(snapshot.data[index].adress, style: TextStyle(fontSize: 15.0, color: blueGreyColor), overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                            Text(snapshot.data[index].price + ' €', style: TextStyle(fontSize: 15.0, color: blueGreyColor),overflow: TextOverflow.ellipsis,),
                            // Text(snapshot.data[index].createdfor),
                            SizedBox(height: 1, width: 24.0,),
                          ],
                        ),
                     //   Text(snapshot.data[index].createdfor.toString()),
                      ],
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }


  deleteCustomWork(BuildContext context, work_name, workId) {
    var inputWorkName = TextEditingController();

    Widget noButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('cancel'),),
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate('canceled'),),));
        Navigator.pop(context);
      },
    );
    Widget okButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('delete'),),
      onPressed: () {
        if (inputWorkName.text == work_name){
          deleteWorkId(workId)
              .then((value) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate('deleted'),),));
            Navigator.of(context).pushNamedAndRemoveUntil('/manager', (Route<dynamic> route) => false, arguments: ScreenArguments(company_id, 'key', 'value'));
          });
          return;
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate('dont_name'),),));
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context).translate('deleted'),),
      content: Container(
        child: SingleChildScrollView(
          child: Column( children: [ Text(AppLocalizations.of(context).translate('insert_name') + ' ( '+ work_name  +' ) ' + AppLocalizations.of(context).translate('for_delete'),),
            TextField( controller: inputWorkName, style: TextStyle(fontSize: 18.0,), decoration: InputDecoration(border: InputBorder.none, hintText: AppLocalizations.of(context).translate('name_work'), hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0,),),),],
          ),
        ),
      ),
      actions: [ noButton, okButton,],
    );
    showDialog(context: context, builder: (BuildContext context) {return alert; },);
  }


}
