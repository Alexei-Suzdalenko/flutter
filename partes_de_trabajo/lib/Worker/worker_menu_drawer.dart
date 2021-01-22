import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/Screens/Login/login_sharedpref.dart';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container( width: double.infinity, padding: EdgeInsets.all(50.0), color: Colors.deepPurple,
            child: Center(
              child: Column(
                children: [
                  Container( width: 101, height: 101,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(fit: BoxFit.fill, image: NetworkImage('https://images-na.ssl-images-amazon.com/images/I/41BfimFsXSL.png'),),
                    ),
                  ),
                  Text(AppLocalizations.of(context).translate('app_name'), style: TextStyle(fontSize: 15, color: Colors.white),),
                  Text(AppLocalizations.of(context).translate('worker'), style: TextStyle(fontSize: 14, color: Colors.white),),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.work, color: Colors.black87,),
            title: Text(AppLocalizations.of(context).translate('object_work'), style: TextStyle(color:Colors.black87, fontSize: 17.0,),),
            onTap: (){
              getCompaniId().then((company_id) {
                Navigator.of(context).pushNamedAndRemoveUntil('/worker', (Route<dynamic> route) => false, arguments: ScreenArguments(company_id, 'key', 'value'));
              });
            },
          ),
          SizedBox(height: 30,),
          ListTile(
            leading: Icon(Icons.web, color: Colors.black87,),
            title: Text(
              AppLocalizations.of(context).translate('web_version'),
              style: TextStyle(color:Colors.black87, fontSize: 17.0,),),
            onTap: (){
              const url = 'https://partesdetrabajo.eu';
              if ( canLaunch(url) != null) {
                launch(url);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle, color: Colors.black87,),
            title: Text(
              AppLocalizations.of(context).translate('autor'),
              style: TextStyle(color:Colors.black87, fontSize: 17.0,),),
            onTap: (){
              const url = 'https://suzdalenko.com';
              if ( canLaunch(url) != null) {
                launch(url);
              }
            },
          ),
        ],
      ),
    );
  }
}
