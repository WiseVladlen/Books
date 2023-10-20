import 'dart:async';
import 'dart:ui';

class DelayedAction {
  factory DelayedAction() => _instance;

  DelayedAction._();

  static final DelayedAction _instance = DelayedAction._();

  static Timer? _timer;

  static void run(
    VoidCallback action, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}
