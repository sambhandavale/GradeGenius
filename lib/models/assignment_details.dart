class AssignmentDetails {
  String id;
  String title;
  String description;
  Kaksha kaksha;
  String createdBy;
  DateTime dueDate;
  List<Attachment> attachments;
  List<AssignmentSubmission> submissions;
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
      submissions: (json['submissions'] as List)
        .map((s) => AssignmentSubmission.fromJson(s))
        .toList(),

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

class AssignmentSubmission {
  String student;
  DateTime submittedAt;
  List<SubmissionFile> files;
  String id;

  AssignmentSubmission({
    required this.student,
    required this.submittedAt,
    required this.files,
    required this.id,
  });

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmission(
      student: json['student'],
      submittedAt: DateTime.parse(json['submittedAt']),
      files: (json['files'] as List)
          .map((f) => SubmissionFile.fromJson(f))
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': student,
      'submittedAt': submittedAt.toIso8601String(),
      'files': files.map((f) => f.toJson()).toList(),
      '_id': id,
    };
  }
}

class SubmissionFile {
  String fileId;
  String filename;
  String originalName;
  int size;
  String contentType;
  String id;

  SubmissionFile({
    required this.fileId,
    required this.filename,
    required this.originalName,
    required this.size,
    required this.contentType,
    required this.id,
  });

  factory SubmissionFile.fromJson(Map<String, dynamic> json) {
    return SubmissionFile(
      fileId: json['fileId'],
      filename: json['filename'],
      originalName: json['originalName'],
      size: json['size'],
      contentType: json['contentType'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'filename': filename,
      'originalName': originalName,
      'size': size,
      'contentType': contentType,
      '_id': id,
    };
  }
}

