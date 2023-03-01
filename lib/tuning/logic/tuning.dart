import 'package:tuning/tuning/util/range.dart';
import 'package:tuple/tuple.dart';

import 'anti_roll_bar.dart';
import 'config.dart';
import 'front_angle.dart';
import 'tail_angle.dart';
import 'tire_camber.dart';
import 'toe_out.dart';

class Tuning {
  int overSteer;
  int overSteerOffset;
  int overSteerTarget;
  Range overSteerRange;

  int breakingStability;
  int breakingStabilityOffset;
  int breakingStabilityTarget;
  Range breakingStabilityRange;

  int corneringPerformance;
  int corneringPerformanceOffset;
  int corneringPerformanceTarget;
  Range corneringPerformanceRange;

  int traction;
  int tractionOffset;
  int tractionTarget;
  Range tractionRange;

  int straightLineSpeed;
  int straightLineSpeedOffset;
  int straightLineSpeedTarget;
  Range straightLineSpeedRange;

  Tuning(
    this.overSteer,
    this.overSteerOffset,
    this.overSteerTarget,
    this.overSteerRange,
    this.breakingStability,
    this.breakingStabilityOffset,
    this.breakingStabilityTarget,
    this.breakingStabilityRange,
    this.corneringPerformance,
    this.corneringPerformanceOffset,
    this.corneringPerformanceTarget,
    this.corneringPerformanceRange,
    this.traction,
    this.tractionOffset,
    this.tractionTarget,
    this.tractionRange,
    this.straightLineSpeed,
    this.straightLineSpeedOffset,
    this.straightLineSpeedTarget,
    this.straightLineSpeedRange,
  );

  Tuple2<int, Config> tuning() {
    int minJudge = 1 << 31;

    FrontAngle? minFrontAngle = null;
    TailAngle? minTailAngle = null;
    AntiRollBar? minAntiRollBar = null;
    TireCamber? minTireCamber = null;
    ToeOut? minToeOut = null;

    for (int fwa = 0; fwa <= FrontAngle.maxLevel(); ++fwa) {
      for (int tla = 0; tla <= TailAngle.maxLevel(); ++tla) {
        for (int arb = 0; arb <= AntiRollBar.maxLevel(); ++arb) {
          for (int tc = 0; tc <= TireCamber.maxLevel(); ++tc) {
            for (int to = 0; to <= ToeOut.maxLevel(); ++to) {
              FrontAngle frontAngle = FrontAngle(fwa);
              TailAngle tailAngle = TailAngle(tla);
              AntiRollBar antiRollBar = AntiRollBar(arb);
              TireCamber tireCamber = TireCamber(tc);
              ToeOut toeOut = ToeOut(to);
            }
          }
        }
      }
    }

    return Tuple2(
      0,
      Config(
        frontAngle: minFrontAngle!,
        tailAngle: minTailAngle!,
        antiRollBar: minAntiRollBar!,
        tireCamber: minTireCamber!,
        toeOut: minToeOut!,
      ),
    );
  }

  List<Config> searchTargetLine() {
    List<Config> results = [];

    for (int fwa = 0; fwa <= FrontAngle.maxLevel(); ++fwa) {
      for (int tla = 0; tla <= TailAngle.maxLevel(); ++tla) {
        for (int arb = 0; arb <= AntiRollBar.maxLevel(); ++arb) {
          for (int tc = 0; tc <= TireCamber.maxLevel(); ++tc) {
            for (int to = 0; to <= ToeOut.maxLevel(); ++to) {
              FrontAngle frontAngle = FrontAngle(fwa);
              TailAngle tailAngle = TailAngle(tla);
              AntiRollBar antiRollBar = AntiRollBar(arb);
              TireCamber tireCamber = TireCamber(tc);
              ToeOut toeOut = ToeOut(to);

              int overSteer = this.overSteer +
                  frontAngle.overSteerOffset() +
                  tailAngle.overSteerOffset() +
                  antiRollBar.overSteerOffset() +
                  tireCamber.overSteerOffset() +
                  toeOut.overSteerOffset();
              if (!overSteerRange.contains(overSteer)) continue;

              int breakingStability = this.breakingStability +
                  frontAngle.breakingStabilityOffset() +
                  tailAngle.breakingStabilityOffset() +
                  antiRollBar.breakingStabilityOffset() +
                  tireCamber.breakingStabilityOffset() +
                  toeOut.breakingStabilityOffset();
              if (!breakingStabilityRange.contains(breakingStability)) continue;

              int corneringPerformance = this.corneringPerformance +
                  frontAngle.corneringPerformanceOffset() +
                  tailAngle.corneringPerformanceOffset() +
                  antiRollBar.corneringPerformanceOffset() +
                  tireCamber.corneringPerformanceOffset() +
                  toeOut.corneringPerformanceOffset();
              if (!corneringPerformanceRange.contains(corneringPerformance))
                continue;

              int straightLineSpeed = this.straightLineSpeed +
                  frontAngle.straightLineSpeedOffset() +
                  tailAngle.straightLineSpeedOffset() +
                  antiRollBar.straightLineSpeedOffset() +
                  tireCamber.straightLineSpeedOffset() +
                  toeOut.straightLineSpeedOffset();
              if (!straightLineSpeedRange.contains(straightLineSpeed)) continue;

              int traction = this.traction +
                  frontAngle.tractionOffset() +
                  tailAngle.tractionOffset() +
                  antiRollBar.tractionOffset() +
                  tireCamber.tractionOffset() +
                  toeOut.tractionOffset();
              if (!tractionRange.contains(traction)) continue;

              results.add(Config(
                  frontAngle: frontAngle,
                  tailAngle: tailAngle,
                  antiRollBar: antiRollBar,
                  tireCamber: tireCamber,
                  toeOut: toeOut));
            }
          }
        }
      }
    }

    return results;
  }

  int judge() {
    return (overSteer + overSteerOffset - overSteerTarget).abs() +
        (breakingStability + breakingStabilityOffset - breakingStabilityTarget)
            .abs() +
        (corneringPerformance +
                corneringPerformanceOffset -
                corneringPerformanceTarget)
            .abs() +
        (traction + tractionOffset - tractionTarget).abs() +
        (straightLineSpeed + straightLineSpeedOffset - straightLineSpeedTarget)
            .abs();
  }

  void update(Config config) {
    overSteerOffset = config.frontAngle.overSteerOffset() +
        config.tailAngle.overSteerOffset() +
        config.antiRollBar.overSteerOffset() +
        config.tireCamber.overSteerOffset() +
        config.toeOut.overSteerOffset();

    breakingStabilityOffset = config.frontAngle.breakingStabilityOffset() +
        config.tailAngle.breakingStabilityOffset() +
        config.antiRollBar.breakingStabilityOffset() +
        config.tireCamber.breakingStabilityOffset() +
        config.toeOut.breakingStabilityOffset();

    corneringPerformanceOffset =
        config.frontAngle.corneringPerformanceOffset() +
            config.tailAngle.corneringPerformanceOffset() +
            config.antiRollBar.corneringPerformanceOffset() +
            config.tireCamber.corneringPerformanceOffset() +
            config.toeOut.corneringPerformanceOffset();

    tractionOffset = config.frontAngle.tractionOffset() +
        config.tailAngle.tractionOffset() +
        config.antiRollBar.tractionOffset() +
        config.tireCamber.tractionOffset() +
        config.toeOut.tractionOffset();

    straightLineSpeedOffset = config.frontAngle.straightLineSpeedOffset() +
        config.tailAngle.straightLineSpeedOffset() +
        config.antiRollBar.straightLineSpeedOffset() +
        config.tireCamber.straightLineSpeedOffset() +
        config.toeOut.straightLineSpeedOffset();
  }
}
