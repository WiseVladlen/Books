import 'package:flutter/material.dart';

extension WrapperX on Widget {
  /// Wraps the source widget into a Padding widget with the [padding] parameter
  Padding wrapInPadding({required EdgeInsetsGeometry padding}) => Padding(
        padding: padding,
        child: this,
      );
}
