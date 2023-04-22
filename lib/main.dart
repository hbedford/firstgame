import 'dart:async';

import 'package:firstgame/actors/player.dart';
import 'package:firstgame/player_movement.dart';
import 'package:firstgame/world/ground.dart';
import 'package:firstgame/world/new_world.dart';
import 'package:firstgame/world/wall.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: AmongGame2()));
}

class AmongGame2 extends Forge2DGame
    with KeyboardEvents, HasCollisionDetection {
  AmongGame2() : super(gravity: Vector2(0, 0), zoom: 1);
  late Player player;
  late Ground ground;
  late Wall wall;
  late Wall wall2;
  late NewWorld newWorld;

  Vector2 velocity = Vector2.zero();

  Vector2 position = Vector2(0, 0);
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    debugMode = true;

    ground = Ground(
      sprite: await loadSprite('firstground.png'),
      size: Vector2(256, 256),
      position: Vector2(50, 50),
    );

    wall = Wall(
      sprite: await loadSprite('wall.png'),
      size: Vector2(50, 200),
      position: Vector2(50, 100),
    );
    wall2 = Wall(
      sprite: await loadSprite('wall.png'),
      size: Vector2(200, 50),
      position: Vector2(size.x / 3, size.y - 260),
    );
    player = Player(
      sprite: await loadSprite(
        'player.png',
        srcPosition: Vector2(1, 50),
      ),
      size: Vector2(50, 50),
      position: Vector2(3229.0077280651058, 2942.0613264991603),
    );
    newWorld = NewWorld(
      sprite: await loadSprite(
        'map.png',
      ),
      size: Vector2(1920 * 1.0, 1080 * 1.0),
      position: Vector2(0, 0),
    );

    add(newWorld);
    add(ground);
    add(wall);
    add(wall2);
    add(player);
  }

  static LogicalKeyboardKey leftKey = LogicalKeyboardKey.arrowLeft;
  static LogicalKeyboardKey rightKey = LogicalKeyboardKey.arrowRight;
  static LogicalKeyboardKey upKey = LogicalKeyboardKey.arrowUp;
  static LogicalKeyboardKey downKey = LogicalKeyboardKey.arrowDown;
  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    Vector2 input = Vector2(0, 0);
    if (keysPressed.contains(leftKey) && !keysPressed.contains(rightKey)) {
      input.x = -1;
    } else if (keysPressed.contains(rightKey) &&
        !keysPressed.contains(leftKey)) {
      input.x = 1;
    } else {
      input.x = 0;
    }
    if (keysPressed.contains(upKey) && !keysPressed.contains(downKey)) {
      input.y = 1;
    } else if (keysPressed.contains(downKey) && !keysPressed.contains(upKey)) {
      input.y = -1;
    } else {
      input.y = 0;
    }
    player.input = input;

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.checkMovement(velocity * 100 * dt);
    camera.zoom = 1;
  }
}
