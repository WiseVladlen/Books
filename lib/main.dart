import 'dart:async';

import 'package:app_runner/app_runner.dart';
import 'package:books/app.dart';
import 'package:books/data/data.dart';
import 'package:books/domain/domain.dart';
import 'package:flutter/material.dart';

typedef AppBuilderData = ({
  ServiceStorage serviceStorage,
  RepositoryStorage repositoryStorage,
});

Future<void> main() async {
  final ErrorWrapper errorWrapper = ErrorWrapper();

  final WidgetConfiguration widgetConfiguration = WidgetConfiguration(
    child: AppBuilder<AppBuilderData>(
      preInitialize: (WidgetsBinding binding) async {
        WidgetsFlutterBinding.ensureInitialized();

        final ServiceStorage serviceStorage = await DependencyInitializer.buildServiceStorage();
        final RepositoryStorage repositoryStorage = DependencyInitializer.buildRepositoryStorage(
          serviceStorage: serviceStorage,
        );

        errorWrapper.errorLoggerService = serviceStorage.errorLoggerService;

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
            _child = const SizedBox.square(
              dimension: 128,
              child: FlutterLogo(),
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
      errorWrapper.onFlutterError(details);
    },
  );

  final ZoneConfiguration zoneConfiguration = ZoneConfiguration(
    onZoneError: (Object error, StackTrace stackTrace) {
      errorWrapper.onZoneError(error, stackTrace);
    },
  );

  appRunner(
    RunnerConfiguration.guarded(
      widgetConfig: widgetConfiguration,
      zoneConfig: zoneConfiguration,
    ),
  );
}
