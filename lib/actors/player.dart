import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends PositionComponent
    with CollisionCallbacks, HasGameRef<AmongGame> {
  @override
  bool get debugMode => true;
  Vector2 velocity = Vector2(0, 0);
  bool onGround = false;
  bool facingRight = true;
  bool hitRight = false;
  bool hitLeft = false;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameRef.velocity = velocity;
  }

  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Floor) {
      if (gameRef.velocity.y > 0) {
        if (intersectionPoints.length == 2) {
          var x1 = intersectionPoints.first[0];
          var x2 = intersectionPoints.last[0];
          if ((x1 - x2).abs() < 10) {
            // hit the side, so send down with gravity.
            gameRef.velocity.y = 100;
            print('stuck on side');
          } else {
            // hit ground
            gameRef.velocity.y = 0;
            onGround = true;
          }
        }
      }
      if (gameRef.velocity.x != 0) {
        for (var point in intersectionPoints) {
          if (y - 5 >= point[1]) {
            print('hit on side of ground');
            print('the bottom of the girl is $y');
            print('one of the y intersection points is ${point[1]}');
            print('note that ${point[1]} is much higher than $y}');
            gameRef.velocity.x = 0;
            if (point[0] > x) {
              // print('hit right');
              hitRight = true;
              hitLeft = false;
            } else {
              // print('hit left');
              hitLeft = true;
              hitRight = false;
            }
          }
        }
      }
    }
  }

  @override
  void onCollisionEnd(other) {
    super.onCollisionEnd(other);
    onGround = false;
    hitLeft = false;
    hitRight = false;
  }

//
// static LogicalKeyboardKey leftKey = LogicalKeyboardKey.arrowLeft;
// static LogicalKeyboardKey rightKey = LogicalKeyboardKey.arrowRight;
// static LogicalKeyboardKey upKey = LogicalKeyboardKey.arrowUp;
// static LogicalKeyboardKey downKey = LogicalKeyboardKey.arrowDown;

// @override
// void render(Canvas canvas) {
//   super.render(canvas);
//   canvas.drawRect(size.toRect(), _paint);
//   add(RectangleHitbox()..collisionType = CollisionType.active);
// }

// @override
// bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//   if (event is RawKeyDownEvent) {
//     checkMove(keysPressed);
//   }
//   return true;
// }
//
// @override
// KeyEventResult onKeyEvent(
//   RawKeyEvent event,
//   Set<LogicalKeyboardKey> keysPressed,
// ) {
//   final isKeyDown = event is RawKeyDownEvent;
//
//   final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
//
//   if (isSpace && isKeyDown) {
//     checkMove(keysPressed);
//     return KeyEventResult.handled;
//   }
//   return KeyEventResult.ignored;
// }
}
