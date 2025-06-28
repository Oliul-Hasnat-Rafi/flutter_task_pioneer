import 'package:dartz/dartz.dart';
import '../entities/repositories_list_entity.dart';

abstract class HomeRepositories {
  Future<Either<String, RepositoriesListEntity>> fetchRepositories({
    required String query,
    required int pageSize,
    required int pageNumber,
    String? sortBy,
    String? order,
  });
}
