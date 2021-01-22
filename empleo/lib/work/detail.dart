import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  String url; String title;
  Detail(this.url, this.title);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var data_on = false;
  var oferta = '';
  var municipio = '';
  var fecha = '';
  var contacto = '';
  var provincia = '';

  makeRequest() async{
    var response = await http.get(widget.url);
    if(response.statusCode == 200){
      var document = parse(response.body);
      oferta = document.getElementById('datosAdicionales').text.toString().trim().toLowerCase();
      municipio = document.getElementById('municipio').attributes['value'].toString().trim();
      provincia = document.getElementById('provincia').attributes['value'].toString().trim();
      fecha = document.getElementById('fechaInicioDifusion').attributes['value'].toString().trim();
      contacto = document.getElementById('datosContacto').text.toString().trim().toLowerCase();
      print(municipio );
      setState(() {
        data_on = true;
      });
    }
  }

  @override
  void initState() {
    makeRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 5.1,
        title: Text( widget.title, style: TextStyle(color: Colors.black54),),
        iconTheme: IconThemeData(
          color: Colors.black54, //change your color here
        ),
      ),

      body: data_on ? SingleChildScrollView(
        padding: EdgeInsets.all(11.0),
        child: Card(
          elevation: 5.1,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(11.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Oferta:', style: TextStyle(color: Colors.lightBlueAccent,),
                ),
                Text(oferta, style: TextStyle(fontSize: 19.0),),
                Divider(height: 22.0, ),
                Text('Minicipio', style: TextStyle(color: Colors.lightBlueAccent,),),
                Text(municipio, style: TextStyle(fontSize: 19.0),),
                Divider(height: 22.0,),
                Text('Provincia', style: TextStyle(color: Colors.lightBlueAccent,),),
                Text(provincia, style: TextStyle(fontSize: 19.0),),
                Divider(height: 22.0,),
                Text('Fecha', style: TextStyle(color: Colors.lightBlueAccent,),),
                Text(fecha, style: TextStyle(fontSize: 19.0),),
                Divider(height: 22.0,),
                Text('Contacto', style: TextStyle(color: Colors.lightBlueAccent,),),
                Text(contacto, style: TextStyle(fontSize: 19.0),),
                Divider(height: 22.0,),
              ],
            ),
          ),
        ),
      ): Center(
        child: CircularProgressIndicator(),
      ),
    );

  }

}