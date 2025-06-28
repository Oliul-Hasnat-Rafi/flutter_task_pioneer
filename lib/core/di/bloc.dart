part of 'injection_container.dart';

Future<void> _initBlocs() async {
  sl.registerFactory(() => BaseBloc(BaseState.initial()));

   sl.registerFactory(() => HomeBloc(homeUseCase: sl.call()
       
      ));
}
