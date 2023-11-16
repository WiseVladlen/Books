import 'package:books/app/pages/home/book_details_page.dart';
import 'package:books/app/pages/pages.dart';
import 'package:books/app/widget/transition/transition.dart';
import 'package:books/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'route_mapper.dart';

sealed class AppRoute extends Equatable {
  const AppRoute({this.rootStack = const <AppRoute>[]});

  final List<AppRoute> rootStack;

  AppRoute clone() => this;

  @override
  List<Object> get props => <Object>[rootStack];
}

final class AuthPageRoute extends AppRoute {
  const AuthPageRoute({required this.initialRoute, required super.rootStack});

  AuthPageRoute.base()
      : this(
          initialRoute: const LoginPageRoute(),
          rootStack: <AppRoute>[const LoginPageRoute()],
        );

  final AppRoute initialRoute;

  @override
  AuthPageRoute clone() {
    return AuthPageRoute(
      initialRoute: initialRoute,
      rootStack: List<AppRoute>.of(rootStack.map((AppRoute route) => route.clone())),
    );
  }
}

final class LoginPageRoute extends AppRoute {
  const LoginPageRoute();
}

final class SignUpPageRoute extends AppRoute {
  const SignUpPageRoute();
}

final class SearchPageRoute extends AppRoute {
  const SearchPageRoute();
}

final class HomePageRoute extends AppRoute {
  const HomePageRoute({required this.initialRoute, required super.rootStack});

  HomePageRoute.base()
      : this(
          initialRoute: const FavoritesPageRoute(),
          rootStack: <AppRoute>[const FavoritesPageRoute()],
        );

  final AppRoute initialRoute;

  @override
  HomePageRoute clone() {
    return HomePageRoute(
      initialRoute: initialRoute,
      rootStack: List<AppRoute>.of(rootStack.map((AppRoute route) => route.clone())),
    );
  }
}

final class FavoritesPageRoute extends AppRoute {
  const FavoritesPageRoute();
}

final class BookDetailsPageRoute extends AppRoute {
  const BookDetailsPageRoute({required this.book});

  final BookModel book;
}
