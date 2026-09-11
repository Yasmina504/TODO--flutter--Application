import 'package:flutter/material.dart';
import '../models/task_data.dart';

class DoneTaskScreen extends StatelessWidget {
  final TaskData task;

  const DoneTaskScreen({
    super.key,
    required this.task,
  });

  static const Color backgroundColor = Color(0xFFF1F3F2);
  static const Color greenColor = Color(0xFF119B52);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF252631),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                      width: 88,
                      height: 88,
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
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF303039),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Congrats!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF303039),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      _buildGroupIcon(),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          task.group,
                          style: const TextStyle(
                            fontSize: 14,
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
                const SizedBox(height: 19),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF353A3D),
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.25,
                      color: Color(0xFF353A3D),
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: greenColor,
                        size: 21,
                      ),
                      const SizedBox(width: 18),
                      Text(
                        task.date,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF353A3D),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Text(
                        task.time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF353A3D),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupIcon() {
    if (task.group == 'Personal') {
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

    if (task.group == 'Work') {
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
}