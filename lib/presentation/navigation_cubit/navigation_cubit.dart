import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void clickOnPage({required int index}) {
    emit(NavigationState(pageViewType: PageViewType.values[index]));
  }
}
