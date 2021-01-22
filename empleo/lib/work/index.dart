import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'job.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<Job> listJob;
  var data_on = false;
  Future<void> makeRequest() async{
    listJob = List();
    String link;
    String work;
    String town;
    String date;
    String title;
    var response = await http.get('https://www.empleacantabria.es/ofertas-cantabria?p_p_id=buscadorofertas_WAR_EMPLEACANOFERTASACCIONESportlet&_buscadorofertas_WAR_EMPLEACANOFERTASACCIONESportlet_delta=9999');

    if(response.statusCode == 200){
      var document = parse(response.body);
      var elements = document.getElementsByClassName('table-data');
      var total = elements[0].children;

      for(var i = 0; i < total.length; i++){
        try{
          link = total[i].children.first.getElementsByTagName('a')[0].attributes['href'].toString();
          title = total[i].children[1].text.trim();
          work = title.toLowerCase();
          town = total[i].children[2].text.trim();
          date = total[i].children.last.text.trim();
          listJob.add(new Job(link, work, town, date, title));
        } catch(e){print('Mi error === ' + e.toString());}
      }

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
        title: Text('Empleo Cantabria', style: TextStyle(color: Colors.black),),
      ),

      body: Container(
        child: data_on ? ListView.builder(
          itemCount: listJob.length,
          itemBuilder: (context, index){
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 1.0,left: 7.0, right: 7.0),
                child: Card( elevation: 3.0,
                    child: Padding(
                      padding: EdgeInsets.all(7.1),
                      child: Column(
                        children: <Widget>[
                          Text( listJob[index].work, style: TextStyle(fontSize: 19.0),),
                          Padding(padding: EdgeInsets.all(7.0),
                            child: Text(listJob[index].date, style: TextStyle(color: Colors.lightBlueAccent,),),
                          ),
                          Text( listJob[index].town),
                        ],
                      ),
                    )
                ),
              ),

              onTap: () {
                print('url === ' + listJob[index].link);
                Navigator.push( context, MaterialPageRoute(builder: (context) => Detail(listJob[index].link, listJob[index].title)),
                );
                },
            );
            },
        ) :

        Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

}