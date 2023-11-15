import 'package:books/app/route/route.dart';
import 'package:books/domain/domain.dart';
import 'package:books/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({required UserModel? user}) : super(_buildStateByUser(user)) {
    on<AddToRootStackEvent>(_addToRootStack);
    on<AddToCurrentStackEvent>(_addToCurrentStack);
    on<PopFromRootStackEvent>(_popFromRootStack);
    on<PopFromCurrentStackEvent>(_popFromCurrentStack);
    on<ResetRootStackEvent>(_resetRootStack);
    on<ResetCurrentStackEvent>(_resetCurrentStack);
  }

  static NavigationState _buildStateByUser(UserModel? user) {
    return user != null
        ? NavigationState.initial(route: HomePageRoute.base())
        : NavigationState.initial(route: AuthPageRoute.base());
  }

  void _addToRootStack(AddToRootStackEvent event, Emitter<NavigationState> emit) {
    emit(
      state.copyWith(
        rootStack: <AppRoute>[...state.rootStack, event.route],
        currentStack: event.route,
      ),
    );
  }

  void _popFromRootStack(PopFromRootStackEvent event, Emitter<NavigationState> emit) {
    final List<AppRoute> stack = <AppRoute>[...state.rootStack]..removeLast();

    emit(
      state.copyWith(
        rootStack: stack,
        currentStack: stack.last,
      ),
    );
  }

  void _popFromCurrentStack(PopFromCurrentStackEvent event, Emitter<NavigationState> emit) {
    final int index = state.rootStack.indexWhereType(state.currentStack.runtimeType);

    if (index == -1) return;

    final List<AppRoute> stack = List<AppRoute>.of(
      state.rootStack.map((AppRoute route) => route.clone()),
    )..[index].rootStack.removeLast();

    emit(
      state.copyWith(
        rootStack: stack,
        currentStack: stack.last,
      ),
    );
  }

  void _addToCurrentStack(AddToCurrentStackEvent event, Emitter<NavigationState> emit) {
    final int index = state.rootStack.indexWhereType(state.currentStack.runtimeType);

    if (index == -1) return;

    final List<AppRoute> stack = List<AppRoute>.of(
      state.rootStack.map((AppRoute route) => route.clone()),
    )..[index].rootStack.add(event.route);

    emit(
      state.copyWith(
        rootStack: stack,
        currentStack: stack.last,
      ),
    );
  }

  void _resetRootStack(ResetRootStackEvent event, Emitter<NavigationState> emit) {
    emit(_buildStateByUser(event.user));
  }

  void _resetCurrentStack(ResetCurrentStackEvent event, Emitter<NavigationState> emit) {
    final int index = state.rootStack.indexWhereType(state.currentStack.runtimeType);

    if (index == -1) return;

    final List<AppRoute> stack = List<AppRoute>.of(
      state.rootStack.map((AppRoute route) => route.clone()),
    );

    stack[index].rootStack
      ..clear()
      ..add(event.route);

    emit(
      state.copyWith(
        rootStack: stack,
        currentStack: stack.last,
      ),
    );
  }
}
