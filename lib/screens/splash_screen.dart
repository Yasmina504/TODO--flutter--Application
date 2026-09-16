import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'home_screen1.dart';
import 'lets_start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final isLoggedIn = await UserService.isLoggedIn();
    final username = await UserService.getUsername();

    if (!mounted) return;

    if (isLoggedIn && username != null && username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen1(username: username),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LetsStartScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: Image.asset(
            'lib/assets/images/Group 1000002807.png',
            width: size.width * 0.70,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}