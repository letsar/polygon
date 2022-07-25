import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:polygon/polygon.dart';

import '../common.dart';

void main() {
  group('RegularConvexPolygon', () {
    test('with 3 vertices, should create a triangle', () {
      final polygon = RegularConvexPolygon(vertexCount: 3);
      expectOffsets(polygon.vertices, [
        const Offset(1, 0),
        Offset(-0.5, math.sqrt(3) / 2),
        Offset(-0.5, -math.sqrt(3) / 2),
      ]);
    });

    test('with 4 vertices, should create a square', () {
      final polygon = RegularConvexPolygon(vertexCount: 4);
      expectOffsets(polygon.vertices, [
        const Offset(1, 0),
        const Offset(0, 1),
        const Offset(-1, 0),
        const Offset(0, -1),
      ]);
    });
  });
}
