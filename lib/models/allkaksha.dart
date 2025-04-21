class KakshaList {
  String id;
  String name;
  String description;
  String createdBy;
  List<String> members;
  String inviteCode;

  KakshaList({
    required this.id,
    required this.name,
    required this.description,
    required this.createdBy,
    required this.members,
    required this.inviteCode,
  });

  // Factory method to create a Kaksha instance from JSON
  factory KakshaList.fromJson(Map<String, dynamic> json) {
    return KakshaList(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdBy: json['createdBy'] ?? '',
      members: List<String>.from(json['members'] ?? []),
      inviteCode: json['inviteCode'] ?? '',
    );
  }

  // Method to convert a Kaksha instance into JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'members': members,
      'inviteCode': inviteCode,
    };
  }
}
