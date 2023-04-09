// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() => runApp(
//       GameWidget(
//         game: GameScreen(),
//       ),
//     );
//
// class GameScreen extends FlameGame
//     with HasKeyboardHandlerComponents, HasCollisionDetection {
//   static Floor floor = Floor()
//     ..height = 200
//     ..width = 200;
//
//   static Floor floor2 = Floor()
//     ..height = 200
//     ..width = 200
//     ..position = Vector2(100, 200);
//
//   static Wall wall = Wall()
//     ..width = 100
//     ..height = 2
//     ..position = Vector2(0, 200);
//   static Wall wall2 = Wall()
//     ..width = 2
//     ..height = 200
//     ..position = Vector2(100, 200);
//
//   static Player player = Player()
//     ..width = 50
//     ..height = 50;
//
//   @override
//   Future<void> onLoad() async {
//     add(floor);
//     add(floor2);
//     add(player);
//     add(wall);
//     add(wall2);
//   }
// }
//
// class Player extends PositionComponent
//     with KeyboardHandler, CollisionCallbacks, HasGameRef<GameScreen> {
//   static final _paint = Paint()..color = Colors.red;
//
//   static LogicalKeyboardKey leftKey = LogicalKeyboardKey.arrowLeft;
//   static LogicalKeyboardKey rightKey = LogicalKeyboardKey.arrowRight;
//   static LogicalKeyboardKey upKey = LogicalKeyboardKey.arrowUp;
//   static LogicalKeyboardKey downKey = LogicalKeyboardKey.arrowDown;
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(size.toRect(), _paint);
//     add(RectangleHitbox()..collisionType = CollisionType.active);
//   }
//
//   @override
//   bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//     if (event is RawKeyDownEvent) {
//       checkMove(keysPressed);
//     }
//     return true;
//   }
//   //
//   // @override
//   // KeyEventResult onKeyEvent(
//   //   RawKeyEvent event,
//   //   Set<LogicalKeyboardKey> keysPressed,
//   // ) {
//   //   final isKeyDown = event is RawKeyDownEvent;
//   //
//   //   final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
//   //
//   //   if (isSpace && isKeyDown) {
//   //     checkMove(keysPressed);
//   //     return KeyEventResult.handled;
//   //   }
//   //   return KeyEventResult.ignored;
//   // }
//
//   checkMove(Set<LogicalKeyboardKey> keysPressed) {
//     if (keysPressed.contains(leftKey) ||
//         keysPressed.contains(rightKey) ||
//         keysPressed.contains(upKey) ||
//         keysPressed.contains(downKey)) {
//       checkMoveRight(keysPressed);
//       checkMoveLeft(keysPressed);
//       checkMoveUp(keysPressed);
//       checkMoveDown(keysPressed);
//     } else {}
//   }
//
//   checkMoveRight(Set<LogicalKeyboardKey> keysPressed) {
//     if (keysPressed.contains(rightKey)) {
//       position.add(Vector2(10, 0));
//     }
//   }
//
//   checkMoveLeft(Set<LogicalKeyboardKey> keysPressed) {
//     if (keysPressed.contains(leftKey)) position.add(Vector2(-10, 0));
//   }
//
//   checkMoveUp(Set<LogicalKeyboardKey> keysPressed) {
//     if (keysPressed.contains(upKey)) position.add(Vector2(0, -10));
//   }
//
//   checkMoveDown(Set<LogicalKeyboardKey> keysPressed) {
//     if (keysPressed.contains(downKey)) position.add(Vector2(0, 10));
//   }
//
//   @override
//   void onCollisionStart(Set<Vector2> points, PositionComponent other) {
//     super.onCollisionStart(points, other);
//     if (other is Wall) {}
//   }
// }
//
// class Floor extends PositionComponent with CollisionCallbacks {
//   static final _paint = Paint()..color = Colors.white;
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(size.toRect(), _paint);
//   }
// }
//
// class Wall extends PositionComponent
//     with CollisionCallbacks, HasGameRef<GameScreen> {
//   static final _paint = Paint()..color = Colors.red;
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(size.toRect(), _paint);
//     add(RectangleHitbox()..collisionType = CollisionType.active);
//   }
// }
