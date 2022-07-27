# polygon

Create any polygon easily in Flutter with this package !

[![Pub](https://img.shields.io/pub/v/polygon.svg)][pub]
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=QTT34M25RDNL6)

https://user-images.githubusercontent.com/9378033/181354646-63d1d8aa-315e-4ef4-8ff3-e5c3a15341bb.mov

## Features

- Creates regular convex polygons.
- Creates regular star polygons.
- Creates a polygon border.
- Clips any widget with a polygon shape.

## Usage

### Create a Polygon

With this package you can easily create any kind of polygons by just setting its vertices (in a [(-1,-1);(1,1)] rect).

```dart
const polygon = Polygon([
  Offset(0.25, -1),
  Offset(0, -0.25),
  Offset(0.5, 0),
  Offset(-0.25, 1),
  Offset(0, 0.25),
  Offset(-0.5, 0),
]);
```

You can then create a path from this polygon by using its `computePath` method.
For example you can use it in a `CustomPainter`:


```dart
class PolygonPainter extends CustomPainter {
  PolygonPainter(this.polygon);

  final Polygon polygon;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      polygon.computePath(rect: Offset.zero & size),
      Paint()..color = Colors.yellow.shade800,
    );
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) {
    return oldDelegate.polygon != polygon;
  }
}
```

![sharp](https://user-images.githubusercontent.com/9378033/181352814-e23eacc8-0268-404c-bf8b-35099a74004b.png)

The `computePath` methods accepts various parameters and you can for example apply a corder radius to all of the polygon's corners:

![rounded](https://user-images.githubusercontent.com/9378033/181352844-61bf3814-3902-4605-913d-9597b9cf4ff5.png)

### PolygonBorder

This package has also a dedicated `ShapeBorder` called `PolygonBorder`, so that you can easily apply a color, a border, an image to the polygon or clip anything through `Clip.shape`.

```dart
DecoratedBox(
  decoration: ShapeDecoration(
    shape: PolygonBorder(
      polygon: polygon,
      turn: 0.125,
      radius: 20.0,
      borderAlign: BorderAlign.outside,
      side:  BorderSide(
        width: 4,
        color: Colors.red,
      ),
    ),
    color: Colors.pink,
  ),
  child: const SizedBox(
    height: 400,
    width: 400,
  ),
),
```

### Specialized polygons.

This package comes with two specialized polygons:
A `RegularConvexPolygon` which can create triangles, tetragons, pentagons, etc.
A `RegularStarPolygon` which can create various star shapes.

https://user-images.githubusercontent.com/9378033/181354589-1c12b68b-2ecc-4ded-a46b-16fe03d6cd57.mov

## Sponsoring

I'm working on my packages on my free-time, but I don't have as much time as I would. If this package or any other package I created is helping you, please consider to sponsor me. By doing so, I will prioritize your issues or your pull-requests before the others. 

## Changelog

Please see the [Changelog][changelog] page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue][issue].  
If you fixed a bug or implemented a feature, please send a [pull request][pr].

<!--Links-->
[pub]: https://pub.dartlang.org/packages/polygon
[changelog]: https://github.com/letsar/polygon/blob/master/CHANGELOG.md
[issue]: https://github.com/letsar/polygon/issues
[pr]: https://github.com/letsar/polygon/pulls
