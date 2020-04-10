import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class ProductiveTime extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return ProductiveTimeState();
  }  
}

class ProductiveTimeState extends State<ProductiveTime>{
  
  static int minutos = 0;
  static int segundos = 10;
  static int segundoStandart = 1;
  final snackbarProductivo = SnackBar(content: Text('Terminamos el tiempo productivo'));

  static Duration tiempoProductivo = Duration(minutes: minutos, seconds: segundos);
  static Duration segundosARestar = Duration(seconds: 1);
  int tiempoRestante = tiempoProductivo.inSeconds;

  static AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);

  Timer timer;

  // Muestra el snackbar que se levanta al terminar el tiempo productivo
  showMessage(){
    Scaffold.of(context).showSnackBar(snackbarProductivo);
  }

  playMusica() async {
    var soundBegin = await audioCache.play('musica/notGivingUp.mp3');
  }

  stopMusica() async {
    var soundStop = await audioPlayer.stop();
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

  //CONTROLADORES PARA QUE EL TEXTO DE LOS BOTONES VAYA CAMBIANDO
  String startButton = 'Start';
  bool controlStartButton = true;
  String stopButton = 'Stop';
  int controlStopButton = -1;  
  textInButtonsStart(){
    setState(() {
      if (controlStartButton == true){
        startButton = 'Continue';
      } else {
        startButton = 'Start';
      }
    });
  }

  //CONTROLADOR PARA LOS CAMBIOS EN EL BOTON DE STOP
  textInButtonStop(){
    setState(() {
      if (controlStopButton % 2 == 0){
        stopButton = 'Stop';
      } else {
        stopButton = 'Restart';
      }      
    });
  }

  //VUELVE A EMPEZAR EL TIMER CON LOS VALORES ORIGINALES
  restartTimer(){
    setState(() {
      tiempoRestante = tiempoProductivo.inSeconds;
      minutos = 0;
      segundos = 10;
      startButton = 'Start';
    });
  }

  //PAUSA EL TIEMPO
  cancelTimer(){
    if (stopButton == 'Restart'){
      restartTimer();
    } else {
      timer.cancel();
      textInButtonsStart();
      controlStopButton++;
      textInButtonStop();
    }

  }

  // Es el callback que actualiza el estado cada segundo que va pasando
  updateTime(){
    controlStopButton++; //Al darle continue, necesito que tambien se actualice el boton de restart y pase a stop
    textInButtonStop(); //reconstruyo el build
    timer = Timer.periodic(segundosARestar, (Timer timer){
      if (tiempoRestante >= 1){
        showTime();
      } else {
        textInButtonsStart();
        showMessage();
        playMusica();
        cancelTimer();
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:Column(
        children: <Widget>[
          RaisedButton(
            onPressed: updateTime,
            child: Text(
              startButton
            ),
          ),
          Text(minutos.toString()),
          Text(segundos.toString()),
          RaisedButton(
            onPressed: cancelTimer,
            child: Text(
              stopButton
            ),
          ),
          RaisedButton(onPressed: playMusica),
          FloatingActionButton(onPressed: stopMusica)
        ] 
      ) 
    );
  }
}

