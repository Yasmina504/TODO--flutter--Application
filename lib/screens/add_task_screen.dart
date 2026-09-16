import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/task_data.dart';
import '../repo/task_repo.dart';
import '../widgets/group_icon.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TaskRepo _taskRepo = TaskRepo();

  String? selectedGroup;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  XFile? image;

  bool isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDateAndTime() async {
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

    setState(() {
      selectedDate = date;
      selectedTime = time;
    });
  }

  String get formattedDate {
    if (selectedDate == null) return 'No Date';
    final day = selectedDate!.day.toString().padLeft(2, '0');
    final month = selectedDate!.month.toString().padLeft(2, '0');
    final year = selectedDate!.year.toString();
    return '$day/$month/$year';
  }

  String get formattedTime {
    if (selectedTime == null) return 'No Time';
    final hour = selectedTime!.hourOfPeriod == 0 ? 12 : selectedTime!.hourOfPeriod;
    final minute = selectedTime!.minute.toString().padLeft(2, '0');
    final period = selectedTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // ============================================
  // POST /new_task
  // ============================================
  Future<void> addTask() async {
    // 1. التحقق
    if (titleController.text.trim().isEmpty) {
      _showError('Please enter task title');
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showError('Please enter task description');
      return;
    }

    // 2. نداء الـ API
    setState(() => isLoading = true);

    final result = await _taskRepo.newTask(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (result['success'] == true) {
      // ✅ إنشاء TaskData جديدة عشان نرجعها
      final newTask = TaskData(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        date: formattedDate,
        time: formattedTime,
        group: selectedGroup ?? 'Home',
        imagePath: image?.path,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.green,
        ),
      );

      // ✅ نرجع المهمة الجديدة
      Navigator.pop(context, newTask);
    } else {
      _showError(result['message']);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.chevron_left, size: 28),
                    ),
                    const Expanded(
                      child: Text(
                        'Add Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          color: Color(0xFF252631),
                        ),
                      ),
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
                const SizedBox(height: 42),

                // ✅ صورة
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: image != null
                          ? kIsWeb
                              ? Image.network(
                                  image!.path,
                                  width: 253,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(image!.path),
                                  width: 253,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                          : Image.asset(
                              'lib/assets/images/GettyImages-1315607788 3.png',
                              width: 253,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedFile =
                              await picker.pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() => image = pickedFile);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Pick Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 29),

                _buildTextField(
                  controller: titleController,
                  hintText: 'Title',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                ),
                const SizedBox(height: 16),
                _buildGroupDropdown(),
                const SizedBox(height: 16),
                _buildDateField(),
                const SizedBox(height: 16),

                // ✅ زر الإضافة
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF119B52),
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: const Color(0x66119B52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Add Task',
                            style: TextStyle(fontSize: 16),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9996A3)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF119B52)),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupDropdown() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFD0D0D0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGroup,
          isExpanded: true,
          hint: const Text(
            'Group',
            style: TextStyle(fontSize: 13, color: Color(0xFF9996A3)),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: 'Home',
              child: Row(
                children: [
                  const GroupIcon(
                    color: Color(0xFFFFD9EC),
                    iconColor: Color(0xFFFF2D91),
                    icon: Icons.home,
                  ),
                  const SizedBox(width: 18),
                  const Text('Home'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Personal',
              child: Row(
                children: [
                  const GroupIcon(
                    color: Color(0xFF119B52),
                    iconColor: Colors.white,
                    icon: Icons.person,
                  ),
                  const SizedBox(width: 18),
                  const Text('Personal'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Work',
              child: Row(
                children: [
                  const GroupIcon(
                    color: Colors.black,
                    iconColor: Colors.white,
                    icon: Icons.business_center,
                  ),
                  const SizedBox(width: 18),
                  const Text('Work'),
                ],
              ),
            ),
          ],
          onChanged: (value) => setState(() => selectedGroup = value),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: pickDateAndTime,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFD0D0D0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: Color(0xFF119B52), size: 21),
            const SizedBox(width: 18),
            Text(
              selectedDate == null ? 'End Time' : '$formattedDate $formattedTime',
              style: const TextStyle(fontSize: 13, color: Color(0xFF9996A3)),
            ),
          ],
        ),
      ),
    );
  }
}