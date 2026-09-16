import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_screen.dart';
import 'home_screen2.dart';

class HomeScreen1 extends StatefulWidget {
  final String username;

  const HomeScreen1({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  late String _currentUsername;

  @override
  void initState() {
    super.initState();
    _currentUsername = widget.username;
  }

  // ✅ فتح ProfileScreen وانتظار الاسم الجديد
  Future<void> _openProfile() async {
    final newUsername = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          username: _currentUsername,
        ),
      ),
    );

    // ✅ لو رجع اسم جديد، حدّثه
    if (newUsername != null && newUsername.isNotEmpty) {
      setState(() {
        _currentUsername = newUsername;
      });
    }
  }

  // ✅ فتح HomeScreen2 مع تمرير الاسم
  void _openTasks() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen2(
          username: _currentUsername,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: SafeArea(
        child: Stack(
          children: [
            // ============ Header (Avatar + Username) ============
            Positioned(
              top: size.height * 0.025,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _openProfile,
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/images/GettyImages-1315607788 3.png',
                        width: size.width * 0.20,
                        height: size.width * 0.20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.045),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello!',
                        style: TextStyle(
                          color: Color(0xFF303039),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _currentUsername,
                        style: const TextStyle(
                          color: Color(0xFF303039),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ============ Empty State Message ============
            Positioned(
              top: size.height * 0.40,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Column(
                children: const [
                  Text(
                    'There are no tasks yet,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF303039),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Press the button',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF303039),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'To add New Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF303039),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // ============ Illustration ============
            Positioned(
              top: size.height * 0.54,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: SizedBox(
                height: size.height * 0.28,
                child: Transform.scale(
                  scale: 1.15,
                  child: SvgPicture.asset(
                    'lib/assets/images/55024598_9264826 1.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // ============ Floating Button ============
            Positioned(
              right: size.width * 0.06,
              bottom: size.height * 0.025,
              child: GestureDetector(
                onTap: _openTasks,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF119B52),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.note_add_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}