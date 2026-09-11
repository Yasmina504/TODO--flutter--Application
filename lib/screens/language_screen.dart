import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'EN';

  static const Color backgroundColor = Color(0xFFF1F3F2);
  static const Color greenColor = Color(0xFF119B52);
  static const Color darkText = Color(0xFF303039);
  static const Color greyColor = Color(0xFFD6D6D6);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.055),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.022),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const SizedBox(
                      width: 30,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'LexendDeca',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF252631),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              SizedBox(height: size.height * 0.045),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(
                      fontFamily: 'LexendDeca',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: darkText,
                    ),
                  ),
                  Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLanguage = 'AR';
                            });
                          },
                          child: Container(
                            height: 31,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: selectedLanguage == 'AR' ? greenColor : greyColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'AR',
                              style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: selectedLanguage == 'AR' ? Colors.white : const Color(0xFF303039),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLanguage = 'EN';
                            });
                          },
                          child: Container(
                            height: 31,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: selectedLanguage == 'EN' ? greenColor : greyColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'EN',
                              style: TextStyle(
                                fontFamily: 'LexendDeca',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: selectedLanguage == 'EN' ? Colors.white : const Color(0xFF303039),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}