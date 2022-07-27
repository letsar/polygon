import 'package:example/pages/animations_page.dart';
import 'package:example/pages/clock_page.dart';
import 'package:example/pages/custom_page.dart';
import 'package:example/pages/playground_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Polygon Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              MyButton(text: 'Playground', page: PlaygroundPage()),
              MyButton(text: 'Animations', page: AnimationsPage()),
              MyButton(text: 'Clock', page: ClockPage()),
              MyButton(text: 'Custom', page: CustomPage()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.page,
  });

  final String text;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Text(text),
    );
  }
}
