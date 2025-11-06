import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Платформа безопасного общения',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color.fromARGB(255, 156, 163, 175),
      ),
    );
  }
}