import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          'assets/audio-waves.json',
          width: size.width * .5,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Running record through AI model...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
