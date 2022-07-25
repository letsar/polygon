import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

typedef PolygonBuilder = Polygon Function();

class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({
    super.key,
  });

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  int vertexCount = 4;
  double ratio = 0.5;
  double radius = 40.0;
  double turn = 0.125;
  double border = 0;
  BorderAlign borderAlign = BorderAlign.outside;
  late PolygonBuilder polygonFactory = createRegularConvexPolygon;
  bool clip = false;

  Polygon createRegularConvexPolygon() {
    return RegularConvexPolygon(vertexCount: vertexCount);
  }

  Polygon createRegularStarPolygon() {
    return RegularStarPolygon(vertexCount: vertexCount, ratio: ratio);
  }

  @override
  Widget build(BuildContext context) {
    final polygon = polygonFactory();
    final polygonBorder = PolygonBorder(
      borderAlign: borderAlign,
      polygon: polygon,
      radius: radius,
      turn: turn,
      side: border == 0
          ? BorderSide.none
          : BorderSide(
              color: Colors.orange,
              width: border,
            ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Clip?')),
                  Switch(
                    value: clip,
                    onChanged: (value) {
                      setState(() {
                        clip = value;
                      });
                    },
                  ),
                ],
              ),
              CupertinoSegmentedControl<PolygonBuilder>(
                groupValue: polygonFactory,
                children: {
                  createRegularConvexPolygon: const Text('Regular Polygon'),
                  createRegularStarPolygon: const Text('Regular Star'),
                },
                onValueChanged: (value) {
                  setState(() {
                    polygonFactory = value;
                  });
                },
              ),
              RowSlider(
                label: 'Vertices',
                min: 3,
                max: 12,
                hasDivisions: true,
                value: vertexCount.toDouble(),
                onChanged: (value) {
                  setState(() {
                    vertexCount = value.toInt();
                  });
                },
              ),
              RowSlider(
                label: 'Radius',
                min: 0,
                max: 100,
                value: radius,
                onChanged: (value) {
                  setState(() {
                    radius = value;
                  });
                },
              ),
              RowSlider(
                label: 'Rotation',
                min: 0,
                max: 1,
                value: turn,
                onChanged: (value) {
                  setState(() {
                    turn = value;
                  });
                },
              ),
              RowSlider(
                label: 'Border',
                min: 0,
                max: 10,
                hasDivisions: true,
                value: border,
                onChanged: (value) {
                  setState(() {
                    border = value;
                  });
                },
              ),
              CupertinoSegmentedControl<BorderAlign>(
                groupValue: borderAlign,
                children: const {
                  BorderAlign.inside: Text('Inside'),
                  BorderAlign.center: Text('Center'),
                  BorderAlign.outside: Text('Outside'),
                },
                onValueChanged: (value) {
                  setState(() {
                    borderAlign = value;
                  });
                },
              ),
              if (polygonFactory == createRegularStarPolygon)
                RowSlider(
                  label: 'Ratio',
                  min: 0,
                  max: 1,
                  value: ratio,
                  onChanged: (value) {
                    setState(() {
                      ratio = value;
                    });
                  },
                ),
              Expanded(
                child: Center(
                  child: clip
                      ? ClipPath.shape(
                          shape: polygonBorder,
                          child:
                              Image.network('https://placekitten.com/400/400'),
                        )
                      : DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: polygonBorder,
                            color: Colors.pink,
                          ),
                          child: const SizedBox(
                            height: 400,
                            width: 400,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowSlider extends StatelessWidget {
  const RowSlider({
    super.key,
    required this.label,
    required this.min,
    required this.max,
    this.hasDivisions = false,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double min;
  final double max;
  final bool hasDivisions;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(label)),
        Expanded(
          flex: 4,
          child: Slider(
            min: min,
            max: max,
            divisions: hasDivisions ? (max - min).toInt() : null,
            label: '$value',
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
