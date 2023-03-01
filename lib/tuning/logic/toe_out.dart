import 'configurable.dart';

class ToeOut extends Configurable {
  ToeOut(super.level);

  static ToeOut fromValue(int value) {
    ToeOut to = ToeOut(0);
    to.level = value ~/ to.stepValue();
    return to;
  }

  static int maxLevel() {
    return 20;
  }

  @override
  int minValue() {
    return 0;
  }

  @override
  int stepValue() {
    return 5;
  }

  @override
  int overSteerOffset() {
    return 0;
  }

  @override
  int breakingStabilityOffset() {
    return (354 - 245) ~/ maxLevel() * level;
  }

  @override
  int corneringPerformanceOffset() {
    return (82 - 109) ~/ maxLevel() * level;
  }

  @override
  int tractionOffset() {
    return 0;
  }

  @override
  int straightLineSpeedOffset() {
    return 0;
  }
}
