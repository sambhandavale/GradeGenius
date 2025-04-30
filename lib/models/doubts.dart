class Doubt {
  final String id;
  final String question;
  final AskedBy askedBy;
  final int plusOnes;
  final List<String> plusOneBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? answer; // optional
  final AskedBy? answeredBy; // optional

  Doubt({
    required this.id,
    required this.question,
    required this.askedBy,
    required this.plusOnes,
    required this.plusOneBy,
    required this.createdAt,
    required this.updatedAt,
    this.answer,
    this.answeredBy,
  });

  factory Doubt.fromJson(Map<String, dynamic> json) {
    return Doubt(
      id: json['_id'],
      question: json['question'],
      askedBy: AskedBy.fromJson(json['askedBy']),
      plusOnes: json['plusOnes'],
      plusOneBy: List<String>.from(json['plusOneBy']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      answer: json['answer'],
      answeredBy: json['answeredBy'] != null ? AskedBy.fromJson(json['answeredBy']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question,
      'askedBy': askedBy.toJson(),
      'plusOnes': plusOnes,
      'plusOneBy': plusOneBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'answer': answer,
      'answeredBy': answeredBy?.toJson(),
    };
  }
}



class AskedBy {
  final String id;
  final String email;
  final String role;
  final String username;

  AskedBy({
    required this.id,
    required this.email,
    required this.role,
    required this.username,
  });

  factory AskedBy.fromJson(Map<String, dynamic> json) {
    return AskedBy(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      username:json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'role': role,
      'username':username,
    };
  }
}