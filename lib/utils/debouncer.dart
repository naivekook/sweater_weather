import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(Function() action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  dispose() {
    _timer.cancel();
    _timer = null;
  }
}
