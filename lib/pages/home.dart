import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              minimumSize: Size(120, 48)),
          child: const Text('Sign In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
