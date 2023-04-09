import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:firstgame/world/ground.dart';
import 'package:firstgame/world/wall.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<AmongGame> {
  Player({required super.sprite, required super.size, required super.position});
  @override
  bool get debugMode => true;
  Vector2 velocity = Vector2(0, 0);
  double currentVelocity = 1;
  bool onGround = false;
  bool facingRight = true;
  bool hitRight = false;
  bool hitLeft = false;
  Vector2 input = Vector2(0, 0);
  double currentSpeed = 0;
  double maxSpeed = 200;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(RectangleHitbox());
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkVelocity();
    gameRef.velocity.x = input.x * maxSpeed * currentVelocity;
    gameRef.velocity.y = -input.y * maxSpeed;
  }

  checkHitRight() {
    if (!input.x.isNegative) {
      currentVelocity = 0;
      return;
    }

    currentVelocity = 1;
  }

  checkHitLeft() {
    if (input.x.isNegative) {
      currentVelocity = 0;
      return;
    }

    currentVelocity = 1;
  }

  checkVelocity() {
    if (hitRight) {
      checkHitRight();
      return;
    }
    if (hitLeft) {
      checkHitLeft();
      return;
    }
    currentVelocity = 1;
  }

  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (input.x == 0) return;

    if (other is! Ground && other is! Wall) return;

    for (Vector2 point in intersectionPoints) {
      checkIsHittingObject(point);
    }
  }

  void checkIsHittingObject(Vector2 point) {
    bool hittingRight = x - (size.x / 3) < point.x;
    bool hittingLeft = x - size.x < point.x;
    if (hittingRight) {
      hitRight = true;
      hitLeft = false;
      return;
    }
    if (hittingLeft) {
      hitLeft = true;
      hitRight = false;
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
