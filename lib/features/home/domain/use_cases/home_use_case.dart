import 'package:dartz/dartz.dart';
import '../entities/repositories_list_entity.dart';
import '../repositories/home_repositories.dart';

class HomeUseCase {
  HomeRepositories homeRepositories;
  HomeUseCase({required this.homeRepositories});

  Future<Either<String, RepositoriesListEntity>> retrieveRepositories({
    required String query,
    required int pageSize,
    required int pageNumber,
    String? sortBy,
    String? order,
  }) async {
    return await homeRepositories.fetchRepositories(
      query: query,
      pageSize: pageSize,
      pageNumber: pageNumber,
      sortBy: sortBy,
      order: order,
    );
  }
}
