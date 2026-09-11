import 'package:flutter/material.dart';
import '../models/task_data.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  static const Color backgroundColor = Color(0xFFF5F7F6);
  static const Color cardColor = Color(0xFFCDEBDD);
  static const Color greenColor = Color(0xFF119B52);
  static const Color darkText = Color(0xFF353A3D);

  List<TaskData> tasks = [
    TaskData(
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
  ];

  Future<void> openEditTask(int index) async {
    final TaskData? updatedTask = await Navigator.push<TaskData>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: tasks[index],
        ),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        tasks[index] = updatedTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.055;
    final double profileSize = size.width * 0.18;
    final double profileSpacing = size.width * 0.035;
    final double topPadding = size.height * 0.035;
    final double tasksTopSpacing = size.height * 0.055;
    final double taskSpacing = size.height * 0.025;
    final double cardHeight = size.height * 0.115;
    final double floatingButtonSize = size.width * 0.14;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'lib/assets/images/GettyImages-1315607788 3.png',
                      width: profileSize,
                      height: profileSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: profileSpacing),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          color: Color(0xFF303039),
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Ahmed Saber',
                        style: TextStyle(
                          color: Color(0xFF303039),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: tasksTopSpacing),
              Row(
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 16,
                      color: darkText,
                    ),
                  ),
                  SizedBox(width: size.width * 0.06),
                  Container(
                    width: size.width * 0.055,
                    height: size.width * 0.055,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '${tasks.length}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: size.height * 0.12),
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) => SizedBox(height: taskSpacing),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        openEditTask(index);
                      },
                      child: TaskCard(
                        task: tasks[index],
                        cardHeight: cardHeight,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: floatingButtonSize,
        height: floatingButtonSize,
        decoration: BoxDecoration(
          color: greenColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.22),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () async {
              final TaskData? newTask = await Navigator.push<TaskData>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTaskScreen(),
                ),
              );

              if (newTask != null) {
                setState(() {
                  tasks.add(newTask);
                });
              }
            },
            child: Icon(
              Icons.note_add_outlined,
              color: Colors.white,
              size: size.width * 0.065,
            ),
          ),
        ),
      ),
    );
  }
}