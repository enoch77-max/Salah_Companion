import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/utils/compass_filter.dart';

void main() {
  group('CompassFilter Unit Tests', () {
    test('normalizes angles correctly to [0, 360)', () {
      expect(CompassFilter.normalizeAngle(0.0), equals(0.0));
      expect(CompassFilter.normalizeAngle(360.0), equals(0.0));
      expect(CompassFilter.normalizeAngle(450.0), equals(90.0));
      expect(CompassFilter.normalizeAngle(-90.0), equals(270.0));
    });

    test('calculates shortest angular delta across 0/360 boundary', () {
      expect(CompassFilter.shortestAngularDelta(10.0, 350.0), equals(20.0));
      expect(CompassFilter.shortestAngularDelta(350.0, 10.0), equals(-20.0));
      expect(CompassFilter.shortestAngularDelta(180.0, 0.0), equals(180.0));
      expect(CompassFilter.shortestAngularDelta(0.0, 180.0).abs(), equals(180.0));
    });

    test('smooths heading using exponential moving average (EMA)', () {
      final filter = CompassFilter(alpha: 0.2, minDeltaThreshold: 0.0, maxStepLimit: 180.0);
      filter.reset(100.0);

      // Raw update 150.0 -> delta +50.0 * 0.2 = +10.0 -> new heading 110.0
      double smoothed = filter.update(150.0);
      expect(smoothed, closeTo(110.0, 0.001));

      // Next update 150.0 -> delta +40.0 * 0.2 = +8.0 -> new heading 118.0
      smoothed = filter.update(150.0);
      expect(smoothed, closeTo(118.0, 0.001));
    });

    test('suppresses micro-jitter below minDeltaThreshold', () {
      final filter = CompassFilter(alpha: 0.5, minDeltaThreshold: 0.5);
      filter.reset(100.0);

      // Tiny change of +0.10° < 0.5° threshold should be ignored
      double smoothed = filter.update(100.10);
      expect(smoothed, equals(100.0));
    });

    test('clamps outlier spikes to maxStepLimit', () {
      final filter = CompassFilter(alpha: 1.0, maxStepLimit: 15.0);
      filter.reset(100.0);

      // Large spike of +90° should be clamped to maxStepLimit of +15°
      double smoothed = filter.update(190.0);
      expect(smoothed, equals(115.0));
    });
  });
}
