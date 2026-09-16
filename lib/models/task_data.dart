class TaskData {
  int? id; // ✅ جديد: الـ ID من الـ API
  String title;
  String description;
  String date;
  String time;
  String group;
  String status;
  String? imagePath;

  TaskData({
    this.id, // ✅ اختياري
    required this.title,
    required this.description,
    this.date = '',
    this.time = '',
    this.group = 'Home',
    this.status = 'In Progress',
    this.imagePath,
  });

  // ✅ من JSON (لما بنجيب من الـ API)
  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // ✅ إلى JSON (لما بنبعت للـ API)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}