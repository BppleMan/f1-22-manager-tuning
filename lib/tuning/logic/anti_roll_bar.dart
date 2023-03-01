import 'configurable.dart';

class AntiRollBar extends Configurable {
  AntiRollBar(super.level);

  static AntiRollBar fromValue(int value) {
    AntiRollBar arb = AntiRollBar(0);
    arb.level = value ~/ arb.stepValue();
    return arb;
  }

  static int maxLevel() {
    return 8;
  }

  @override
  int minValue() {
    return 1;
  }

  @override
  int stepValue() {
    return 1;
  }

  @override
  int overSteerOffset() {
    return (218 - 272) ~/ maxLevel() * level;
  }

  @override
  int breakingStabilityOffset() {
    return (326 - 245) ~/ maxLevel() * level;
  }

  @override
  int corneringPerformanceOffset() {
    return (27 - 109) ~/ maxLevel() * level;
  }

  @override
  int tractionOffset() {
    return (408 - 136) ~/ maxLevel() * level;
  }

  @override
  int straightLineSpeedOffset() {
    return 0;
  }
}
