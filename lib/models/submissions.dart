class Submission {
  final Student student;
  final DateTime submittedAt;
  final List<SubmissionFile> files;
  final String id;

  Submission({
    required this.student,
    required this.submittedAt,
    required this.files,
    required this.id,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      student: Student.fromJson(json['student']),
      submittedAt: DateTime.parse(json['submittedAt']),
      files: (json['files'] as List<dynamic>)
          .map((file) => SubmissionFile.fromJson(file))
          .toList(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': student.toJson(),
      'submittedAt': submittedAt.toIso8601String(),
      'files': files.map((f) => f.toJson()).toList(),
      '_id': id,
    };
  }
}

class Student {
  final String id;
  final String email;
  final String username;

  Student({
    required this.id,
    required this.email,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      email: json['email'],
      username:json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username':username,
    };
  }
}

class SubmissionFile {
  final String fileId;
  final String filename;
  final String originalName;
  final int size;
  final String contentType;
  final String id;

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
