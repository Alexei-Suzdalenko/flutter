import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

void main() { runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: myCalc(),
    );
  }
}

class myCalc extends StatefulWidget {
  @override
  _myCalcState createState() => _myCalcState();
}

class _myCalcState extends State<myCalc> {

  final controller_peso = TextEditingController();
  final controller_talla = TextEditingController();
  final my_form_key = GlobalKey<FormState>();
  final d = Decimal;
  String muestreImc = "";
  String pesoSugerido = "";

  // creamos clase para calcular peso mujer
  void PesoIdealMujer() {
    int pesoidealm = 21;
    int decimals = 2; // solo se muestran dos decimales
    int formula = pow(10, decimals);
    // realizamos validaciones si algun campo esta vacio
    if (my_form_key.currentState.validate()) {
      double peso = double.parse(controller_peso.text);
      double altura = double.parse(controller_talla.text);
      double rtAltura = (altura) / 100;
      double alturapordos = rtAltura * rtAltura;
      double result = peso / alturapordos;
      double d = result;
      d = (d * formula).round() / formula;
      double sugerido = (pesoidealm * peso) / d;
      sugerido = (sugerido * formula).round() / formula;
      setState(() {
        muestreImc = "IMC es: $d";
        pesoSugerido = "Peso ideal es: $sugerido kg";
      });
    }
  }

  // creamos clase para calcular peso hombre
  void PesoIdealHombre() {
    int pesoidealh = 24;
    int decimals = 2; // solo se muestran dos decimales
    int formula = pow(10, decimals);
    // realizamos validaciones si algun campo esta vacio
    if (my_form_key.currentState.validate()) {
      double peso = double.parse(controller_peso.text);
      double altura = double.parse(controller_talla.text);
      double rtAltura = (altura) / 100;
      double alturapordos = rtAltura * rtAltura;
      double result = peso / alturapordos;
      double d = result;
      d = (d * formula).round() / formula;
      double sugerido = (pesoidealh * peso) / d;
      sugerido = (sugerido * formula).round() / formula;
      setState(() {
        muestreImc = "IMC es: $d";
        pesoSugerido = "Peso ideal es: $sugerido kg";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('Calculadora IMC', style: TextStyle(color: Colors.blueAccent),),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.apps, color: Colors.green,),
            onPressed: null,
          ),
        ),
        body: Form(
          key: my_form_key,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(17.0),
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: 111,
                    decoration: BoxDecoration(
                        color: Colors.white, boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 11) ],
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80))),
                    child: Stack(
                      children: <Widget>[
                        Align( alignment: Alignment.center, child: Image(width: 280.0, height: 311.0, image: AssetImage('assets/images/a.png'),), ),
                      ],
                    )
                ), // margin: EdgeInsets.only(top:11.0),
                Container(padding: EdgeInsets.only(top: 40.0, bottom: 20.0,),
                  child: Column(
                    children: <Widget>[
                      Container(width: double.infinity, height: 50.0, padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0), color: Colors.white,
                          boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 11) ],
                        ),
                        child: TextFormField(
                          controller: controller_peso,
                          validator: (value){ if(value.isEmpty) return 'Digita el peso kg';},
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 21.0, color: Colors.black54,),
                            hintText: 'El peso kg', icon: Icon(Icons.account_balance_wallet, color: Colors.green,),
                            contentPadding: EdgeInsets.only( top: -14.0,),
                            border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none,
                          ),
                          cursorColor: Colors.green,
                          style: TextStyle(fontSize: 21.0, color: Colors.green, ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Divider(height: 22.2, ),
                      Container(width: double.infinity, height: 50.0, padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0), color: Colors.white,
                          boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 11) ],
                        ),
                        child: TextFormField(
                          controller: controller_talla,
                          validator: (value){ if(value.isEmpty) return 'Digita la estatura cm';},
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 21.0, color: Colors.black54,),
                            hintText: 'La estatura cm', icon: Icon(Icons.present_to_all, color: Colors.green,),
                            contentPadding: EdgeInsets.only( top: -14.0,),
                            border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none,
                          ),
                          cursorColor: Colors.green,
                          style: TextStyle(fontSize: 21.0, color: Colors.green, ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Divider(height: 30.0,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[



                          FlatButton( onPressed: PesoIdealMujer,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.3),),
                            color: Colors.pinkAccent,
                            padding: EdgeInsets.all(2.0),
                            child: Column(children: <Widget>[Icon(Icons.pregnant_woman,), Text('Mujer'), ],),
                          ),
                          VerticalDivider(),
                          FlatButton( onPressed: PesoIdealHombre,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.3),),
                            color: Colors.blueAccent,
                            padding: EdgeInsets.all(2.0),
                            child: Column(children: <Widget>[Icon(Icons.person ,), Text('Hombre'), ],),
                          ),
                        ],
                      ),
                      Divider(),
                      Container(height: 50.0, width: double.infinity,
                        decoration: BoxDecoration( color: Colors.white,
                          boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 11) ],
                          gradient: LinearGradient(colors: <Color>[Colors.red, Colors.blue, Colors.green,],),
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        ),
                        child: Center(
                          child: Text(muestreImc, style: TextStyle(color: Colors.white, fontSize: 21.2, ),),
                        ),
                      ),
                      Divider(),
                      Container(height: 50.0, width: double.infinity,
                        decoration: BoxDecoration( color: Colors.white,
                          boxShadow: [ BoxShadow(color: Colors.black54, blurRadius: 11) ],
                          gradient: LinearGradient(colors: <Color>[Colors.red, Colors.blue, Colors.green,],),
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        ),
                        child: Center(
                          child: Text(pesoSugerido, style: TextStyle(color: Colors.white, fontSize: 21.2, ),),
                        ),
                      ),
                      Divider(),
                      Container( padding: EdgeInsets.all(2.0),
                        child: Stack(children: <Widget>[ Align( child: Image(width: 300, height: 200, image: AssetImage('assets/images/b.png'),),),],),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

