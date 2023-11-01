part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  const NavigationState({
    this.bottomNavigationBarCurrentIndex = 0,
  });

  final int bottomNavigationBarCurrentIndex;

  @override
  List<Object> get props => <Object>[bottomNavigationBarCurrentIndex];
}
