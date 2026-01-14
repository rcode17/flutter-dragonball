class Planet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  final DateTime? deletedAt;

  const Planet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    this.deletedAt,
  });
}
