import 'dart:async';

class Repository {
  final number = StreamController<int>.broadcast();
  int count = 0;

  void incrementNumber() async {
    number.add(++count);
  }

  void decrementNumber() async {
    number.add(--count);
  }

  void reset() async {
    count = 0;
    number.add(count);
  }
}