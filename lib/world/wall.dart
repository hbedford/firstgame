import 'dart:async';

import 'package:firstgame/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Wall extends BodyComponent<AmongGame2> with CollisionCallbacks {
  final Sprite sprite;
  final Vector2 size;
  final Vector2 position;
  Wall({
    required this.sprite,
    required this.size,
    required this.position,
  });
  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    add(SpriteComponent(sprite: sprite, size: size, anchor: Anchor.center));
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.static;
    final body = world.createBody(bodyDef);
    final shape = PolygonShape();
    shape.setAsBoxXY(size.x / 2, size.y / 2);
    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..friction = 0.0;
    return body..createFixture(fixtureDef);
  }
}
