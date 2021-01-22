import 'package:shared_preferences/shared_preferences.dart';

Future<void> savedDataShareprecerences(result) async {
  var role       = result['role'].toString();
  var id         = result['id'].toString();              // table company - company id
  var id_manager = result['id_manager'].toString();
  var company    = result['company'].toString();         // company name
  var email      = result['email'].toString();
  var password   = result['password'].toString();
  var user       =  result['user'].toString();
  var id_worker  = result['id_worker'].toString();

 final prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', role);
  await prefs.setString('id', id);                // table company - company id
  await prefs.setString('id_manager', id_manager);
  await prefs.setString('company', company);
  await prefs.setString('email', email);
  await prefs.setString('password', password);
  await prefs.setString('user', user);
  await prefs.setString('id_worker', id_worker);
//  await prefs.setBool('is_login', true);
}


Future<String> getRole() async{
  final prefs = await SharedPreferences.getInstance();
  var result = await prefs.getString('role');
  if(result == null){ return 'register'; }
  return result;
}


// table company - company id
Future<String> getCompaniId() async{
  final prefs = await SharedPreferences.getInstance();
  var company_id = await prefs.getString('id');
  return company_id;
}


// get company name
Future<String> getCompanyName() async{
  final prefs = await SharedPreferences.getInstance();
  var company = await prefs.getString('company');
  if(company == null){
    return ' ';
  }
  return company;
}


Future<String> getIdManager() async {
final prefs = await SharedPreferences.getInstance();
var id = await prefs.getString('id_manager');
if(id == null){ return '_'; }
return id;
}

Future<String> getIdWorker() async{
  final prefs = await SharedPreferences.getInstance();
  var id = await prefs.getString('id_worker');
  if(id == null){ return '_'; }
  return id;
}


Future<String> getWorkerName() async {
  final prefs = await SharedPreferences.getInstance();
  var name_worker = await prefs.getString('user');
  if(name_worker == null){ return '_'; }
  return name_worker;
}


Future<String> getManagerName() async {
  final prefs = await SharedPreferences.getInstance();
  var name_worker = await prefs.getString('user');
  if(name_worker == null){ return '_'; }
  return name_worker;
}







