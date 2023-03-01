import 'package:tuning/tuning/logic/anti_roll_bar.dart';
import 'package:tuning/tuning/logic/front_angle.dart';
import 'package:tuning/tuning/logic/tail_angle.dart';
import 'package:tuning/tuning/logic/tire_camber.dart';
import 'package:tuning/tuning/logic/toe_out.dart';

class Config {
  FrontAngle frontAngle;
  TailAngle tailAngle;
  AntiRollBar antiRollBar;
  TireCamber tireCamber;
  ToeOut toeOut;

  Config({
    required this.frontAngle,
    required this.tailAngle,
    required this.antiRollBar,
    required this.tireCamber,
    required this.toeOut,
  });
}
