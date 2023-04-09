import 'dart:async';

import 'package:firstgame/player_movement.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(GameWidget(game: AmongGame()));
}

class AmongGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection, Collision {
  SpriteComponent player = SpriteComponent(size: Vector2(20, 20));

  SpriteComponent wall =
      SpriteComponent(size: Vector2(1000, 50), position: Vector2(0, 0));
  SpriteComponent ground = SpriteComponent(
    size: Vector2(1, 1),
    position: Vector2(0, 0),
  );
  Vector2 velocity = Vector2.zero();
  // static Player player = Player()
  //   ..width = 50
  //   ..height = 50;

  static Floor floor = Floor(size: Vector2(200, 200), position: Vector2(0, 0));

  // static Floor floor2 = Floor()
  //   ..height = 200
  //   ..width = 200
  //   ..position = Vector2(100, 200);

  Vector2 position = Vector2(0, 0);
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    // add(ground);
    // ground..sprite = await loadSprite('ground.png');

    // add(floor);
    // add(floor2);
    // add(wall);
    // add(wall2);
    add(player);
    add(wall);
    player..sprite = await loadSprite('player.png');
    wall..sprite = await loadSprite('wall.png');
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    PlayerMovement.checkMove(keysPressed, position, velocity);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.position.add(velocity * dt);
  }
}

class Floor extends PositionComponent with CollisionCallbacks {
  Floor({required super.size, required super.position});
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(RectangleHitbox());
  }

  // static final _paint = Paint()..color = Colors.white;
  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawRect(size.toRect(), _paint);
  // }
}

class Wall extends PositionComponent
    with CollisionCallbacks, HasGameRef<AmongGame> {
  static final _paint = Paint()..color = Colors.red;
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }
}
