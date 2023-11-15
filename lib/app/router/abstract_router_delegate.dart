import 'package:flutter/material.dart';

abstract class AbstractRouterDelegate<T> extends RouterDelegate<T>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<T> {}
