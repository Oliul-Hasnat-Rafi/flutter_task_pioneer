import 'package:flutter/material.dart';
import 'core/services/local_storage/cache_service.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';
import 'my_app.dart';

Future<
  void
>
main() async {
  final themeMode =
      await CacheService.instance.retrieveTheme();
  EnvConfig devConfig = EnvConfig(
    appName:
        "Development",
    baseUrl:
        "https://api.github.com",
    themeMode:
        themeMode,
  );

  BuildConfig.instantiate(
    envType:
        Environment.development,
    envConfig:
        devConfig,
  );

  runApp(
    const MyApp(),
  );
}
