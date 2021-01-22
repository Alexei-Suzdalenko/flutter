import 'dart:convert';
import 'dart:developer';
import 'package:partes_de_trabajo/Screens/variables.dart';
import 'package:http/http.dart' as http;
import '../components.dart';



Future<String> sentRegisterData(x, y, z) async {
  var map = new Map<String, dynamic>();
  map['company'] = x;
  map['email'] = y;
  map['password'] = z;
  try {
    var response = await http.post(url_register, body: map,);
    var result = json.decode(response.body);
    return result['saved'];
  } catch(e) {
    return 'usuario_exist';
    //  setState(() { usuario_exist = true; });
  }
}


// /all_works
var lengtnWorks = '';
Future<List<Works>> getAllWorks(id) async {
       var map = new Map<String, dynamic>();
       map['id'] = id;
       var data = await http.post( url_get_all_works , body: map, );
       var jsonData = await json.decode(data.body);
       List<Works> works = [];
       for(var w in jsonData){
         Works work = new Works(w['id'].toString(), w['name'].toString(), int.parse(w['hours']), w['price'].toString(), w['adress'].toString(), w['createdfor'].toString());
         works.add(work);
       }
       lengtnWorks = works.length.toString();
       var reversedList = works.reversed.toList();
       return reversedList;
}


// /all_works
Future<String> deleteWorkId(id) async {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    var data = await http.post( delete_work_by_id , body: map, );
    var jsonData = await json.decode(data.body);
    return jsonData['ok'];
}

// /api/admin_save_new_work
Future<String> adminSaveNewWork(company_id, name, direcction, price , createdfor) async {
  var map = new Map<String, dynamic>();
  map['id'] = company_id;
  map['name'] = name;
  map['adress'] = direcction;
  map['price'] = price;
  map['createdfor'] = createdfor;
  var data = await http.post( save_new_work , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['saved'];
}

// /api/get_parts
Future<List> adminGetParts(workid) async {
  var map = new Map<String, dynamic>();
  map['id'] = workid;
  var data = await http.post( get_parts , body: map, );
  var jsonData = await json.decode(data.body);
  var reversedList = jsonData.reversed.toList();
  return reversedList;
}

// calendar_data.toString(), widget.user, horas.text, trabajo.text, material.text, widget.workid, widget.createdfor
Future<int> adminSaveNewPart(date, user, time, todo, material, workid, createdfor) async {
  var c = 0;
  try{
    c = int.parse(time);
    if(c < 0 || c > 23) { c = 0;}
  } catch(e){
    c = 0;
  }
  var map = new Map<String, dynamic>();
       map['date'] = date;
       map['user'] = user;
       map['time'] =  c.toString();
       map['todo'] = todo;
       map['material'] = material;
       map['workid'] = workid.toString();
       map['createdfor'] = createdfor.toString();
       var data = await http.post( save_part , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['timer'];
}

//  /api/delete_part
Future<int> deletePartId(id_part) async{
  var map = new Map<String, dynamic>();
      map['id_part'] = id_part;
  var data = await http.post( delete_part_id , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['hours'];
}


Future<List> getAllManagers (id_company) async{
  var map = new Map<String, dynamic>();
  map['c_id'] = id_company;

  var data = await http.post( get_all_managers , body: map, );
  var jsonData = await json.decode(data.body);
  var reversedList = jsonData.reversed.toList();
  log(reversedList.toString());
  return reversedList;
}

Future<String> adminSaveNewManager(id_company, company_name, manager_name, email, password) async{
  var map = new Map<String, dynamic>();
  map['c_id']       = id_company;
  map['c_name']     = company_name;
  map['name']       = manager_name;
  map['email']      = email;
  map['password']   = password;
  var data = await http.post( save_new_manager , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['saved'];
}

Future<String> deleteManagerId(manager_id) async {
  var map = new Map<String, dynamic>();
  map['id']       = manager_id;
  var data = await http.post( delete_manager , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['ok'];
}


Future<List> getAllWorkers(id_company) async {
  var map = new Map<String, dynamic>();
  map['c_id'] = id_company;

  var data = await http.post( get_all_workers , body: map, );
  var jsonData = await json.decode(data.body);
  var reversedList = jsonData.reversed.toList();
  log(reversedList.toString());
  return reversedList;
}


Future<String> adminSaveNewWorker(id_company, company_name, manager_name, email, password, createdfor) async{
  var map = new Map<String, dynamic>();
  map['c_id']       = id_company;
  map['c_name']     = company_name;
  map['name']       = manager_name;
  map['email']      = email;
  map['password']   = password;
  map['createdfor']   = createdfor;
  var data = await http.post( save_new_worker , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['saved'];
}


Future<String> deleteWorkerId(worker_id) async {
  var map = new Map<String, dynamic>();
  map['id']       = worker_id;
  var data = await http.post( delete_worker , body: map, );
  var jsonData = await json.decode(data.body);
  return jsonData['ok'];
}















