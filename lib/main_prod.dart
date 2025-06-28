import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/network/api_end_points.dart';
import 'package:flutter_task/core/services/local_storage/cache_service.dart';
import 'core/bloc/bloc_observer.dart';
import 'core/di/injection_container.dart' as di;
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';
import 'my_app.dart';

void
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeMode =
      await CacheService.instance.retrieveTheme();
  EnvConfig prodConfig = EnvConfig(
    appName:
        "Production",
    baseUrl:
        ApiEndPoints.prodBaseUrl,
    themeMode:
        themeMode,
  );

  BuildConfig.instantiate(
    envType:
        Environment.production,
    envConfig:
        prodConfig,
  );
  Bloc.observer = GlobalBlocObserver();
  await di.init();

  runApp(
    const MyApp(),
  );
}
