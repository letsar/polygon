import 'dart:ui';

/// An effect used to curves corners represented by a list of vertices.
abstract class CornerPathEffect {
  /// Const constructor.
  const CornerPathEffect();

  /// Compute the [Path] represented by [vertices] where each corner has the
  /// given [radius].
  Path computePath(List<Offset> vertices, double radius);
}

/// A [CornerPathEffect] which does not add curves at all.
class NoCornerPathEffect extends CornerPathEffect {
  /// Const constructor.
  const NoCornerPathEffect();

  @override
  Path computePath(List<Offset> vertices, double radius) {
    return Path()..addPolygon(vertices, true);
  }
}

/// A [CornerPathEffect] which uses the same curve effect as Skia through
/// SkCornerPathEffect.
///
/// See: https://github.com/google/skia/blob/main/src/effects/SkCornerPathEffect.cpp.
class DefaultCornerPathEffect extends CornerPathEffect {
  /// Const constructor.
  const DefaultCornerPathEffect();

  @override
  Path computePath(List<Offset> vertices, double radius) {
    final path = Path();
    final length = vertices.length;

    for (int i = 0; i <= length; i++) {
      final src = vertices[i % length];
      final dst = vertices[(i + 1) % length];

      final stepResult = _computeStep(src, dst, radius);
      final step = stepResult.point;
      final srcX = src.dx;
      final srcY = src.dy;
      final stepX = step.dx;
      final stepY = step.dy;

      if (i == 0) {
        path.moveTo(srcX + stepX, srcY + stepY);
      } else {
        path.quadraticBezierTo(srcX, srcY, srcX + stepX, srcY + stepY);
      }

      if (stepResult.drawSegment) {
        path.lineTo(dst.dx - stepX, dst.dy - stepY);
      }
    }

    return path;
  }

  _StepResult _computeStep(Offset a, Offset b, double radius) {
    Offset point = b - a;
    final dist = point.distance;
    if (dist <= radius * 2) {
      point *= 0.5;
      return _StepResult(false, point);
    } else {
      point *= radius / dist;
      return _StepResult(true, point);
    }
  }
}

class _StepResult {
  _StepResult(this.drawSegment, this.point);
  final bool drawSegment;
  final Offset point;
}
