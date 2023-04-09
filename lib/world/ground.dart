import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Ground extends SpriteComponent
    with CollisionCallbacks, HasGameRef<AmongGame> {
  Ground({
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
