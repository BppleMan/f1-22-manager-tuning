import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuning/tuning/controller/tuning_controller.dart';

class TuningModeSlider extends StatelessWidget {
  final TuningType tuningType;
  final TuningController controller = Get.find();
  final ValueChanged<double>? onChanged;

  TuningModeSlider({
    required this.tuningType,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: TuningModeSliderThumbShape(),
        activeTrackColor: Colors.white.withAlpha(30),
        inactiveTrackColor: Colors.white.withAlpha(30),
        activeTickMarkColor: const Color(0xFF81D0FA),
        inactiveTickMarkColor: const Color(0xFF81D0FA),
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Obx(() {
        return Slider(
          value: controller.getTuningTarget(tuningType).toDouble(),
          min: 0.0,
          max: 545.0,
          label: controller.getTuningTarget(tuningType).toString(),
          onChanged: (val) {
            controller.updateTuningTarget(val.toInt(), tuningType);
          },
        );
      }),
    );
  }
}

class TuningModeSliderThumbShape extends SliderComponentShape {
  var width = 6.0;
  var height = 26.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, height);
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
      ..color = const Color(0xFF81D0FA)
      ..style = PaintingStyle.fill;
    var trackWidth = parentBox.paintBounds.width -
        (sliderTheme.overlayShape?.getPreferredSize(true, true).width ?? 0.0);
    var trackStart = parentBox.paintBounds.left +
        (sliderTheme.overlayShape?.getPreferredSize(true, true).width ?? 0.0) /
            2;
    // var left = trackStart + (trackWidth * indicatorPercent) - width / 2;
    var left = center.dx - width / 2;
    var top = (parentBox.size.height - height) / 2;
    var upTriangle = Path()
      ..moveTo(left, top)
      ..lineTo(left + width, top)
      ..lineTo(left + width / 2, top + 4)
      ..close();
    canvas.drawPath(upTriangle, paint);
    var downTriangle = Path()
      ..moveTo(left, top + height)
      ..lineTo(left + width, top + height)
      ..lineTo(left + width / 2, top + height - 4)
      ..close();
    canvas.drawPath(downTriangle, paint);
    // draw radius rect
    var rect = Rect.fromLTWH(left + 1.5, top + 5, 3, 15);
    var radius = const Radius.circular(3);
    var rrect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(rrect, paint);
  }
}
