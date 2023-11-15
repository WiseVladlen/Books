part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({
    required this.rootStack,
    required this.currentStack,
  });

  NavigationState.initial({required AppRoute route})
      : this(
          rootStack: <AppRoute>[route],
          currentStack: route,
        );

  final List<AppRoute> rootStack;
  final AppRoute currentStack;

  NavigationState copyWith({
    List<AppRoute>? rootStack,
    AppRoute? currentStack,
  }) {
    return NavigationState(
      rootStack: rootStack ?? this.rootStack,
      currentStack: currentStack ?? this.currentStack,
    );
  }

  @override
  List<Object> get props => <Object>[rootStack, currentStack];
}
