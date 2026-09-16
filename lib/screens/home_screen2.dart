import 'package:flutter/material.dart';
import '../models/task_data.dart';
import '../repo/task_repo.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'profile_screen.dart';

class HomeScreen2 extends StatefulWidget {
  final String username;

  const HomeScreen2({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  static const Color backgroundColor = Color(0xFFF5F7F6);
  static const Color cardColor = Color(0xFFCDEBDD);
  static const Color greenColor = Color(0xFF119B52);
  static const Color darkText = Color(0xFF353A3D);

  final TaskRepo _taskRepo = TaskRepo();
  late String _currentUsername;

  // ✅ 5 Tasks الأساسية
  final List<TaskData> _defaultTasks = [
    TaskData(
      id: -1,
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      id: -2,
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      id: -3,
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      id: -4,
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
    TaskData(
      id: -5,
      title: 'My First Task',
      description: 'Improve my English skills by trying to speek',
      date: '11/03/2025',
      time: '05:00 PM',
      group: 'Home',
    ),
  ];

  // ✅ المهام من الـ API
  List<TaskData> _apiTasks = [];

  // ✅ كل المهام
  List<TaskData> get tasks => [..._apiTasks, ..._defaultTasks];

  // ✅ مؤشر خفيف (مش هيأثر على الشاشة)
  bool isLoading = false;

  int _localTaskIdCounter = 1000;

  @override
  void initState() {
    super.initState();
    _currentUsername = widget.username;
    
    // ✅ نحمّل في الخلفية من غير Loading
    _loadTasksInBackground();
  }

  // ============================================
  // ✅ تحميل في الخلفية (من غير Loading)
  // ============================================
  Future<void> _loadTasksInBackground() async {
    final result = await _taskRepo.getMyTasks();

    if (!mounted) return;

    if (result['success'] == true) {
      final apiTasks = result['tasks'] as List<TaskData>;

      final Set<int> apiIds = apiTasks
          .where((t) => t.id != null)
          .map((t) => t.id!)
          .toSet();

      final localOnlyTasks = _apiTasks
          .where((t) => t.id != null && t.id! > 0 && !apiIds.contains(t.id))
          .toList();

      setState(() {
        _apiTasks = [...localOnlyTasks, ...apiTasks];
      });
    }
  }

  // ============================================
  // ✅ Refresh (لما المستخدم يعمل Pull)
  // ============================================
  Future<void> _refreshTasks() async {
    await _loadTasksInBackground();
  }

  // ✅ فتح ProfileScreen
  Future<void> _openProfile() async {
    final newUsername = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(username: _currentUsername),
      ),
    );

    if (newUsername != null && newUsername.isNotEmpty) {
      setState(() => _currentUsername = newUsername);
    }
  }

  // ============================================
  // ✅ إضافة مهمة جديدة
  // ============================================
  Future<void> _addNewTask() async {
    final newTask = await Navigator.push<TaskData>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        newTask.id = _localTaskIdCounter++;
        _apiTasks.insert(0, newTask);
      });
      _loadTasksInBackground();
    }
  }

  // ============================================
  // ✅ تعديل مهمة
  // ============================================
  Future<void> _openEditTask(TaskData task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: task),
      ),
    );

    if (result is TaskData) {
      setState(() {
        final index = _apiTasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          _apiTasks[index] = result;
        } else {
          _apiTasks.insert(0, result);
        }
      });
    } else if (result == null) {
      setState(() {
        _apiTasks.removeWhere((t) => t.id == task.id);
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentUsername);
        return false;
      },
      child: Scaffold(
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
                    GestureDetector(
                      onTap: _openProfile,
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/images/GettyImages-1315607788 3.png',
                          width: profileSize,
                          height: profileSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: profileSpacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello!',
                          style: TextStyle(
                            color: Color(0xFF303039),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _currentUsername,
                          style: const TextStyle(
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

                // ✅ التعديل: نعرض دايماً القائمة (5 الأساسية + اللي موجود)
                // مفيش Loading خالص
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshTasks,
                    color: greenColor,
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: size.height * 0.12,
                      ),
                      itemCount: tasks.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: taskSpacing),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openEditTask(tasks[index]),
                          child: TaskCard(
                            task: tasks[index],
                            cardHeight: cardHeight,
                          ),
                        );
                      },
                    ),
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
              onTap: _addNewTask,
              child: Icon(
                Icons.note_add_outlined,
                color: Colors.white,
                size: size.width * 0.065,
              ),
            ),
          ),
        ),
      ),
    );
  }
}