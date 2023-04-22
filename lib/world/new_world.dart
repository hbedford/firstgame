import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:flame/components.dart';

class NewWorld extends SpriteComponent with HasGameRef<AmongGame2> {
  NewWorld({
    required super.sprite,
    required super.size,
    required super.position,
  });
  double get scaleX => 1000 * 7;
  double get scaleY => 1000 * 7;
  double get positionSize => 0.0007;
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position = Vector2(0, 0);
    size = Vector2(scaleX, scaleY);
  }
}
