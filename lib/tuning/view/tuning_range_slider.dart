import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuning/tuning/controller/tuning_controller.dart';
import 'package:tuning/tuning/util/range.dart';
import 'package:tuning/tuning/view/tuning_mode_slider.dart';

class TuningRangeSlider extends StatelessWidget {
  final TuningType tuningType;
  final TuningController controller = Get.find();
  final ValueChanged<double>? onChanged;

  final opacity = 0.2;

  TuningRangeSlider({
    required this.tuningType,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Obx(
            () => Opacity(
              opacity: controller.tuningMode.value ? opacity : 1.0,
              child: Obx(
                () => IgnorePointer(
                  ignoring: controller.tuningMode.value,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      rangeThumbShape: TuningRangeSliderThumbShape(),
                      activeTrackColor: const Color(0xFF60CDFF).withAlpha(30),
                      inactiveTrackColor: Colors.white.withAlpha(30),
                      // overlayShape: SliderComponentShape.noOverlay,
                      rangeTrackShape: IndicatorSliderTrackShape(
                        controller: controller,
                        tuningType: tuningType,
                      ),
                    ),
                    child: Obx(() {
                      var range = controller.getTuningRange(tuningType);
                      return RangeSlider(
                        values: RangeValues(
                            range.start.toDouble(), range.end.toDouble()),
                        max: 545,
                        // divisions: 500,
                        labels: RangeLabels(
                            range.start.toString(), range.end.toString()),
                        onChanged: (val) {
                          controller.updateTuningRange(
                            Range(val.start.toInt(), val.end.toInt()),
                            tuningType,
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Opacity(
              opacity: controller.tuningMode.value ? 1.0 : opacity,
              child: Obx(
                () => IgnorePointer(
                  ignoring: !controller.tuningMode.value,
                  child: TuningModeSlider(tuningType: tuningType),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TuningRangeSliderThumbShape extends RangeSliderThumbShape {
  final width = 12.83;
  final height = 12.83;

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
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    var canvas = context.canvas;
    var paint = Paint()
      ..color = const Color(0xFF81D0FA)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: width, height: width),
        const Radius.circular(2),
      ),
      paint,
    );

    // draw open triangle
    var paint2 = Paint()
      ..color = const Color(0xFF0F081F)
      ..strokeWidth = 1.27
      ..style = PaintingStyle.stroke;

    var triangleWidth = 2.47;
    var triangleHeight = 4.94;
    var triangleLeft = 4.37;
    var triangleTop = 3.94;
    if (thumb?.index == 0) {
      var path = Path()
        ..moveTo(center.dx + triangleWidth / 2, center.dy - triangleHeight / 2)
        ..lineTo(center.dx - triangleWidth / 2, center.dy)
        ..lineTo(center.dx + triangleWidth / 2, center.dy + triangleHeight / 2);
      canvas.drawPath(path, paint2);
    } else {
      var path = Path()
        ..moveTo(center.dx - triangleWidth / 2, center.dy - triangleHeight / 2)
        ..lineTo(center.dx + triangleWidth / 2, center.dy)
        ..lineTo(center.dx - triangleWidth / 2, center.dy + triangleHeight / 2);
      canvas.drawPath(path, paint2);
    }
  }
}

class IndicatorSliderTrackShape extends RoundedRectRangeSliderTrackShape {
  TuningController controller;
  TuningType tuningType;

  IndicatorSliderTrackShape({
    required this.controller,
    required this.tuningType,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      startThumbCenter: startThumbCenter,
      endThumbCenter: endThumbCenter,
      textDirection: textDirection,
    );
    double indicatorPercent =
        controller.getTuningValue(tuningType).toDouble() / 545;
    var canvas = context.canvas;
    var paint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
    var trackWidth = parentBox.paintBounds.width -
        (sliderTheme.overlayShape?.getPreferredSize(true, true).width ?? 0.0);
    var trackStart = parentBox.paintBounds.left +
        (sliderTheme.overlayShape?.getPreferredSize(true, true).width ?? 0.0) /
            2;
    var width = 6.0;
    var height = 26.0;
    var left = trackStart + (trackWidth * indicatorPercent) - width / 2;
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
