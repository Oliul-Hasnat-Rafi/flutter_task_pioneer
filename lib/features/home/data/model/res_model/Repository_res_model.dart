import '../pogo_model/Item_model.dart';

class RepositoryResModel {
  int? totalCount;
  bool? incompleteResults;
  List<Item>? items;

  RepositoryResModel({this.totalCount, this.incompleteResults, this.items});

  factory RepositoryResModel.fromJson(Map<String, dynamic> json) {
    return RepositoryResModel(
      totalCount: json["total_count"],
      incompleteResults: json["incomplete_results"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "incomplete_results": incompleteResults,
    "items": items?.map((x) => x.toJson()).toList(),
  };
}
