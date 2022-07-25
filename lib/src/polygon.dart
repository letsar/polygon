import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:polygon/src/corner_path_effect.dart';
import 'package:vector_math/vector_math_64.dart';

/// Represents a shape with multiple vertices (points).
///
/// The bounds of the shape must be within the rect [(-1,-1);(1,1)].
class Polygon {
  /// Creates a polygon made up with the given [vertices].
  const Polygon(this.vertices);

  /// The list of points which makes the polygon.
  final List<Offset> vertices;

  /// Computes the path of this polygon within the given [rect].
  ///
  /// The given [radius] describes the radius of each corner. The actual
  /// algorithm used to create the curve is given by [cornerPathEffect] which
  /// defaults to [DefaultCornerPathEffect].
  ///
  /// The [turn] describes how many turns the computed path should have, related
  /// to its default state.
  Path computePath({
    required Rect rect,
    double radius = 0,
    CornerPathEffect cornerPathEffect = const DefaultCornerPathEffect(),
    double turn = 0,
  }) {
    final effectiveRadius = math.max(radius, 0.0);
    final effectiveVertices = vertices.rotate(turn).withinRect(rect);
    final pathEffect =
        effectiveRadius == 0 ? const NoCornerPathEffect() : cornerPathEffect;
    return pathEffect.computePath(effectiveVertices, effectiveRadius);
  }
}

/// A regular and convex polygon, such as a square, a pentagon, etc.
class RegularConvexPolygon extends Polygon {
  /// Creates a regular polygon with [vertexCount] number of vertices.
  RegularConvexPolygon({
    required this.vertexCount,
  })  : assert(vertexCount > 2),
        super(_computeVertices(vertexCount));

  /// The number of vertices.
  final int vertexCount;

  static List<Offset> _computeVertices(int vertexCount) {
    final r = 2 * math.pi / vertexCount;
    final result = <Offset>[];
    for (int i = 0; i < vertexCount; i++) {
      final angle = i * r;
      result.add(
        Offset(
          math.cos(angle),
          math.sin(angle),
        ),
      );
    }
    return result;
  }
}

/// A regular convex star polygon with [vertexCount] internal angles (<180°) and
/// [vertexCount] external angles (>180°).
class RegularStarPolygon extends Polygon {
  /// Creates a regular convex star polygon.
  RegularStarPolygon({
    required this.vertexCount,
    required this.ratio,
  })  : assert(vertexCount > 2),
        assert(ratio >= 0 && ratio <= 1),
        super(_computeVertices(vertexCount, ratio));

  /// The number of vertices of internal angles.
  final int vertexCount;

  /// The ratio, in the range [0;1], of the external angles.
  final double ratio;

  static List<Offset> _computeVertices(int vertexCount, double ratio) {
    final r = 2 * math.pi / vertexCount;
    final hr = r / 2;

    final result = <Offset>[];
    for (int i = 0; i < vertexCount; i++) {
      final angle = i * r;
      result.add(
        Offset(
          math.cos(angle),
          math.sin(angle),
        ),
      );
      result.add(
        Offset(
          ratio * math.cos(angle + hr),
          ratio * math.sin(angle + hr),
        ),
      );
    }
    return result;
  }
}

extension on List<Offset> {
  List<Offset> withinRect(Rect rect) {
    final w = rect.width / 2;
    final h = rect.height / 2;
    final x = rect.left;
    final y = rect.top;
    return [
      for (final offset in this)
        Offset(
          offset.dx * w + x + w,
          offset.dy * h + y + h,
        )
    ];
  }

  List<Offset> rotate(double turn) {
    if (turn == turn.toInt()) {
      return this;
    }

    final rotationMatrix = Matrix4.identity()
      ..multiply(Matrix4.rotationZ(turn * math.pi * 2));

    Offset rotateOffset(Offset offset) {
      final vector = rotationMatrix.transform3(
        Vector3(offset.dx, offset.dy, 0),
      );

      return Offset(vector.x, vector.y);
    }

    return [for (final offset in this) rotateOffset(offset)];
  }
}
