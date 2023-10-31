import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required this.user,
    required this.bookRepository,
  }) : super(const FavoritesState());

  final UserModel? user;
  final IBookRepository bookRepository;

  Future<void> loadUserBooks() async {
    // TODO: add load books
  }
}
