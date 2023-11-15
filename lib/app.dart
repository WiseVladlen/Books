import 'package:books/app/app.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nested/nested.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.repositoryStorage,
    required this.serviceStorage,
  });

  final RepositoryStorage repositoryStorage;
  final ServiceStorage serviceStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <SingleChildWidget>[
        RepositoryProvider<IAuthRepository>.value(
          value: repositoryStorage.authRepository,
        ),
        RepositoryProvider<IBookRepository>.value(
          value: repositoryStorage.bookRepository,
        ),
        RepositoryProvider<IUserRepository>.value(
          value: repositoryStorage.userRepository,
        ),
        RepositoryProvider<IFavoritesRepository>.value(
          value: repositoryStorage.favoritesRepository,
        ),
        RepositoryProvider<IConnectivityService>.value(
          value: serviceStorage.connectivityService,
        ),
      ],
      child: MultiBlocProvider(
        providers: <SingleChildWidget>[
          BlocProvider<SettingsBloc>(
            create: (BuildContext context) => SettingsBloc(
              preferenceRepository: repositoryStorage.preferenceRepository,
            ),
          ),
          BlocProvider<NavigationBloc>(
            lazy: false,
            create: (BuildContext context) => NavigationBloc(
              user: context.read<IUserRepository>().authenticatedUserOrNull,
            ),
          ),
          BlocProvider<UserAuthBloc>(
            lazy: false,
            create: (BuildContext context) => UserAuthBloc(
              authRepository: context.read<IAuthRepository>(),
              userRepository: context.read<IUserRepository>(),
            ),
          ),
          BlocProvider<FavoritesBloc>(
            create: (BuildContext context) => FavoritesBloc(
              bookRepository: context.read<IBookRepository>(),
              favoritesRepository: context.read<IFavoritesRepository>(),
            ),
          ),
          BlocProvider<NetworkConnectionCubit>(
            lazy: false,
            create: (BuildContext context) => NetworkConnectionCubit(
              connectivityService: context.read<IConnectivityService>(),
            ),
          ),
        ],
        child: NetworkConnectionListener(
          connectivityService: serviceStorage.connectivityService,
          child: const _AppView(),
        ),
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAuthBloc, UserAuthState>(
      listenWhen: (UserAuthState oldState, UserAuthState newState) {
        return oldState.status != newState.status;
      },
      listener: (BuildContext context, UserAuthState state) {
        context.read<NavigationBloc>().add(ResetRootStackEvent(user: state.user));
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return MaterialApp.router(
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeDataX.from(brightness: Brightness.light),
            darkTheme: ThemeDataX.from(brightness: Brightness.dark),
            themeMode: state.themeMode,
            routerDelegate: AppRouterDelegate(
              bloc: context.read<NavigationBloc>(),
              navigatorKey: navigatorKey,
            ),
          );
        },
      ),
    );
  }
}
