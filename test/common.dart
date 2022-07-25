import 'package:flutter_test/flutter_test.dart';

void expectOffsets(List<Offset> actual, List<Offset> expected) {
  expect(actual.length, expected.length);

  for (int i = 0; i < actual.length; i++) {
    expect(actual[i], within<Offset>(distance: 0.1, from: expected[i]));
  }
}
