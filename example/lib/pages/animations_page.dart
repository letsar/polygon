import 'package:example/common.dart';
import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({
    super.key,
  });

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 6));
  late final turns = controller
      .drive(CurveTween(curve: Curves.bounceOut))
      .drive(Tween(begin: 0.0, end: 0.5));
  late final radius = controller
      .drive(CurveTween(curve: Curves.bounceOut))
      .drive(Tween(begin: 0.0, end: 40.0));

  late final borderWidth = controller
      .drive(CurveTween(curve: Curves.bounceOut))
      .drive(Tween(begin: 0.0, end: 10.0));

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final polygon = RegularStarPolygon(vertexCount: 12, ratio: 0.8);
    final triangle = RegularConvexPolygon(vertexCount: 3);
    final pentaStar = RegularConvexPolygon(vertexCount: 4);
    return Scaffold(
      appBar: AppBar(title: const Text('Animations')),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  PolygonBox(
                    polygon: polygon,
                    turn: turns.value,
                    radius: radius.value,
                    borderWidth: borderWidth.value,
                    imageUrl: 'https://placekitten.com/400/400',
                  ),
                  Positioned(
                    bottom: -40,
                    right: -40,
                    height: 200,
                    width: 200,
                    child: PolygonBox(
                      polygon: triangle,
                      turn: -turns.value,
                      radius: radius.value + 20,
                      borderWidth: (borderWidth.value * 1.5) + 2,
                      borderColor: Colors.pink.shade900,
                      color: Colors.pink.withOpacity(0.8),
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: -40,
                    height: 200,
                    width: 200,
                    child: PolygonBox(
                      polygon: pentaStar,
                      turn: 0.125,
                      radius: radius.value + 20,
                      borderWidth: (borderWidth.value * 0.5) + 2,
                      borderColor: Colors.green.shade900,
                      color: Colors.green.withOpacity(0.8),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
