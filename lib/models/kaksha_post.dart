class Post {
  final String id;
  final String title;
  final String content;
  final CreatedBy createdBy;
  final DateTime createdAt;
  final String type;
  final String? typeId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.createdBy,
    required this.createdAt,
    required this.type,
    this.typeId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      type: json['type'] ?? 'announcement',
      typeId: json['typeId'],
    );
  }
}

class CreatedBy {
  final String id;
  final String email;
  final String role;
  final String username;

  CreatedBy({
    required this.id,
    required this.email,
    required this.role,
    required this.username,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      username: json['username'] ?? '', // fallback in case username is missing
    );
  }
}
