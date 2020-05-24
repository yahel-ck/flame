import 'dart:math';
import '../components/component.dart';

export './move_effect.dart';
export './scale_effect.dart';
export './rotate_effect.dart';
export './sequence_effect.dart';

abstract class PositionComponentEffect {
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  /// If the animation should first follow the initial curve and then follow the
  /// curve backwards
  bool isAlternating;
  bool isInfinite;
  double percentage;
  double travelTime;
  double currentTime = 0.0;
  double driftTime = 0.0;
  int curveDirection = 1;

  PositionComponentEffect(this.isInfinite, this.isAlternating);

  void update(double dt) {
    currentTime += dt * curveDirection;
    if (hasFinished() && !isDisposed) {
      driftTime = isAlternating ? currentTime.abs() : currentTime - travelTime;
    }

    if (isAlternating) {
      curveDirection = isMax() ? -1 : (isMin() ? 1 : curveDirection);
    } else if (isInfinite && isMax()) {
      currentTime = 0.0;
    }
    percentage = min(1.0, max(0.0, currentTime / travelTime));
  }

  void dispose() => _isDisposed = true;

  PositionComponent component;

  bool hasFinished() =>
      (!isInfinite && !isAlternating && isMax()) ||
      (!isInfinite && isAlternating && isMin()) ||
      isDisposed;
  bool isMax() => percentage == null ? false : percentage == 1.0;
  bool isMin() => percentage == null ? false : percentage == 0.0;

  void reset() {
    _isDisposed = false;
    percentage = null;
    currentTime = 0.0;
    curveDirection = 1;
  }
}
