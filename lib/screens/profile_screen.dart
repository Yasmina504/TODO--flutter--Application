import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/user_data.dart';
import '../repo/auth_repo.dart';
import '../repo/user_repo.dart';
import 'update_profile_screen.dart';
import 'change_password_screen.dart';
import 'language_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color backgroundColor = Color(0xFFF1F3F2);
  static const Color darkText = Color(0xFF303039);

  final UserRepo _userRepo = UserRepo();
  late String _currentUsername;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUsername = widget.username;
    _fetchUserData();
  }

  // ✅ GET /get_user_data
  Future<void> _fetchUserData() async {
    setState(() => _isLoading = true);

    final result = await _userRepo.getUserData();

    if (!mounted) return;

    if (result['success'] == true) {
      final user = result['user'] as UserData;
      setState(() {
        _currentUsername = user.username;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // ✅ تحديث الاسم بعد التعديل
  Future<void> _openUpdateProfile() async {
    final newUsername = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(
          username: _currentUsername,
        ),
      ),
    );

    if (newUsername != null && newUsername.isNotEmpty) {
      setState(() => _currentUsername = newUsername);
    }
  }

  // ✅ Logout
  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await AuthRepo().logout();

    if (!mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      '/',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentUsername);
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.055),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.022),

                  // ============ Header ============
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
                          const Text(
                            'Hello!',
                            style: TextStyle(
                              fontFamily: 'LexendDeca',
                              color: darkText,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          _isLoading
                              ? const SizedBox(
                                  width: 80,
                                  height: 16,
                                  child: LinearProgressIndicator(),
                                )
                              : Text(
                                  _currentUsername,
                                  style: const TextStyle(
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

                  // ============ Profile ============
                  _profileMenuItem(
                    context: context,
                    iconPath: 'lib/assets/images/Profile - Iconly Pro.svg',
                    title: 'Profile',
                    onTap: _openUpdateProfile,
                  ),

                  SizedBox(height: size.height * 0.030),

                  // ============ Change Password ============
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

                  // ============ Settings ============
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

                  SizedBox(height: size.height * 0.030),

                  // ============ Logout ============
                  _profileMenuItem(
                    context: context,
                    iconPath: 'lib/assets/images/Lock - Iconly Pro.png',
                    title: 'Logout',
                    onTap: _logout,
                  ),

                  SizedBox(height: size.height * 0.030),
                ],
              ),
            ),
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
    Color? textColor,
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
                  ? SvgPicture.asset(iconPath, width: 23, height: 23)
                  : Image.asset(iconPath, width: 23, height: 23, fit: BoxFit.contain),
            ),
            SizedBox(width: size.width * 0.055),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  color: textColor ?? darkText,
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