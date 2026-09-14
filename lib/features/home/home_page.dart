import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas Nacionales'),
      ),
      body: const Center(
        child: Text(
          'Metas Nacionales de Biodiversidad',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}