import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              Get.toNamed("/cart");
            },
            child: Text("Home Page")),
      ),
    );
  }
}
