import 'package:flame/components.dart';
import 'package:flappy_bird_clone/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame>{
  ScoreText() : super(
    text: '0',
    textRenderer: TextPaint(
      style: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 48,
      )
    )
  );

  @override
  Future<void> onLoad() async{
    position = Vector2((gameRef.size.x - size.x) / 2, (gameRef.size.y - size.y) / 2);
  }

  @override
  void update(double dt){
    final newText = gameRef.score.toString();
    if(text != newText){
      text = newText;
    }
  }
}