import 'configurable.dart';

class TireCamber extends Configurable {
  TireCamber(super.level);

  static TireCamber fromValue(int value) {
    TireCamber tc = TireCamber(0);
    tc.level = value ~/ tc.stepValue();
    return tc;
  }

  static int maxLevel() {
    return 16;
  }

  @override
  int minValue() {
    return 270;
  }

  @override
  int stepValue() {
    return 5;
  }

  @override
  int overSteerOffset() {
    return (326 - 272) ~/ maxLevel() * level;
  }

  @override
  int breakingStabilityOffset() {
    return (109 - 245) ~/ maxLevel() * level;
  }

  @override
  int corneringPerformanceOffset() {
    return (245 - 109) ~/ maxLevel() * level;
  }

  @override
  int tractionOffset() {
    return (82 - 136) ~/ maxLevel() * level;
  }

  @override
  int straightLineSpeedOffset() {
    return 0;
  }
}
