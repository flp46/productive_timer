import 'package:flutter/material.dart';
import 'dart:async';


class ProductiveTime extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return ProductiveTimeState();
  }  
}

class ProductiveTimeState extends State<ProductiveTime>{
  
  static int minutos = 0;
  static int segundos = 10;
  final snackbarProductivo = SnackBar(content: Text('Terminamos el tiempo productivo'));

  static Duration tiempoProductivo = Duration(minutes: minutos, seconds: segundos);

  Timer timer;

  startTimer(){
    return Timer(tiempoProductivo, (){
      showMessage();
    });
  }

  showMessage(){
    Scaffold.of(context).showSnackBar(snackbarProductivo);
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FloatingActionButton(onPressed: startTimer)
    );
  }


}

