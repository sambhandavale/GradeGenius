class User {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String userPhoto;
  final String bod;
  final String email;
  final String username;
  final int mobileNumber;
  final String hashedPassword;
  final String salt;
  final String role;
  final String bio;
  final String status;
  final String designation;
  final List<String> teams;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.userPhoto,
    required this.bod,
    required this.email,
    required this.username,
    required this.mobileNumber,
    required this.hashedPassword,
    required this.salt,
    required this.role,
    required this.bio,
    required this.status,
    required this.designation,
    required this.teams,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? '',
      userPhoto: json['user_photo'] ?? 'default.png',
      bod: json['bod'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      mobileNumber: json['mobile_number'] ?? 0,
      hashedPassword: json['hashed_password'] ?? '',
      salt: json['salt'] ?? '',
      role: json['role'] ?? 'student',
      bio: json['bio'] ?? '',
      status: json['status'] ?? '',
      designation: json['designation'] ?? '',
      teams: List<String>.from(json['teams'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'user_photo': userPhoto,
      'bod': bod,
      'email': email,
      'username': username,
      'mobile_number': mobileNumber,
      'hashed_password': hashedPassword,
      'salt': salt,
      'role': role,
      'bio': bio,
      'status': status,
      'designation': designation,
      'teams': teams,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
