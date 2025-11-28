import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/Raven.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 10),
        const Text(
          'Raven',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.normal,
            fontFamily: 'Roboto',
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 3,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ],
    );
  }
}