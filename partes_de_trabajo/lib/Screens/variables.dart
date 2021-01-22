import 'package:flutter/material.dart';


var blueGreyColor =  Color(0xff400e59);

var url_register      = 'https://partesdetrabajo.eu/api/register';
var url_login         = 'https://partesdetrabajo.eu/api/login';
var url_get_all_works = 'https://partesdetrabajo.eu/api/all_works';
var delete_work_by_id = 'https://partesdetrabajo.eu/api/delete_work';
var save_new_work     = 'https://partesdetrabajo.eu/api/admin_save_new_work';
var get_parts         = 'https://partesdetrabajo.eu/api/get_parts';
var save_part         = 'https://partesdetrabajo.eu/api/save_part';
var delete_part_id    = 'https://partesdetrabajo.eu/api/delete_part';
var get_all_managers  = 'https://partesdetrabajo.eu/api/all_managers';
var save_new_manager  = 'https://partesdetrabajo.eu/api/save_new_manager';
var delete_manager    = 'https://partesdetrabajo.eu/api/delete_manager';
var get_all_workers   = 'https://partesdetrabajo.eu/api/all_workers';
var save_new_worker   = 'https://partesdetrabajo.eu/api/save_worker';
var delete_worker     = 'https://partesdetrabajo.eu/api/delete_worker';



class ScreenArguments {
  final String id; final String key; final String value;
  ScreenArguments(this.id, this.key, this.value);
}

class LoginArg{
  final bool exito; String email; String password;
  LoginArg(this.exito, this.email, this.password);
}
