import 'configurable.dart';

class FrontAngle extends Configurable {
  FrontAngle(super.level);

  static FrontAngle fromValue(int value) {
    FrontAngle fa = FrontAngle(0);
    fa.level = (value / fa.stepValue()) as int;
    return fa;
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
    return (490 - 272) ~/ maxLevel() * level;
  }

  @override
  int breakingStabilityOffset() {
    return (136 - 245) ~/ maxLevel() * level;
  }

  @override
  int corneringPerformanceOffset() {
    return (272 - 109) ~/ maxLevel() * level;
  }

  @override
  int tractionOffset() {
    return (54 - 136) ~/ maxLevel() * level;
  }

  @override
  int straightLineSpeedOffset() {
    return (490 - 545) ~/ maxLevel() * level;
  }
}
