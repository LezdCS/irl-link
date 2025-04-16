class KickCategory {
  final int id;
  final String name;
  final String thumbnail;

  KickCategory({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory KickCategory.fromJson(Map<String, dynamic> json) {
    return KickCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
    };
  }
}
