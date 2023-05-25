import '/src/_debug/debug_screen.dart';
import '/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BRColors.black,
          centerTitle: true,
          title: const Text('Bedrock Flutter', style: TextStyle(color: BRColors.white)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(DebugScreen.route);
                },
                icon: const Icon(
                  Icons.settings,
                  color: BRColors.white,
                ))
          ],
        ),
        body: Container());
  }
}
