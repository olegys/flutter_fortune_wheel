import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_fortune_wheel/src/util.dart';
import 'package:flutter_test/flutter_test.dart';

void repeatFor(VoidCallback func, [int iterations = 1000]) {
  for (var i = 0; i < 10e6; i++) {
    func();
  }
}

void tick(Duration duration) {
  SchedulerBinding.instance.handleBeginFrame(duration);
  SchedulerBinding.instance.handleDrawFrame();
}

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.resetEpoch();
    PlatformDispatcher.instance.onBeginFrame = null;
    PlatformDispatcher.instance.onDrawFrame = null;
  });

  group('Fortune.randomInt', () {
    test('returns values within the required range.', () {
      final random = Random();
      repeatFor(() {
        final min = random.nextInt(10000);
        final max = min + random.nextInt(10000);
        final rnd = Fortune.randomInt(min, max);

        if (min == max) {
          expect(rnd, equals(min));
          expect(rnd, equals(max));
        } else {
          expect(rnd, greaterThanOrEqualTo(min));
          expect(rnd, lessThan(max));
        }
      });
    });
  });

  group('Fortune.randomDuration', () {
    test('returns durations within the required range.', () {
      final random = Random();
      repeatFor(() {
        final min = Duration(seconds: random.nextInt(10000));
        final max = min + Duration(seconds: random.nextInt(10000));
        final rnd = Fortune.randomDuration(min, max);

        if (min == max) {
          expect(rnd, equals(min));
          expect(rnd, equals(max));
        } else {
          expect(rnd, greaterThanOrEqualTo(min));
          expect(rnd, lessThan(max));
        }
      });
    });
  });

  group('Fortune.randomItem', () {
    test('returns only items from the given array', () {
      final random = Random();
      repeatFor(() {
        final itemCount = random.nextInt(100) + 1;
        final items = <int>[for (var i = 0; i < itemCount; i++) i];
        final rnd = Fortune.randomItem(items);
        expect(items, contains(rnd));
      });
    });
  });

  group('rotateVector', () {
    test('returns the same vector for angle of 0 radians', () {
      const inputVector = Point(14.0, 14.0);
      const angle = 0.0;
      final rotatedVector = inputVector.rotate(angle);
      expect(rotatedVector.x, moreOrLessEquals(inputVector.x));
      expect(rotatedVector.y, moreOrLessEquals(inputVector.y));
    });

    test('returns the same vector for angle of 2 * pi radians', () {
      const inputVector = Point(14.0, 14.0);
      const angle = pi * 2;
      final rotatedVector = inputVector.rotate(angle);
      expect(rotatedVector.x, moreOrLessEquals(inputVector.x));
      expect(rotatedVector.y, moreOrLessEquals(inputVector.y));
    });
  });

  group('getSmallerSide', () {
    test('always returns the size of the smallest constrained side', () {
      const equalSides = BoxConstraints(
        maxWidth: 100,
        maxHeight: 100,
      );
      expect(getSmallerSide(equalSides), moreOrLessEquals(100));

      const smallHeight = BoxConstraints(
        maxWidth: 200,
        maxHeight: 50,
      );
      expect(getSmallerSide(smallHeight), moreOrLessEquals(50));

      const smallWidth = BoxConstraints(
        maxWidth: 10,
        maxHeight: 200,
      );
      expect(getSmallerSide(smallWidth), moreOrLessEquals(10));
    });
  });

  group('getCenteredMargins', () {
    test('returns correct offset', () {
      var offset = getCenteredMargins(const BoxConstraints(
        maxWidth: 200,
        maxHeight: 100,
      ));
      expect(offset.dx, moreOrLessEquals(50));
      expect(offset.dy, moreOrLessEquals(0));

      offset = getCenteredMargins(const BoxConstraints(
        maxWidth: 100,
        maxHeight: 300,
      ));
      expect(offset.dx, moreOrLessEquals(0));
      expect(offset.dy, moreOrLessEquals(100));

      offset = getCenteredMargins(const BoxConstraints(
        maxWidth: 50,
        maxHeight: 50,
      ));
      expect(offset.dx, moreOrLessEquals(0));
      expect(offset.dy, moreOrLessEquals(0));
    });
  });
}
