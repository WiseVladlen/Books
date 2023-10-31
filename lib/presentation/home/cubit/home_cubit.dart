import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void clickOnBottomNavigationBarItem(int index) {
    emit(HomeState(bottomNavigationBarCurrentIndex: index));
  }
}
