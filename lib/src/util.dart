import 'dart:math' as math;

import 'package:flutter/widgets.dart';

double getSmallerSide(BoxConstraints constraints) {
  return math.min(constraints.maxWidth, constraints.maxHeight);
}

double getLargerSide(BoxConstraints constraints) {
  return math.max(constraints.maxWidth, constraints.maxHeight);
}

Offset getCenteredMargins(BoxConstraints constraints) {
  final smallerSide = getSmallerSide(constraints);
  return Offset(
    (constraints.maxWidth - smallerSide) / 2,
    (constraints.maxHeight - smallerSide) / 2,
  );
}

double convertRange(
  double value,
  double minA,
  double maxA,
  double minB,
  double maxB,
) {
  return (((value - minA) * (maxB - minB)) / (maxA - minA)) + minB;
}

extension PointX on math.Point<double> {
  /// Rotates a [vector] by [angle] radians around the origin.
  ///
  /// See also:
  ///  * [Mathemical proof](https://matthew-brett.github.io/teaching/rotation_2d.html), for a detailed explanation
  math.Point<double> rotate(double angle) {
    return math.Point(
      math.cos(angle) * x - math.sin(angle) * y,
      math.sin(angle) * x + math.cos(angle) * y,
    );
  }
}
