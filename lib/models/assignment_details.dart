class AssignmentDetails {
  String id;
  String title;
  String description;
  Kaksha kaksha;
  String createdBy;
  DateTime dueDate;
  List<Attachment> attachments;
  List<dynamic> submissions;
  DateTime createdAt;
  DateTime updatedAt;

  AssignmentDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.kaksha,
    required this.createdBy,
    required this.dueDate,
    required this.attachments,
    required this.submissions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AssignmentDetails.fromJson(Map<String, dynamic> json) {
    return AssignmentDetails(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      kaksha: Kaksha.fromJson(json['kaksha']),
      createdBy: json['createdBy'],
      dueDate: DateTime.parse(json['dueDate']),
      attachments: (json['attachments'] as List)
          .map((attachment) => Attachment.fromJson(attachment))
          .toList(),
      submissions: json['submissions'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'kaksha': kaksha.toJson(),
      'createdBy': createdBy,
      'dueDate': dueDate.toIso8601String(),
      'attachments': attachments.map((attachment) => attachment.toJson()).toList(),
      'submissions': submissions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Kaksha {
  String id;
  String name;
  String description;

  Kaksha({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Kaksha.fromJson(Map<String, dynamic> json) {
    return Kaksha(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
    };
  }
}

class Attachment {
  String fileId;
  String filename;
  String id;

  Attachment({
    required this.fileId,
    required this.filename,
    required this.id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      fileId: json['fileId'],
      filename: json['filename'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'filename': filename,
      '_id': id,
    };
  }
}
