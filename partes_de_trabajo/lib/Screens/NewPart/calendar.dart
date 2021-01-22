import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';

var calendar_data = '';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    String lang = AppLocalizations.of(context).translate('lang');

    final DateTime picked = await showDatePicker(
        context: context,
        locale : new Locale(lang, ""),
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2301));
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        calendar_data = "${selectedDate.toLocal()}".split(' ')[0];
        log(selectedDate.toString());
        log(picked.toString());
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column( // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(calendar_data, style: TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'AvenirLight'),),
          SizedBox(height: 20.0,),
          RaisedButton(
            color: Colors.deepPurple,
            onPressed: () => _selectDate(context),
            child: Text(
              AppLocalizations.of(context).translate('set_date'),
              style: TextStyle(color: Colors.white, fontSize: 18.0,),),
          ),
        ],
    );;
  }
}
