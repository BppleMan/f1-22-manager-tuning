abstract class Configurable {
  int level;

  Configurable(this.level);

  int overSteerOffset();
  int breakingStabilityOffset();
  int corneringPerformanceOffset();
  int tractionOffset();
  int straightLineSpeedOffset();

  int minValue();
  int stepValue();

  int getValue() {
    return minValue() + level * stepValue();
  }

  void setValue(int value) {
    level = (value - minValue()) / stepValue() as int;
  }
}
