import 'package:flutter/material.dart';
import '../models/task_data.dart';
import 'done_task_screen.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskData task;

  const EditTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedGroup;
  late String selectedStatus;
  late String selectedDate;
  late String selectedTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    selectedGroup = widget.task.group;
    selectedStatus = widget.task.status;
    selectedDate = widget.task.date;
    selectedTime = widget.task.time;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void updateTask() {
    if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) {
      return;
    }

    final TaskData updatedTask = TaskData(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: selectedDate,
      time: selectedTime,
      group: selectedGroup,
      status: selectedStatus,
    );

    Navigator.pop(context, updatedTask);
  }

  void deleteTask() {
    Navigator.pop(context, null);
  }

  void markAsDone() {
    if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) {
      return;
    }

    final TaskData doneTask = TaskData(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: selectedDate,
      time: selectedTime,
      group: selectedGroup,
      status: 'Done',
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DoneTaskScreen(
          task: doneTask,
        ),
      ),
    );
  }

  Widget groupIcon() {
    if (selectedGroup == 'Personal') {
      return Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFF119B52),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 21,
        ),
      );
    }

    if (selectedGroup == 'Work') {
      return Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.business_center,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD9EC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.home,
        color: Color(0xFFFF2D91),
        size: 21,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Edit Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF252631),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: deleteTask,
                      child: Container(
                        height: 31,
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3030),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/images/GettyImages-1315607788 3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedStatus,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF454545),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Believe you can, and you're halfway\nthere.",
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.25,
                              color: Color(0xFF454545),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: _showGroupPicker,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        groupIcon(),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            selectedGroup,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF353A3D),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: titleController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF353A3D),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF454545),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 125,
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.25,
                      color: Color(0xFF353A3D),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: pickEditDateAndTime,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Color(0xFF119B52),
                          size: 20,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          selectedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF454545),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          selectedTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF454545),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 68),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: markAsDone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF119B52),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0x55119B52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Mark as Done',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: updateTask,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xFF119B52),
                      side: const BorderSide(
                        color: Color(0xFF119B52),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGroupPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _groupOption('Home'),
              _groupOption('Personal'),
              _groupOption('Work'),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  Widget _groupOption(String group) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedGroup = group;
        });
        Navigator.pop(context);
      },
      leading: group == 'Home'
          ? const Icon(
              Icons.home,
              color: Color(0xFFFF2D91),
            )
          : group == 'Personal'
              ? const Icon(
                  Icons.person,
                  color: Color(0xFF119B52),
                )
              : const Icon(
                  Icons.business_center,
                  color: Colors.black,
                ),
      title: Text(group),
    );
  }

  Future<void> pickEditDateAndTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();

    final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final String minute = time.minute.toString().padLeft(2, '0');
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    setState(() {
      selectedDate = '$day/$month/$year';
      selectedTime = '$hour:$minute $period';
    });
  }
}