import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                width: 350,
                height: 350,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Image.asset('assets/images/welcome..jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
