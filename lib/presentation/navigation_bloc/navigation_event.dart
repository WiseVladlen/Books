part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

final class AddToRootStackEvent extends NavigationEvent {
  const AddToRootStackEvent({required this.route});

  final AppRoute route;
}

final class AddToCurrentStackEvent extends NavigationEvent {
  const AddToCurrentStackEvent({required this.route});

  final AppRoute route;
}

final class PopFromRootStackEvent extends NavigationEvent {
  const PopFromRootStackEvent();
}

final class PopFromCurrentStackEvent extends NavigationEvent {
  const PopFromCurrentStackEvent();
}

final class ResetRootStackEvent extends NavigationEvent {
  const ResetRootStackEvent({required this.user});

  final UserModel? user;
}

final class ResetCurrentStackEvent extends NavigationEvent {
  const ResetCurrentStackEvent({required this.route});

  final AppRoute route;
}
