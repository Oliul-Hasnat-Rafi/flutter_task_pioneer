import 'package:get_it/get_it.dart';

import '../../features/home/data/datasource/home_datasource.dart';
import '../../features/home/data/datasource/home_datasource_imp.dart';
import '../../features/home/data/repository/home_repo_imp.dart';
import '../../features/home/domain/repositories/home_repositories.dart' show HomeRepositories;
import '../../features/home/domain/use_cases/home_use_case.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../base/blocs/base_bloc.dart';
import '../base/blocs/base_state.dart';
import '../network/rest_client.dart';

part 'bloc.dart';
part 'data_source.dart';
part 'repository.dart';
part 'use_case.dart';

final sl =
    GetIt.instance;

Future<
  void
>
init() async {
  /// Bloc
  await _initBlocs();

  /// UseCase
  await _initUseCases();

  /// Repository
  await _initRepositories();

  /// Datasource
  await _initDataSources();

  /// Network
  final restClient =
      RestClient();
  sl.registerLazySingleton(
    () =>
        restClient,
  );
}
