part of 'route.dart';

extension ListAppRouteX on List<AppRoute> {
  List<Page<dynamic>> toPages() => map(
        (AppRoute route) => switch (route) {
          AuthPageRoute() => const SlideTransitionPage(
              key: ValueKey<String>('AuthPageRoute'),
              page: AuthPage(),
            ),
          LoginPageRoute() => const SlideTransitionPage(
              key: ValueKey<String>('LoginPageRoute'),
              page: LoginPage(),
            ),
          SignUpPageRoute() => const SlideTransitionPage(
              key: ValueKey<String>('SignUpPageRoute'),
              page: SignUpPage(),
            ),
          SearchPageRoute() => const SharedAxisTransitionPage(
              key: ValueKey<String>('SearchPageRoute'),
              page: SearchPage(),
            ),
          HomePageRoute() => const SlideTransitionPage(
              key: ValueKey<String>('HomePageRoute'),
              page: HomePage(),
            ),
          FavoritesPageRoute() => const SlideTransitionPage(
              key: ValueKey<String>('FavoritesPageRoute'),
              page: FavouritesPage(),
            ),
          final BookDetailsPageRoute route => BaseTransitionPage(
              key: const ValueKey<String>('BookDetailsPageRoute'),
              page: BookDetailsPage.fromModel(route.book),
            ),
        },
      ).toList();
}
