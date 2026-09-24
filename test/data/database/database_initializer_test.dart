import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/database/database_initializer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'inicializa el contenido oficial en una base nueva',
    () async {
      final initializer = DatabaseInitializer(db);

      await initializer.inicializar();

      final metas = await db.select(db.metasNacionales).get();
      final hitos = await db.select(db.hitos).get();
      final subhitos = await db.select(db.subhitos).get();

      expect(metas.length, 47);
      expect(hitos.length, 366);
      expect(subhitos.length, 37);
    },
  );

  test(
    'guarda la versión del contenido',
    () async {
      final initializer = DatabaseInitializer(db);

      await initializer.inicializar();

      final configuracion = await db
          .select(db.configuracionContenido)
          .getSingle();

      expect(configuracion.clave, 'contenido_version');
      expect(configuracion.valor, '1');
    },
  );

  test(
    'no vuelve a cargar el contenido si ya está inicializado',
    () async {
      final initializer = DatabaseInitializer(db);

      await initializer.inicializar();

      final metasAntes = await db.select(db.metasNacionales).get();
      final hitosAntes = await db.select(db.hitos).get();
      final subhitosAntes = await db.select(db.subhitos).get();

      await initializer.inicializar();

      final metasDespues = await db.select(db.metasNacionales).get();
      final hitosDespues = await db.select(db.hitos).get();
      final subhitosDespues = await db.select(db.subhitos).get();

      expect(metasDespues.length, metasAntes.length);
      expect(hitosDespues.length, hitosAntes.length);
      expect(subhitosDespues.length, subhitosAntes.length);
    },
  );
}