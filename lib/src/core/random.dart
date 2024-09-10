// ignore_for_file: avoid_classes_with_only_static_members

part of 'core.dart';

/// Static methods for common tasks when working with [FortuneWidget]s.
abstract class Fortune {
  /// Generates a random integer uniformly distributed in the range
  /// from [min], inclusive, to [max], exclusive.
  ///
  /// The value of [max] must be larger than or equal to [min]. If it is equal
  /// to [min], this function always returns [min].
  ///
  /// An instance of [_math.Random] can optionally be passed to customize the
  /// random sample distribution.
  static int randomInt(int min, int max, [math.Random? random]) {
    random = random ?? math.Random();
    if (min == max) {
      return min;
    }
    final rng = math.Random();
    return min + rng.nextInt(max - min);
  }

  /// Generates a random [Duration] uniformly distributed in the range
  /// from [min], inclusive, to [max], exclusive.
  ///
  /// The value of [max] must be larger than or equal to [min]. If it is equal
  /// to [min], this function always returns [min].
  ///
  /// An instance of [_math.Random] can optionally be passed to customize the
  /// random sample distribution.
  static Duration randomDuration(
    Duration min,
    Duration max, [
    math.Random? random,
  ]) {
    random = random ?? math.Random();
    return Duration(
      milliseconds: randomInt(min.inMilliseconds, max.inMilliseconds, random),
    );
  }

  /// Picks a random item from [iterable] and returns it.
  ///
  /// Uses [randomInt] internally to select an item index.
  ///
  /// An instance of [_math.Random] can optionally be passed to customize the
  /// random sample distribution.
  static T randomItem<T>(Iterable<T> iterable, [math.Random? random]) {
    random = random ?? math.Random();
    return iterable.elementAt(
      randomInt(0, iterable.length, random),
    );
  }
}
