import 'package:flutter/material.dart';

class StopButton extends StatelessWidget{
  
  VoidCallback onPressedStop;
  String stopButtonText;

  StopButton({Key key, this.onPressedStop, this.stopButtonText});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( //boton de finalizacion
      width: 130,
      margin: EdgeInsets.all(10),
      child:RaisedButton(
        onPressed: onPressedStop,
        padding: EdgeInsets.all(0.0),
        color: Color(0xFF40405c),
        child: Container(
          decoration: BoxDecoration(
            color:Color(0xFF40405c)
          ),
          child: Text(
            stopButtonText,
            style: TextStyle(
              color: Color(0xFFe5e3e4),
              fontSize: 18,
            ),
          ),
        )
      ),
    );
  }
}