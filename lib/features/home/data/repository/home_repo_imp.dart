import 'package:dartz/dartz.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/repositories_list_entity.dart';
import '../../domain/repositories/home_repositories.dart';
import '../datasource/home_datasource.dart';

class HomeRepoImp implements HomeRepositories {
  HomeDatasource homeDatasource;
  HomeRepoImp({required this.homeDatasource});

  @override
  Future<Either<String, RepositoriesListEntity>> fetchRepositories({
    required String query,
    required int pageSize,
    required int pageNumber,
    String? sortBy,
    String? order,
  }) async {
    try {
      final response = await homeDatasource.getRepositories(
        query: query,
        pageSize: pageSize,
        pageNumber: pageNumber,
        sortBy: sortBy,
        order: order,
      );
      if (response.statusCode == 200) {
        return Right(RepositoriesListEntity.fromJson(response.data));
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } on Exception catch (e) {
      Log.info(e.toString());
      return Left('Error: $e');
    } catch (e) {
      Log.info(e.toString());
      return Left('Error: $e');
    }
  }
}
