import 'dart:async';
import 'dart:ui';

class DelayedAction {
  factory DelayedAction(String key) => _cache.putIfAbsent(key, () => DelayedAction._());

  DelayedAction._();

  static final Map<String, DelayedAction> _cache = <String, DelayedAction>{};

  Timer? _timer;

  /// Cancel possible active action and delayed run the callback in [action] parameter.
  void run(
    VoidCallback action, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancel a possible active action and instantly run the callback in the [action] parameter.
  void runInstantly(VoidCallback action) {
    _timer?.cancel();
    action();
  }
}
