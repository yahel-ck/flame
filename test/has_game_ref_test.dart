import 'dart:ui';

import 'package:test/test.dart';

import 'package:flame/game.dart';
import 'package:flame/components/component.dart';

class MyGame extends BaseGame {
  bool calledFoo = false;
  void foo() {
    calledFoo = true;
  }
}

class MyComponent extends PositionComponent<MyGame> {
  @override
  void update(double dt) {}

  @override
  void render(Canvas c) {}

  void foo() {
    gameRef.foo();
  }
}

void main() {
  group('has game ref test', () {
    test('simple test', () {
      final MyComponent c = MyComponent();
      final MyGame game = MyGame();
      game.add(c);
      c.foo();
      expect(game.calledFoo, true);
    });
  });
}
