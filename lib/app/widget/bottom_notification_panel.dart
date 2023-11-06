import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';

class BottomNotificationPanel extends StatefulWidget {
  const BottomNotificationPanel._({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.activateDelayedHiding,
  });

  const BottomNotificationPanel.online({required String title})
      : this._(
          title: title,
          backgroundColor: Colors.green,
          activateDelayedHiding: true,
        );

  const BottomNotificationPanel.offline({required String title})
      : this._(
          title: title,
          backgroundColor: Colors.red,
          activateDelayedHiding: false,
        );

  final String title;

  final Color backgroundColor;

  final bool activateDelayedHiding;

  @override
  State<BottomNotificationPanel> createState() => _BottomNotificationPanelState();
}

class _BottomNotificationPanelState extends State<BottomNotificationPanel> {
  bool _isVisible = true;

  void _hideDelayed() {
    Future<void>.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.activateDelayedHiding) _hideDelayed();
  }

  @override
  void didUpdateWidget(covariant BottomNotificationPanel oldWidget) {
    if (widget.activateDelayedHiding) {
      _hideDelayed();
    } else {
      _isVisible = true;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _isVisible ? 32 : 0,
      color: widget.backgroundColor,
      duration: const Duration(milliseconds: 200),
      child: Center(
        child: Text(
          widget.title,
          style: context.textStyles.notificationPanelText,
        ),
      ),
    );
  }
}
