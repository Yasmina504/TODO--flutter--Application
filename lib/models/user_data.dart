class UserData {
  final int id;
  final String username;
  final String? imagePath;

  UserData({
    required this.id,
    required this.username,
    this.imagePath,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'image_path': imagePath,
    };
  }
}