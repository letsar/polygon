import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const polygon = Polygon([
      Offset(0.25, -1),
      Offset(0, -0.25),
      Offset(0.5, 0),
      Offset(-0.25, 1),
      Offset(0, 0.25),
      Offset(-0.5, 0),
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom'),
      ),
      body: const Center(
        child: PolygonPaint(
          polygon: polygon,
        ),
      ),
    );
  }
}

class PolygonPaint extends StatelessWidget {
  const PolygonPaint({
    super.key,
    required this.polygon,
  });

  final Polygon polygon;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PolygonPainter(polygon),
      child: const AspectRatio(
        aspectRatio: 1,
        child: SizedBox.expand(),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  PolygonPainter(this.polygon);

  final Polygon polygon;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      polygon.computePath(
        rect: Offset.zero & size,
        radius: 40,
      ),
      Paint()..color = Colors.yellow.shade800,
    );
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) {
    return oldDelegate.polygon != polygon;
  }
}
