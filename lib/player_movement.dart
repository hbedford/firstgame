import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class PlayerMovement {
  PlayerMovement._();
  static LogicalKeyboardKey leftKey = LogicalKeyboardKey.arrowLeft;
  static LogicalKeyboardKey rightKey = LogicalKeyboardKey.arrowRight;
  static LogicalKeyboardKey upKey = LogicalKeyboardKey.arrowUp;
  static LogicalKeyboardKey downKey = LogicalKeyboardKey.arrowDown;

  static double maxSpeed = 100;

  static checkMove(
      Set<LogicalKeyboardKey> keysPressed, Vector2 position, Vector2 velocity) {
    checkMovementHorizontal(keysPressed, velocity);
    checkMovementVertical(keysPressed, velocity);
  }

  static checkMovementHorizontal(
      Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(rightKey) || keysPressed.contains(leftKey)) {
      checkMoveRight(keysPressed, velocity);
      checkMoveLeft(keysPressed, velocity);
      return;
    }
    if (velocity.x != 0) velocity.x = 0;
  }

  static checkMovementVertical(
      Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(upKey) || keysPressed.contains(downKey)) {
      checkMoveUp(keysPressed, velocity);
      checkMoveDown(keysPressed, velocity);
      return;
    }
    if (velocity.y != 0) velocity.y = 0;
  }

  static checkMoveRight(Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(rightKey)) {
      velocity.x = maxSpeed;
    }
  }

  static checkMoveLeft(Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(leftKey)) velocity.x = -maxSpeed;
  }

  static checkMoveUp(Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(upKey)) velocity.y = -maxSpeed;
  }

  static checkMoveDown(Set<LogicalKeyboardKey> keysPressed, Vector2 velocity) {
    if (keysPressed.contains(downKey)) velocity.y = maxSpeed;
  }
}
