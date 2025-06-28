part of 'injection_container.dart';

Future<void> _initUseCases() async {

 sl.registerLazySingleton(
        () => HomeUseCase(
      homeRepositories: sl.call(),
    ),
  );

}
