import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/startup.json',
        repeat: true,
       // alignment: Alignment.center,
       //  fit: BoxFit.contain,
        ),
    );
  }
}
