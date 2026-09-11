import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'update_profile_screen.dart';
import 'change_password_screen.dart';
import 'language_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color backgroundColor = Color(0xFFF1F3F2);
  static const Color darkText = Color(0xFF303039);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.022),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'lib/assets/images/GettyImages-1315607788 3.png',
                      width: size.width * 0.17,
                      height: size.width * 0.17,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: size.width * 0.035),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          color: darkText,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ahmed Saber',
                        style: TextStyle(
                          fontFamily: 'LexendDeca',
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.055),
              _profileMenuItem(
                context: context,
                iconPath: 'lib/assets/images/Profile - Iconly Pro.svg',
                title: 'Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.030),
              _profileMenuItem(
                context: context,
                iconPath: 'lib/assets/images/Lock - Iconly Pro.png',
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.030),
              _profileMenuItem(
                context: context,
                iconPath: 'lib/assets/images/Setting - Iconly Pro.png',
                title: 'Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileMenuItem({
    required BuildContext context,
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.078,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.055),
        child: Row(
          children: [
            SizedBox(
              width: 23,
              height: 23,
              child: iconPath.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset(
                      iconPath,
                      width: 23,
                      height: 23,
                    )
                  : Image.asset(
                      iconPath,
                      width: 23,
                      height: 23,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(width: size.width * 0.055),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'LexendDeca',
                  color: darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}