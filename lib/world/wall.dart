import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Wall extends SpriteComponent
    with CollisionCallbacks, HasGameRef<AmongGame> {
  Wall({
    required super.sprite,
    required super.size,
    required super.position,
  });
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
    add(RectangleHitbox());
  }
}
