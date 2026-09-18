import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import '../widgets/lock_button.dart';
import 'home_screen1.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageHeight = size.height * 0.38;
    final double horizontalPadding = size.width * 0.075;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen1(username: state.username),
              ),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          final isLoading = state is LoginLoadingState;

          return Scaffold(
            backgroundColor: const Color(0xFFF7F8F8),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                    
                      SizedBox(
                        width: double.infinity,
                        height: imageHeight,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'lib/assets/images/GettyImages-1315607788 3.png',
                            width: double.infinity,
                            height: imageHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.025),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: size.height * 0.02,
                        ),
                        child: Column(
                          children: [
                           
                            _buildLoginTextField(
                              controller: cubit.username,
                              hintText: 'Username',
                              prefixIconPath:
                                  'lib/assets/images/Profile - Iconly Pro.svg',
                            ),

                            SizedBox(height: size.height * 0.025),

                         
                            _buildLoginTextField(
                              controller: cubit.password,
                              hintText: 'Password',
                              prefixIconPath:
                                  'lib/assets/images/Password - Iconly Pro.svg',
                              obscureText: cubit.isPasswordSecure,
                              suffixIcon: LockButton(
                                isLocked: cubit.isPasswordSecure,
                                onPressed: () {
                                  cubit.changePassSecure();
                                },
                              ),
                            ),

                            SizedBox(height: size.height * 0.04),

                         
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : cubit.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF119B52),
                                  foregroundColor: Colors.white,
                                  elevation: 6,
                                  shadowColor: const Color(0x66119B52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.02),

                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't Have An Account?",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF5F5D68),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

 
  Widget _buildLoginTextField({
    required TextEditingController controller,
    required String hintText,
    required String prefixIconPath,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Color(0xFF9996A3),
          ),
          prefixIcon: SizedBox(
            width: 40,
            height: 45,
            child: Center(
              child: SvgPicture.asset(
                prefixIconPath,
                width: 19,
                height: 19,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 45,
            maxWidth: 40,
            maxHeight: 45,
          ),
          suffixIcon: SizedBox(
            width: 40,
            height: 45,
            child: Center(child: suffixIcon),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 45,
            maxWidth: 40,
            maxHeight: 45,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFD4D4D4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF119B52),
            ),
          ),
        ),
      ),
    );
  }
}