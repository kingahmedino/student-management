class Student {
  final String id;
  final String name;
  final String email;
  final String enrollmentStatus;
  final String? profilePhotoUrl;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.enrollmentStatus,
    this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enrollmentStatus': enrollmentStatus,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      enrollmentStatus: json['enrollmentStatus'],
      profilePhotoUrl: json['profilePhotoUrl'],
    );
  }
}
