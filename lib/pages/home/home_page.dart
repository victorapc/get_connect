import 'package:flutter/material.dart';
import 'package:get_connect_example/core/widget/elevated_button_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButtonCustom(text: 'Tese', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
