import '../../data/model/pogo_model/Item_model.dart';

class RepositoriesListEntity {
  final List<Item> repositories;

  RepositoriesListEntity({required this.repositories});

  factory RepositoriesListEntity.fromJson(Map<String, dynamic> json) {
    return RepositoriesListEntity(
      repositories:
          json['items'] == null
              ? []
              : List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }
}
