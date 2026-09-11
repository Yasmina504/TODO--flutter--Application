class TaskData {
  String title;
  String description;
  String date;
  String time;
  String group;
  String status;

  TaskData({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.group = 'Home',
    this.status = 'In Progress',
  });
}