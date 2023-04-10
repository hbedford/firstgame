import 'dart:async';

import 'package:firstgame/actors/player.dart';
import 'package:firstgame/player_movement.dart';
import 'package:firstgame/world/ground.dart';
import 'package:firstgame/world/wall.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: AmongGame()));
}

class AmongGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late Player player;
  late Ground ground;
  late Wall wall;
  late Wall wall2;

  Vector2 velocity = Vector2.zero();

  Vector2 position = Vector2(0, 0);
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    debugMode = true;

    ground = Ground(
      sprite: await loadSprite('ground.png'),
      size: Vector2(2000, 50),
      position: Vector2(0, size.y - 50),
    );

    wall = Wall(
      sprite: await loadSprite('wall.png'),
      size: Vector2(50, 200),
      position: Vector2(size.x / 2, size.y - 260),
    );
    wall2 = Wall(
      sprite: await loadSprite('wall.png'),
      size: Vector2(200, 50),
      position: Vector2(size.x / 3, size.y - 260),
    );
    player = Player(
      sprite: await loadSprite(
        'player.png',
        srcPosition: Vector2(50, 50),
      ),
      size: Vector2(100, 100),
      position: Vector2(200, 400),
    );
    player.anchor = Anchor.center;
    add(ground);
    add(wall);
    add(wall2);
    add(player);
    camera.followComponent(player);
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

    // PlayerMovement.checkMove(keysPressed, position, player.velocity);
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.position.add(velocity * dt);
  }
}
