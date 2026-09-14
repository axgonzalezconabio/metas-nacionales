import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metas_nacionales/core/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MetasNacionalesApp(),
    ),
  );
}

class MetasNacionalesApp extends StatelessWidget {
  const MetasNacionalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metas Nacionales de Biodiversidad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}