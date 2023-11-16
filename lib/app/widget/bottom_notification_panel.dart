import 'package:books/utils/build_context.dart';
import 'package:books/utils/delayed_action.dart';
import 'package:flutter/material.dart';

class BottomNotificationPanel extends StatefulWidget {
  const BottomNotificationPanel._({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.activateDelayedHiding,
  });

  const BottomNotificationPanel.online({required String title, required Color backgroundColor})
      : this._(
          title: title,
          backgroundColor: backgroundColor,
          activateDelayedHiding: true,
        );

  const BottomNotificationPanel.offline({required String title, required Color backgroundColor})
      : this._(
          title: title,
          backgroundColor: backgroundColor,
          activateDelayedHiding: false,
        );

  final String title;
  final Color backgroundColor;
  final bool activateDelayedHiding;

  @override
  State<BottomNotificationPanel> createState() => _BottomNotificationPanelState();
}

class _BottomNotificationPanelState extends State<BottomNotificationPanel> {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);

  final String _delayedActionKey = (_BottomNotificationPanelState).toString();

  void _showViewInstantly() {
    DelayedAction(_delayedActionKey).runInstantly(() => _isVisible.value = true);
  }

  void _hideViewDelayed() {
    DelayedAction(_delayedActionKey).run(
      () => _isVisible.value = false,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.activateDelayedHiding) _hideViewDelayed();
  }

  @override
  void didUpdateWidget(covariant BottomNotificationPanel oldWidget) {
    if (widget.activateDelayedHiding) {
      _hideViewDelayed();
    } else {
      _showViewInstantly();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isVisible,
      builder: (BuildContext context, bool value, Widget? child) {
        return AnimatedContainer(
          height: value ? 24 : 0,
          color: widget.backgroundColor,
          duration: const Duration(milliseconds: 200),
          child: Center(
            child: Text(
              widget.title,
              style: context.textStyles.notificationPanelText,
            ),
          ),
        );
      },
    );
  }
}
