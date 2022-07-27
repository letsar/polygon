import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clock')),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: PolygonBorder(
                  polygon: RegularStarPolygon(
                    vertexCount: 12,
                    ratio: 0.88,
                  ),
                  radius: 20,
                ),
                color: Colors.green.shade200,
              ),
              child: const ClockFace(),
            ),
          ),
        ),
      ),
    );
  }
}

class ClockFace extends StatefulWidget {
  const ClockFace({
    super.key,
  });

  @override
  State<ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace>
    with SingleTickerProviderStateMixin {
  late final ticker = createTicker(onTick);

  @override
  void initState() {
    super.initState();
    ticker.start();
  }

  void onTick(Duration elapsed) {
    setState(() {});
  }

  @override
  void dispose() {
    ticker.stop();
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return CustomPaint(
      painter: ClockFacePainter(dateTime: date),
      child: const SizedBox.expand(),
    );
  }
}

class ClockFacePainter extends CustomPainter {
  ClockFacePainter({
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  void paint(Canvas canvas, Size size) {
    final hw = size.width / 2;
    final seconds = (dateTime.second + dateTime.millisecond / 1000) / 60;
    final minutes = dateTime.minute / 60 + seconds / 100;
    final hours = dateTime.hour / 12 + minutes / 100;
    paintSeconds(canvas, hw, seconds);
    paintMinutes(canvas, hw, minutes);
    paintHours(canvas, hw, hours);
  }

  void paintSeconds(Canvas canvas, double hw, double turn) {
    final angle = math.pi * turn * 2 - math.pi / 2;
    final ratio = 0.7 * hw;

    final center = Offset(
      hw + ratio * math.cos(angle),
      hw + ratio * math.sin(angle),
    );

    canvas.drawCircle(center, 15, Paint()..color = Colors.green);
  }

  void paintMinutes(Canvas canvas, double hw, double turn) {
    paintHand(canvas, turn, 0.45, hw, Colors.green.shade800);
  }

  void paintHours(Canvas canvas, double hw, double turn) {
    paintHand(canvas, turn, 0.25, hw, Colors.green.shade900);
  }

  void paintHand(
    Canvas canvas,
    double turn,
    double ratio,
    double hw,
    Color color,
  ) {
    final angle = math.pi * 2 * turn - math.pi / 2;
    final point = Offset(
      hw + ratio * hw * math.cos(angle),
      hw + ratio * hw * math.sin(angle),
    );
    canvas.drawLine(
      point,
      Offset(hw, hw),
      Paint()
        ..color = color
        ..strokeWidth = 30
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(ClockFacePainter oldDelegate) {
    return dateTime != oldDelegate.dateTime;
  }
}
