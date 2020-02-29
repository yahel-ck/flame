import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

void main() {
  final game = MyGame();
  runApp(game.widget);
}

class MyGame extends Game with TapDetector {
  final _whitePaint = Paint()..color = const Color(0xFFFFFFFF);

  Paint _paint;

  List<Rect> _taps = [];

  MyGame() {
    _paint = _whitePaint;
  }

  @override
  void onTapDown(TapDownDetails details) {
    _taps.add(Rect.fromLTWH(
            details.globalPosition.dx,
            details.globalPosition.dy,
            50,
            50)
    );
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    _taps.forEach((rect) {
      canvas.drawRect(rect, _paint);
    });
  }
}
