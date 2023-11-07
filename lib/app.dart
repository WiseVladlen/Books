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
          BlocProvider<UserAuthBloc>(
            create: (BuildContext context) => UserAuthBloc(
              authRepository: context.read<IAuthRepository>(),
              userRepository: context.read<IUserRepository>(),
            ),
          ),
          BlocProvider<NetworkConnectionCubit>(
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

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeDataX.from(brightness: Brightness.light),
      home: BlocBuilder<UserAuthBloc, UserAuthState>(
        buildWhen: (UserAuthState oldState, UserAuthState newState) {
          return (oldState.status != newState.status);
        },
        builder: (BuildContext context, UserAuthState state) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: switch (state.status) {
                    AuthStatus.initial => const Center(child: CircularProgressIndicator()),
                    AuthStatus.unauthenticated => const AuthPage(),
                    AuthStatus.authenticated => const HomePage(),
                  },
                ),
                BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
                  buildWhen: (NetworkConnectionState oldState, NetworkConnectionState newState) {
                    return oldState.status != newState.status;
                  },
                  builder: (BuildContext context, NetworkConnectionState state) {
                    if (state.status.isOnline) {
                      return BottomNotificationPanel.online(
                        title: context.l10n.networkConnectedMessage,
                        backgroundColor: context.colors.positive,
                      );
                    }

                    return BottomNotificationPanel.offline(
                      title: context.l10n.networkConnectionWaitingMessage,
                      backgroundColor: context.colors.negative,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
