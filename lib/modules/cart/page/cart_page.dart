import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CartPage Page"),
      ),
      body: Center(
        child: Text("Cart Page"),
      ),
    );
  }
}
