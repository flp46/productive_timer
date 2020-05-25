import 'package:flutter/material.dart';


class StartButton extends StatelessWidget{
  
  VoidCallback onPressedStart;
  String startButtonText;

  StartButton({Key key, this.onPressedStart, this.startButtonText});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( //boton de inicio
      width: 130,
      child: RaisedButton(
        onPressed: onPressedStart,
        padding: EdgeInsets.all(0.0),
        color: Color(0xFF40405c),
        child:Container(
          decoration: BoxDecoration(
            color:Color(0xFF40405c)
          ),
          child: Text(
            startButtonText,
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