class Project {
  final String id;
  final String name;
  final String imageUrl;

  Project({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Project.fromFirestore(Map<String, dynamic> data, String id) {
    return Project(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}