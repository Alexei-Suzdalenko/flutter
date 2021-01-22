import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Boss/api_boss.dart';
import 'file:///C:/_flutters%20work/partes_de_trabajo/lib/Worker/worker_part_horas.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/Worker/worker_menu_drawer.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';

class Worker extends StatefulWidget {
  @override
  _WorkerState createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  var company_name = ''; var company_id = '';

  @override
  void initState() {
    getCompanyName().then((value) { setState(() { company_name = value; }); });
    super.initState();
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
      ),
      drawer: WorkerMenuDrawer(),
      body: Container(
        child: FutureBuilder(
          future: getAllWorks( company_id ),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text(AppLocalizations.of(context).translate('loading'),),
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
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => WorkersHoursPart(snapshot.data[index].id, snapshot.data[index].name, snapshot.data[index].hours.toString())));
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
                            Text(snapshot.data[index].hours.toString() + ' ' + AppLocalizations.of(context).translate('hour'), style : TextStyle(fontSize: 17.0, color: blueGreyColor), overflow: TextOverflow.ellipsis,),
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
}
