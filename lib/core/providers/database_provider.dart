import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/database/database_initializer.dart';

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database = AppDatabase();

  try {
    final initializer = DatabaseInitializer(database);

    await initializer.inicializar();

    ref.onDispose(() {
      database.close();
    });

    return database;
  } catch (_) {
    await database.close();
    rethrow;
  }
});