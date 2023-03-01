import 'configurable.dart';

class TailAngle extends Configurable {
  TailAngle(super.level);

  static TailAngle fromValue(int value) {
    TailAngle ta = TailAngle(0);
    ta.level = value ~/ ta.stepValue();
    return ta;
  }

  static int maxLevel() {
    return 14;
  }

  @override
  int minValue() {
    return 90;
  }

  @override
  int stepValue() {
    return 5;
  }

  @override
  int overSteerOffset() {
    return (54 - 272) ~/ maxLevel() * level;
  }

  @override
  int breakingStabilityOffset() {
    return (354 - 245) ~/ maxLevel() * level;
  }

  @override
  int corneringPerformanceOffset() {
    return (245 - 109) ~/ maxLevel() * level;
  }

  @override
  int tractionOffset() {
    return (272 - 136) ~/ maxLevel() * level;
  }

  @override
  int straightLineSpeedOffset() {
    return (54 - 545) ~/ maxLevel() * level;
  }
}
