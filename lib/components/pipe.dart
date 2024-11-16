import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_clone/constants.dart';
import 'package:flappy_bird_clone/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame>{
  final bool isTopPipe;
  bool scored = false;
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe}) : super(
    position: position,
    size: size
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? "pipe_top.png" : "pipe_bottom.png");

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    if(!scored && position.x + size.x < gameRef.bird.x){
      scored = true;

      if(isTopPipe){
        gameRef.incrementScore();
      }
    }

    if(position.x + size.x <= 0){
      removeFromParent();
    }
  }
}