part of 'indicators.dart';

class TriangleIndicator extends StatelessWidget {
  final Color? color;
  final double width;
  final double height;
  final double elevation;

  const TriangleIndicator({
    super.key,
    this.color,
    this.width = 36.0,
    this.height = 36.0,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Transform.rotate(
      angle: math.pi,
      child: SizedBox(
        width: width,
        height: height,
        child: _Triangle(
          color: color ?? theme.colorScheme.secondary,
          elevation: elevation,
        ),
      ),
    );
  }
}
