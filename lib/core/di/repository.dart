part of 'injection_container.dart';

Future<
  void
>
_initRepositories() async {
  sl.registerLazySingleton<
    HomeRepositories
  >(
    () => HomeRepoImp(
      homeDatasource:
          sl.call(),
    ),
  );
}
