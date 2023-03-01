import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuning/tuning/controller/tuning_controller.dart';
import 'package:tuning/tuning/logic/anti_roll_bar.dart';
import 'package:tuning/tuning/logic/config.dart';
import 'package:tuning/tuning/logic/front_angle.dart';
import 'package:tuning/tuning/logic/tail_angle.dart';
import 'package:tuning/tuning/logic/tire_camber.dart';
import 'package:tuning/tuning/logic/toe_out.dart';
import 'package:tuning/tuning/logic/tuning.dart';
import 'package:tuning/tuning/util/range.dart';
import 'package:tuning/tuning/view/tuning_config_slider.dart';
import 'package:tuning/tuning/view/tuning_range_slider.dart';

class TuningView extends StatelessWidget {
  final width = 160.0;
  final double titleWidth = 250.0;

  TuningView({super.key});

  final controller = Get.put(
    TuningController(
      Tuning(
        272,
        0,
        (232 + 267) ~/ 2,
        Range(241, 351),
        245,
        0,
        (335 + 377) ~/ 2,
        Range(337, 382),
        109,
        0,
        (110 + 135) ~/ 2,
        Range(97, 187),
        136,
        0,
        (345 + 377) ~/ 2,
        Range(280, 369),
        545,
        0,
        (406 + 436) ~/ 2,
        Range(393, 475),
      ).obs,
      Config(
        frontAngle: FrontAngle(0),
        tailAngle: TailAngle(0),
        antiRollBar: AntiRollBar(0),
        tireCamber: TireCamber(0),
        toeOut: ToeOut(0),
      ).obs,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.toggleTuningMode();
          },
          child: const Icon(Icons.refresh),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  config(),
                  const SizedBox(height: 24),
                  effect(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget config() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0X0AFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0X0FFFFFFF), width: 1),
      ),
      // constraints: const BoxConstraints(maxHeight: 233),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: configRow("前翼角度", ConfigType.frontAngle, true),
          ),
          configRow("尾翼角度", ConfigType.tailAngle, false),
          configRow("防倾杆分配", ConfigType.antiRollBar, true),
          configRow("轮胎外倾角", ConfigType.tireCamber, false),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: configRow("前束角偏外", ConfigType.toeOut, true),
          ),
        ],
      ),
    );
  }

  Widget configRow(String title, ConfigType configType, bool dark) {
    return Container(
      height: 60,
      color: dark ? const Color(0X00262626) : const Color(0X0AFFFFFF),
      child: Row(
        children: [
          configTitle(title, configType),
          TuningConfigSlider(configType: configType),
        ],
      ),
    );
  }

  Widget effect() {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0X0AFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0X0FFFFFFF), width: 1),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: effectRow("转向过度", TuningType.overSteer, true),
            ),
            effectRow("刹车稳定性", TuningType.breakingStability, false),
            effectRow("弯道性能", TuningType.corneringPerformance, true),
            effectRow("牵引力", TuningType.traction, false),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: effectRow("直道", TuningType.straightLineSpeed, true),
            ),
          ],
        ));
  }

  Widget effectRow(String title, TuningType tuningType, bool dark) {
    return Container(
      height: 60,
      color: dark ? const Color(0X00262626) : const Color(0X0AFFFFFF),
      child: Row(
        children: [
          effectTitle(title, tuningType),
          TuningRangeSlider(tuningType: tuningType),
        ],
      ),
    );
  }

  Widget configTitle(String title, ConfigType configType) {
    return Container(
      width: titleWidth,
      padding: const EdgeInsets.only(left: 24),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            Expanded(child: Container()),
            Obx(
              () => Text(
                "${controller.getConfigValue(configType)}",
                style: const TextStyle(fontSize: 20, color: Color(0xFF81D0FA)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget effectTitle(String title, TuningType tuningType) {
    return Container(
      width: titleWidth,
      padding: const EdgeInsets.only(left: 24),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            Expanded(child: Container()),
            Obx(() {
              var range = controller.getTuningRange(tuningType);
              return Text("${range.start}-${range.end}",
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFF81D0FA)));
            }),
          ],
        ),
      ),
    );
  }
}
