import 'package:firstgame/main.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
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
    await super.onLoad();
    renderBody = false;
    add(SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.center,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    gameRef.velocity.x = input.x * maxSpeed * currentVelocityX;
    gameRef.velocity.y = -input.y * maxSpeed * currentVelocityY;
  }

  checkMovement(Vector2 newVelocity) {
    body.applyLinearImpulse(newVelocity);
    body.applyForce(newVelocity);
    // position.add(velocity);
    // body.setTransform(position, 0);
    //
    // body.angularVelocity = 0.0;
    // body.linearVelocity = Vector2.zero();
    // body.setTransform(velocity, 0);
    // if (input.x == 0) {
    //   newVelocity.x = -(body.force.x);
    // }
    // if (input.y == 0) {
    //   newVelocity.y = -(body.force.y);
    // }
  }

  @override
  void render(Canvas canvas) {}

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
      userData: this,
      gravityOverride: Vector2.zero(),
      linearDamping: 10.0,
    );
    final body = world.createBody(bodyDef);

    final shape = CircleShape();

    shape.radius = size.x / 2;

    final fixtureDef = FixtureDef(shape)..restitution = 1.0;

    body.createFixture(fixtureDef);
    setColor(Colors.transparent);
    return body;
  }
}
