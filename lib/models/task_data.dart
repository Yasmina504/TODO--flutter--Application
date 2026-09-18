class TaskData {
  int? id; 
  String title;
  String description;
  String date;
  String time;
  String group;
  String status;
  String? imagePath;

  TaskData({
    this.id,
    required this.title,
    required this.description,
    this.date = '',
    this.time = '',
    this.group = 'Home',
    this.status = 'In Progress',
    this.imagePath,
  });


  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
