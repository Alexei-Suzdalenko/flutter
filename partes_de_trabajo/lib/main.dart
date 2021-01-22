import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:partes_de_trabajo/Manager/manager.dart';
import 'package:partes_de_trabajo/Manager/manager_workers.dart';
import 'package:partes_de_trabajo/Screens/Boss/boss.dart';
import 'package:partes_de_trabajo/Screens/Encargados/encargados.dart';
import 'package:partes_de_trabajo/Screens/Login/login.dart';
import 'package:partes_de_trabajo/Screens/Register/register.dart';
import 'package:partes_de_trabajo/Screens/Trabajadores/trabajadores.dart';
import 'package:partes_de_trabajo/Worker/worker.dart';
import 'package:partes_de_trabajo/start.dart';
import 'package:partes_de_trabajo/translate/app_localizations.dart';

void main () => runApp (
  MaterialApp(
    title : 'Partes de Trabajo',
    theme : ThemeData( primarySwatch: Colors.deepPurple, ),

    supportedLocales: [
      Locale('en', ''),
      Locale('ru', ''),
      Locale('es', ''),
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },

    routes: {
      '/register'          : (context) => Register(),
      '/login'             : (context) => Login(false, '', ''),
      '/boss'              : (context) => Boss(),
      '/encargados'        : (context) => Encargados(),
      '/trabajadores'      : (context) => Trabajadores(),

      '/manager'           : (context) => Manager(),
      '/manager_workers'   : (context) => ManagerWorkers(),

      '/worker'            : (context) => Worker(),                 // this
    },

     home: Start(),   // Start(),   Login(false, '', '')
  )
);
