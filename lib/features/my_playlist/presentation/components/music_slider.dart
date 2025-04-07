import 'package:flutter/material.dart';

class MusicSlider extends StatelessWidget {
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final ValueChanged<double> onSlided;
  final double slideProgress;
  final bool isUserSeeking;

  const MusicSlider({
    super.key,
    required this.onChangeStart,
    required this.onChangeEnd,
    required this.onSlided,
    required this.slideProgress,
    required this.isUserSeeking,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape:
            isUserSeeking ? null : SliderComponentShape.noThumb,
        thumbColor: Colors.amber,
        overlayShape: SliderComponentShape.noOverlay,
        trackHeight: 4,
        activeTrackColor: Colors.amber,
        inactiveTrackColor: Colors.black12,
        trackShape: const RectangularSliderTrackShape(),
      ),
      child: Slider(
        padding: EdgeInsets.zero,
        value: slideProgress,
        min: 0,
        max: 100,
        onChanged: onSlided,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
      ),
    );
  }
}
