import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_clone/components/ground.dart';
import 'package:flappy_bird_clone/components/pipe.dart';
import 'package:flappy_bird_clone/constants.dart';
import 'package:flappy_bird_clone/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks{
  // Initialize bird position & size
  Bird() : super(
    position: Vector2(birdStartX, birdStartY),
    size: Vector2(birdWidth, birdHeight)
  );

  // physical world properties
  double velocity = 0;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bird.png');

    add(RectangleHitbox());
  }

  void flap(){
    velocity = jumpStrength;
  }

  // update -> every second
  @override
  void update(double dt) {
    // apply gravity
    velocity += gravity * dt;

    // update bird's position based on current velocity
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(other is Ground){
      (parent as FlappyBirdGame).gameOver();
    }

    if(other is Pipe){
      (parent as FlappyBirdGame).gameOver();
    }
  }
}