import 'package:first_game_flutter/game_controller.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  Util flameUtil =Util();
  SharedPreferences storage = await SharedPreferences.getInstance();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  final size = await flameUtil.initialDimensions();
   
  GameController gameController = GameController(storage,size);
  runApp(gameController.widget);

  TapGestureRecognizer recognizer = TapGestureRecognizer();
  recognizer.onTapDown = gameController.onTapDown;
  flameUtil.addGestureRecognizer(recognizer);
}