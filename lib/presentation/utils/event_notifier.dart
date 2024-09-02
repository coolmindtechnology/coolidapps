
import 'dart:async';
import 'dart:math' as math;

class EventNotifier {
  final StreamController<int> _sc = StreamController.broadcast();

  StreamSubscription listen({required void Function() onChanges}) {
    return _sc.stream.listen((event) {
      onChanges();
    });
  }

  void close() {
    _sc.close();
  }

  void notify() {
    _sc.sink.add(math.Random().nextInt(9999999));
  }
}