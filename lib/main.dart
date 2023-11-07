import 'dart:async';

import 'package:app_runner/app_runner.dart';
import 'package:books/app/app.dart';
import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nested/nested.dart';

typedef AppBuilderData = ({
  ServiceStorage serviceStorage,
  RepositoryStorage repositoryStorage,
});

abstract class AppBuilderDataWrapper {
  static late final IErrorLoggerService errorLoggerService;
}

Future<void> main() async {
  final WidgetConfiguration widgetConfiguration = WidgetConfiguration(
    child: AppBuilder<AppBuilderData>(
      preInitialize: (WidgetsBinding binding) async {
        WidgetsFlutterBinding.ensureInitialized();

        await Firebase.initializeApp();

        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

        final ServiceStorage serviceStorage = await DependencyInitializer.buildServiceStorage();
        final RepositoryStorage repositoryStorage = DependencyInitializer.buildRepositoryStorage(
          serviceStorage: serviceStorage,
        );

        AppBuilderDataWrapper.errorLoggerService = serviceStorage.errorLoggerService;

        return (serviceStorage: serviceStorage, repositoryStorage: repositoryStorage);
      },
      builder: (
        BuildContext context,
        AsyncSnapshot<AppBuilderData?> snapshot,
        Widget? child,
      ) {
        late final Widget _child;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            _child = SizedBox.fromSize(
              size: const Size.square(128),
              child: const FlutterLogo(),
            );
            continue display;
          case ConnectionState.done:
            final AppBuilderData? data = snapshot.data;
            if (data != null) {
              _child = App(
                repositoryStorage: data.repositoryStorage,
                serviceStorage: data.serviceStorage,
              );
            }
            continue display;
          display:
          default:
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _child,
            );
        }
      },
    ),
    onFlutterError: (FlutterErrorDetails details) {
      AppBuilderDataWrapper.errorLoggerService.recordError(details.exception, details.stack);
    },
  );

  final ZoneConfiguration zoneConfiguration = ZoneConfiguration(
    onZoneError: (Object error, StackTrace stackTrace) {
      AppBuilderDataWrapper.errorLoggerService.recordError(error, stackTrace);
    },
  );

  appRunner(
    RunnerConfiguration.guarded(
      widgetConfig: widgetConfiguration,
      zoneConfig: zoneConfiguration,
    ),
  );
}

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
