import 'dart:async';
import 'dart:ui';

import 'package:firstgame/main.dart';
import 'package:firstgame/world/ground.dart';
import 'package:firstgame/world/wall.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player extends BodyComponent<AmongGame2> {
  final Sprite sprite;
  final Vector2 size;
  final Vector2 position;
  Player({
    required this.sprite,
    required this.size,
    required this.position,
  });
  @override
  bool get debugMode => true;
  Vector2 velocity = Vector2(0, 0);
  double currentVelocityY = 1;
  double currentVelocityX = 1;
  bool facingRight = true;
  bool hitRight = false;
  bool hitLeft = false;
  bool hitTop = false;
  bool hitBottom = false;
  Vector2 input = Vector2(0, 0);
  double currentSpeed = 0;
  double maxSpeed = 200;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    add(SpriteComponent(sprite: sprite, size: size, anchor: Anchor.center));
  }

  @override
  void update(double dt) {
    super.update(dt);

    checkVelocity();
    gameRef.velocity.x = input.x * maxSpeed * currentVelocityX;
    gameRef.velocity.y = -input.y * maxSpeed * currentVelocityY;
  }

  @override
  void render(Canvas canvas) {}

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;
    final body = world.createBody(bodyDef);
    final shape = PolygonShape();

    shape.setAsBoxXY(size.x / 2, size.y / 2);

    final fixtureDef = FixtureDef(shape)
      ..density = 0.0
      ..restitution = 0.0;
    body.createFixture(fixtureDef);
    return body;
  }

  checkHitRight() {
    if (!input.x.isNegative) {
      currentVelocityX = 0;
      return;
    }

    currentVelocityX = 1;
  }

  checkHitLeft() {
    if (input.x.isNegative) {
      currentVelocityX = 0;
      return;
    }

    currentVelocityX = 1;
  }

  checkHitTop() {
    if (input.y.isNegative) {
      currentVelocityY = 0;
      return;
    }

    currentVelocityY = 1;
  }

  checkHitBottom() {
    if (!input.y.isNegative) {
      currentVelocityY = 0;
      return;
    }

    currentVelocityY = 1;
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
    if (hitTop) {
      checkHitTop();
      return;
    }
    if (hitBottom) {
      checkHitBottom();
      return;
    }

    currentVelocityX = 1;
  }

  // @override
  // void onCollisionStart(intersectionPoints, other) {
  //   super.onCollisionStart(intersectionPoints, other);
  //   if (input.x == 0 && input.y == 0) return;
  //
  //   if (other is! Ground && other is! Wall) return;
  //   bool isSideCollision =
  //       intersectionPoints.first.x == intersectionPoints.last.x;
  //   for (Vector2 point in intersectionPoints) {
  //     checkIsHittingObject(point, isSideCollision: isSideCollision);
  //   }
  // }
  //
  // void checkIsHittingObject(Vector2 point, {required bool isSideCollision}) {
  //   debugPrint("x: $x, y: $y size.x: ${size.x}, size.y: ${size.y}");
  //
  //   bool hittingRight = x - (size.x / 3) < point.x;
  //   bool hittingLeft = x - size.x < point.x;
  //   bool hittingTop = y < point.y;
  //   bool hittingBottom = y - size.y < point.y;
  //   if (hittingRight && isSideCollision) {
  //     debugPrint("Hitting Right");
  //     hitRight = true;
  //     hitLeft = false;
  //     return;
  //   }
  //   if (hittingLeft && isSideCollision) {
  //     debugPrint("Hitting Left");
  //     hitLeft = true;
  //     hitRight = false;
  //
  //     return;
  //   }
  //   if (hittingTop) {
  //     debugPrint("Hitting Top");
  //     hitTop = true;
  //     hitBottom = false;
  //     return;
  //   }
  //   if (hittingBottom) {
  //     debugPrint("Hitting Bottom");
  //     hitBottom = true;
  //     hitTop = false;
  //     return;
  //   }
  // }
  //
  // @override
  // void onCollisionEnd(other) {
  //   super.onCollisionEnd(other);
  //   hitLeft = false;
  //   hitRight = false;
  //   hitTop = false;
  //   hitBottom = false;
  // }

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
