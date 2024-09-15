import '/src/_debug/debug_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bedrock Flutter'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DebugScreen()),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                ))
          ],
        ),
        body: Container());
  }
}
