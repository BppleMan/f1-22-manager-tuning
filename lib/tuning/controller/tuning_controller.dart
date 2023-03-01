import 'package:get/get.dart';
import 'package:tuning/tuning/logic/anti_roll_bar.dart';
import 'package:tuning/tuning/logic/config.dart';
import 'package:tuning/tuning/logic/front_angle.dart';
import 'package:tuning/tuning/logic/tail_angle.dart';
import 'package:tuning/tuning/logic/tire_camber.dart';
import 'package:tuning/tuning/logic/toe_out.dart';
import 'package:tuning/tuning/logic/tuning.dart';
import 'package:tuning/tuning/util/range.dart';

class TuningController extends GetxController {
  late Rx<Tuning> tuning;
  late Rx<Config> config;
  late RxBool tuningMode = true.obs;

  TuningController(this.tuning, this.config);

  void updateConfig(int value, ConfigType configType) {
    config.update((config) {
      switch (configType) {
        case ConfigType.frontAngle:
          config?.frontAngle.level = value;
          break;
        case ConfigType.tailAngle:
          config?.tailAngle.level = value;
          break;
        case ConfigType.antiRollBar:
          config?.antiRollBar.level = value;
          break;
        case ConfigType.tireCamber:
          config?.tireCamber.level = value;
          break;
        case ConfigType.toeOut:
          config?.toeOut.level = value;
          break;
      }
    });
    tuning.update((tuning) => tuning?.update(config.value));
  }

  void updateTuningRange(Range values, TuningType tuningType) {
    tuning.update((tuning) {
      switch (tuningType) {
        case TuningType.overSteer:
          tuning?.overSteerRange = values;
          tuning?.overSteerTarget = values.middle;
          break;
        case TuningType.breakingStability:
          tuning?.breakingStabilityRange = values;
          tuning?.breakingStabilityTarget = values.middle;
          break;
        case TuningType.corneringPerformance:
          tuning?.corneringPerformanceRange = values;
          tuning?.corneringPerformanceTarget = values.middle;
          break;
        case TuningType.traction:
          tuning?.tractionRange = values;
          tuning?.tractionTarget = values.middle;
          break;
        case TuningType.straightLineSpeed:
          tuning?.straightLineSpeedRange = values;
          tuning?.straightLineSpeedTarget = values.middle;
          break;
      }
    });
  }

  int getConfigLevel(ConfigType configType) {
    switch (configType) {
      case ConfigType.frontAngle:
        return config.value.frontAngle.level;
      case ConfigType.tailAngle:
        return config.value.tailAngle.level;
      case ConfigType.antiRollBar:
        return config.value.antiRollBar.level;
      case ConfigType.tireCamber:
        return config.value.tireCamber.level;
      case ConfigType.toeOut:
        return config.value.toeOut.level;
    }
  }

  int getConfigMaxLevel(ConfigType configType) {
    switch (configType) {
      case ConfigType.frontAngle:
        return FrontAngle.maxLevel();
      case ConfigType.tailAngle:
        return TailAngle.maxLevel();
      case ConfigType.antiRollBar:
        return AntiRollBar.maxLevel();
      case ConfigType.tireCamber:
        return TireCamber.maxLevel();
      case ConfigType.toeOut:
        return ToeOut.maxLevel();
    }
  }

  int getConfigValue(ConfigType configType) {
    switch (configType) {
      case ConfigType.frontAngle:
        return config.value.frontAngle.getValue();
      case ConfigType.tailAngle:
        return config.value.tailAngle.getValue();
      case ConfigType.antiRollBar:
        return config.value.antiRollBar.getValue();
      case ConfigType.tireCamber:
        return config.value.tireCamber.getValue();
      case ConfigType.toeOut:
        return config.value.toeOut.getValue();
    }
  }

  Range getTuningRange(TuningType tuningType) {
    switch (tuningType) {
      case TuningType.overSteer:
        return tuning.value.overSteerRange;
      case TuningType.breakingStability:
        return tuning.value.breakingStabilityRange;
      case TuningType.corneringPerformance:
        return tuning.value.corneringPerformanceRange;
      case TuningType.traction:
        return tuning.value.tractionRange;
      case TuningType.straightLineSpeed:
        return tuning.value.straightLineSpeedRange;
    }
  }

  int getTuningTarget(TuningType tuningType) {
    switch (tuningType) {
      case TuningType.overSteer:
        return tuning.value.overSteerTarget;
      case TuningType.breakingStability:
        return tuning.value.breakingStabilityTarget;
      case TuningType.corneringPerformance:
        return tuning.value.corneringPerformanceTarget;
      case TuningType.traction:
        return tuning.value.tractionTarget;
      case TuningType.straightLineSpeed:
        return tuning.value.straightLineSpeedTarget;
    }
  }

  int getTuningValue(TuningType tuningType) {
    switch (tuningType) {
      case TuningType.overSteer:
        return tuning.value.overSteer + tuning.value.overSteerOffset;
      case TuningType.breakingStability:
        return tuning.value.breakingStability +
            tuning.value.breakingStabilityOffset;
      case TuningType.corneringPerformance:
        return tuning.value.corneringPerformance +
            tuning.value.corneringPerformanceOffset;
      case TuningType.traction:
        return tuning.value.traction + tuning.value.tractionOffset;
      case TuningType.straightLineSpeed:
        return tuning.value.straightLineSpeed +
            tuning.value.straightLineSpeedOffset;
    }
  }

  Rx<bool> toggleTuningMode() {
    return tuningMode.toggle();
  }

  void updateTuningTarget(int val, TuningType tuningType) {
    tuning.update((tuning) {
      switch (tuningType) {
        case TuningType.overSteer:
          tuning?.overSteerTarget = val;
          break;
        case TuningType.breakingStability:
          tuning?.breakingStabilityTarget = val;
          break;
        case TuningType.corneringPerformance:
          tuning?.corneringPerformanceTarget = val;
          break;
        case TuningType.traction:
          tuning?.tractionTarget = val;
          break;
        case TuningType.straightLineSpeed:
          tuning?.straightLineSpeedTarget = val;
          break;
      }
    });
  }
}

enum ConfigType {
  frontAngle,
  tailAngle,
  antiRollBar,
  tireCamber,
  toeOut,
}

enum TuningType {
  overSteer,
  breakingStability,
  corneringPerformance,
  straightLineSpeed,
  traction,
}
