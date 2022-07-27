import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

class PolygonBox extends StatelessWidget {
  const PolygonBox({
    super.key,
    required this.polygon,
    this.turn,
    this.radius,
    this.borderAlign,
    this.borderWidth,
    this.borderColor,
    this.color,
    this.imageUrl,
    this.sizeFactor = 1,
  });

  final Polygon polygon;
  final double? turn;
  final double? radius;
  final BorderAlign? borderAlign;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final String? imageUrl;
  final double sizeFactor;

  @override
  Widget build(BuildContext context) {
    final localImageUrl = imageUrl;
    final effectiveBorderWidth = borderWidth ?? 0;
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: PolygonBorder(
          polygon: polygon,
          turn: turn ?? 0,
          radius: radius ?? 0,
          borderAlign: borderAlign ?? BorderAlign.outside,
          side: effectiveBorderWidth == 0
              ? BorderSide.none
              : BorderSide(
                  width: effectiveBorderWidth,
                  color: borderColor ?? const Color(0xFF000000),
                ),
        ),
        image: localImageUrl == null
            ? null
            : DecorationImage(
                image: NetworkImage(localImageUrl),
              ),
        color: color,
      ),
      child: const Area(sizeFactor: 0.8),
    );
  }
}

class Area extends StatelessWidget {
  const Area({
    super.key,
    this.sizeFactor = 1.0,
  });

  final double sizeFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: sizeFactor,
      child: const AspectRatio(
        aspectRatio: 1,
        child: SizedBox.expand(),
      ),
    );
  }
}
