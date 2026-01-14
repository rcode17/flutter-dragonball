import '../../domain/entities/pagination_meta.dart';

class PaginationMetaModel extends PaginationMeta {
  const PaginationMetaModel({
    required super.totalItems,
    required super.itemCount,
    required super.itemsPerPage,
    required super.totalPages,
    required super.currentPage,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
      itemsPerPage: json['itemsPerPage'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }
}
