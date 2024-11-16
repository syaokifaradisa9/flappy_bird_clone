import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_clone/components/bird.dart';
import 'package:flappy_bird_clone/components/background.dart';
import 'package:flappy_bird_clone/components/ground.dart';
import 'package:flappy_bird_clone/components/pipe.dart';
import 'package:flappy_bird_clone/components/pipe_manager.dart';
import 'package:flappy_bird_clone/components/score.dart';
import 'package:flappy_bird_clone/constants.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection{
  late Background background;
  late Bird bird;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  Future<void> onLoad() async {
    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
  }

  int score = 0;
  void incrementScore(){
    score += 1;
  }

  bool isGameOver = false;
  void gameOver(){
    if(isGameOver) return;

    isGameOver = true;
    pauseEngine();
    
    showDialog(
        context: buildContext!,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Game Over"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);

              resetGame();
            }, child: Text("restart"))
          ],
        )
    );
  }

  void resetGame(){
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}