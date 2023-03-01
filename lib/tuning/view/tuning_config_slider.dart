import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuning/tuning/controller/tuning_controller.dart';

class TuningConfigSlider extends StatelessWidget {
  final ConfigType configType;
  final TuningController controller = Get.find();
  final ValueChanged<double>? onChanged;

  TuningConfigSlider({
    required this.configType,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.white.withAlpha(30),
            inactiveTrackColor: Colors.white.withAlpha(30),
            thumbShape: SliderThumbShape(),
            // valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            // valueIndicatorColor: const Color(0xFF8ED0FA),
            valueIndicatorTextStyle: const TextStyle(
              color: Color(0xFF81D0FA),
            ),
          ),
          child: Slider(
            value: controller.getConfigLevel(configType).toDouble(),
            min: 0.0,
            max: controller.getConfigMaxLevel(configType).toDouble(),
            divisions: controller.getConfigMaxLevel(configType),
            label: "${controller.getConfigValue(configType)}",
            onChanged: (v) {
              controller.updateConfig(v.toInt(), configType);
              onChanged?.call(v);
            },
          ),
        ),
      ),
    );
  }
}

class SliderThumbShape extends SliderComponentShape {
  final width = 4.0;
  final height = 18.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    if (isEnabled) {
      return Size(width, height);
    } else {
      return Size.zero;
    }
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    var canvas = context.canvas;
    var paint = Paint()
      ..color = const Color(0xFF8ED0FA)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: width, height: height),
        const Radius.circular(8),
      ),
      paint,
    );
  }
}
