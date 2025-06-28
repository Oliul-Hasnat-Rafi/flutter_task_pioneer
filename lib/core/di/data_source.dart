part of 'injection_container.dart';

Future<
  void
>
_initDataSources() async {

  sl.registerLazySingleton<HomeDatasource>(
        () => HomeDatasourceImp(
      restClient: sl.call(),
    ),
  );

}
