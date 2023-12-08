import 'package:dart_stream_filtering_and_error/dart_stream_filtering_and_error.dart';
import 'package:test/test.dart';

import 'package:test/test.dart';

void main() {
  test('filterStreamWithErrorHandling filters and handles errors', () async {
    var input = Stream.fromIterable([1, 2, 3, 4, 5])
        .map((n) => n % 2 == 0 ? throw Exception('Even number') : n);
    var filtered = filterStreamWithErrorHandling(input, (n) => n < 5);
    var expected = [1, 3]; // 5 is excluded by the filter
    expect(await filtered.toList(), equals(expected));
  });

  test('filterStreamWithErrorHandling handles an all-error stream', () async {
    var input = Stream.fromIterable([2, 4, 6])
        .map((n) => throw Exception('Even number'));
    var filtered = filterStreamWithErrorHandling(input, (n) => n < 5);
    expect(await filtered.toList(), isEmpty);
  });

  test('filterStreamWithErrorHandling handles an empty stream', () async {
    var input = Stream<int>.empty();
    var filtered = filterStreamWithErrorHandling(input, (n) => n < 5);
    expect(await filtered.toList(), isEmpty);
  });
}
