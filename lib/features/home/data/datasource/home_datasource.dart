import 'package:dio/dio.dart';

abstract class HomeDatasource {
  Future<Response> getRepositories({
    required String query,
    required int pageSize,
    required int pageNumber,
    String? sortBy,
    String? order,
  });
}
