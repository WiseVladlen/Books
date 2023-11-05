import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

typedef DioResponseErrorHandler = void Function(DioException err);

void sendToCrashlytics(DioException err) {
  final Map<String, String> customKeys = <String, String>{
    'exception_type': err.type.toString(),
    'base_url': err.requestOptions.baseUrl,
    'query_parameters': err.requestOptions.queryParameters.toString(),
    'persistent_connection': err.requestOptions.persistentConnection.toString(),
  };

  for (final MapEntry<String, String> entry in customKeys.entries) {
    FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
  }

  FirebaseCrashlytics.instance.recordError(
    err.message,
    err.stackTrace,
    printDetails: true,
  );
}
