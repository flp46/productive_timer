import 'package:flutter/material.dart';
import 'dart:async';


class ProductiveTime extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return ProductiveTimeState();
  }  
}

class ProductiveTimeState extends State<ProductiveTime>{
  
  static int minutos = 2;
  static int segundos = 10;
  static int segundoStandart = 1;
  final snackbarProductivo = SnackBar(content: Text('Terminamos el tiempo productivo'));

  static Duration tiempoProductivo = Duration(minutes: minutos, seconds: segundos);
  static Duration segundosARestar = Duration(seconds: 1);
  int tiempoRestante = tiempoProductivo.inSeconds;


  Timer timer;

  // Muestra el snackbar que se levanta al terminar el tiempo productivo
  showMessage(){
    Scaffold.of(context).showSnackBar(snackbarProductivo);
  }

  // Este metodo va a controlar los minutos y segundos que se muestran en pantalla
  showTime(){
    setState(() {
      tiempoRestante = tiempoRestante - 1;

      segundos = segundos - 1;

      //segundos en pantalla
      if (segundos < 0){
        segundos = 59;
      }

      //minutos en pantalla
      if (tiempoRestante % 60 == 0){
        if (minutos > 0){
          minutos = (tiempoRestante / 60).round() -1;
          print(minutos);  
        }
      }
    });

  }

  // Es el callback que actualiza el estado cada segundo que va pasando
  updateTime(){
    Timer.periodic(segundosARestar, (Timer timer){
      if (tiempoRestante >= 1){
        showTime();
      } else {
        showMessage();
        timer.cancel();
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:Column(
        children: <Widget>[
          FloatingActionButton(onPressed: updateTime),
          Text(minutos.toString()),
          Text(segundos.toString())
        ] 
      ) 
    );
  }
}

