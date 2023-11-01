part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.bottomNavigationBarCurrentIndex = 0,
  });

  final int bottomNavigationBarCurrentIndex;

  @override
  List<Object> get props => <Object>[bottomNavigationBarCurrentIndex];
}
