import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


class Wall extends BodyComponent {
  Wall(this.position, this.size);
  @override
  final Vector2 position;
  final Vector2 size;

  @override
  Body createBody() {
    final shape = PolygonShape()
      ..setAsBox(
        size.x / 2,
        size.y / 2,
        Vector2(size.x / 2, size.y / 2),
        0,
      );

    final fixtureDef = FixtureDef(
      shape,
      friction: 0.5,
      restitution: 0.1,
    );

    final bodyDef = BodyDef(
      position: position + Vector2(size.x / 2, size.y / 2),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  // 色をつけると壁の配置がおかしく見えたのでコメントアウト
  @override
  void render(Canvas canvas) {
    // final paint = Paint()..color = Colors.blue;
    // final center = body.position.toOffset();
    // canvas.drawRect(
    //   Rect.fromCenter(center: center, width: size.x, height: size.y),
    //   paint,
    // );
  }
}

class Ball extends BodyComponent {
  Ball({required this.pos});

  final Vector2 pos;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 10;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      friction: 0.4,
    );

    final bodyDef = BodyDef(
      userData: this,
      position: pos,
      type: BodyType.dynamic,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    super.renderCircle(canvas, center, radius);

    canvas.drawLine(
      center,
      center + Offset(0, radius),
      BasicPalette.black.paint(),
    );
  }
}

class PhysicsGame extends Forge2DGame with TapCallbacks {
  Ball? ball;
  Timer? _timer;
  double accelX = 0;
  double accelY = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final viewWidth = size.x;
    final viewHeight = size.y - kBottomNavigationBarHeight - kToolbarHeight;

    ball = Ball(pos: Vector2(size.x / 2, size.y / 2));
    add(ball!);

    accelerometerEventStream().listen((AccelerometerEvent event) {
      accelX = event.x;
      accelY = event.y;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 16), (Timer timer) {
      if (ball != null) {
        ball!.body.applyForce(Vector2(-accelX * 1000, accelY * 1000));
      }
    });

    // 壁を追加
    // 設定うまくいっていない
    add(Wall(Vector2(-(viewWidth / 4), 0), Vector2(viewWidth, 10))); // 上
    add(Wall(Vector2(-(viewWidth / 4), viewHeight - 10),
        Vector2(viewWidth, 10),),); // 下
    add(Wall(Vector2(0, -(viewHeight / 4)), Vector2(10, viewHeight))); // 左
    add(Wall(Vector2(viewWidth - 10, -(viewHeight / 4)),
        Vector2(10, viewHeight),),); // 右

    // await world.add(
    //   Wall(pos: rect.bottomLeft.toVector2(), size: Vector2(viewWidth, 1)),
    // );
    // await world.add(
    //   Wall(pos: rect.topLeft.toVector2(), size: Vector2(1, viewHeight)),
    // );
    // await world.add(
    //   Wall(pos: rect.topRight.toVector2(), size: Vector2(1, viewHeight)),
    // );
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   super.onTapDown(event);

  //   world.add(
  //     Ball(pos: screenToWorld(event.localPosition)),
  //   );
  // }

  @override
  void onRemove() {
    _timer?.cancel();
    super.onRemove();
  }
}

class Forge2dPage extends StatelessWidget {
  const Forge2dPage({super.key});

  static const String name = 'forge2d';
  static const String path = '/forge2d';

  @override
  Widget build(BuildContext context) {
    return const GameWidget.controlled(gameFactory: PhysicsGame.new);
  }
}
