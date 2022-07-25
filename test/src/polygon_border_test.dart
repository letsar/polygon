import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polygon/polygon.dart';

void main() {
  group('PolygonBorder', () {
    test('dimensions should be correct', () {
      PolygonBorder border;
      border = PolygonBorder(
        polygon: RegularConvexPolygon(vertexCount: 4),
        borderAlign: BorderAlign.outside,
        side: const BorderSide(width: 10),
      );
      expect(border.dimensions, EdgeInsets.zero);

      border = PolygonBorder(
        polygon: RegularConvexPolygon(vertexCount: 4),
        borderAlign: BorderAlign.center,
        side: const BorderSide(width: 10),
      );
      expect(border.dimensions, const EdgeInsets.all(5));

      border = PolygonBorder(
        polygon: RegularConvexPolygon(vertexCount: 4),
        borderAlign: BorderAlign.inside,
        side: const BorderSide(width: 10),
      );
      expect(border.dimensions, const EdgeInsets.all(10));
    });
  });
}
