/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:async';

export 'src/dart_stream_filtering_and_error_base.dart';

// TODO: Export any libraries intended for clients of this package.

Stream<int> filterStreamWithErrorHandling(
    Stream<int> input, bool Function(int) filterFunction) async* {
  StreamController<int> controller = StreamController<int>();

  input.listen(
    (data) {
      try {
        if (filterFunction(data)) {
          controller.add(data);
        }
      } catch (e) {
        print(e);
      }
    },
    onError: (error) {
      print("Error thrown on data! Stream will proceed Error: $error");
    },
    onDone: () {
      controller.close();
    },
    cancelOnError: false,
  );

  await for (var result in controller.stream) {
    yield result;
  }
}



/*
Practice Question 3: Stream Filtering and Error Handling
Task:
Implement a function filterStreamWithErrorHandling 
that takes a Stream<int> and a filtering 
function (). 
The function should filter elements 
based on the filtering function and handle any 
errors by logging them. Return a new Stream<int> 
with only the elements that pass the filter.
*/