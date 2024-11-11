class Student {
  final String id;
  final String name;
  final String email;
  final String enrollmentStatus;
  final String? profilePhotoPath;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.enrollmentStatus,
    this.profilePhotoPath,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      enrollmentStatus: json['enrollmentStatus'],
      profilePhotoPath: json['profilePhotoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enrollmentStatus': enrollmentStatus,
      'profilePhotoPath': profilePhotoPath,
    };
  }
}
