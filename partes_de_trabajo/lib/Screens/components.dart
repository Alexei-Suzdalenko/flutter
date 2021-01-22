import 'package:flutter/material.dart';



class DoubleImage extends StatelessWidget {
  var width;
  DoubleImage(width){
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 160,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -40,
            height: 170,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
          Positioned(
            height: 140,
            width: width+20,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background-2.png'),
                      fit: BoxFit.fill
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}


class Works{
  String id;
  String name;
  int    hours;
  String price;
  String adress;
  String createdfor;
  Works(this.id, this.name, this.hours, this.price, this.adress, this.createdfor);
}
