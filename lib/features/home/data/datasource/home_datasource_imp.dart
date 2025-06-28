import 'package:dio/dio.dart';
import 'package:flutter_task/features/home/data/datasource/home_datasource.dart';
import '../../../../core/network/api_end_points.dart' show ApiEndPoints;
import '../../../../core/network/rest_client.dart';

class HomeDatasourceImp implements HomeDatasource {
  const HomeDatasourceImp({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> getRepositories({
    required String query,
    required int pageSize,
    required int pageNumber,
    String? sortBy,
    String? order,
  }) async {
    var productsAPIUrl =
         '${ApiEndPoints.repositories}?q=$query';

    final Map<String, dynamic> queryParams = {
      'limit': pageSize,
      'skip': (pageNumber - 1) * pageSize,
    };

    if (sortBy != null && order != null) {
      queryParams['sort'] = sortBy;
      queryParams['order'] = order;
    }

    final response = await restClient.get(
      APIType.public,
      productsAPIUrl,
      data: queryParams,
    );

    return response;
  }
}
