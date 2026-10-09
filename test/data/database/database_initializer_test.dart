import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/database/database_initializer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  test('inicializa el contenido oficial en una base nueva', () async {
    await DatabaseInitializer(db).inicializar();
    expect((await db.select(db.metasNacionales).get()).length, 47);
    expect((await db.select(db.hitos).get()).length, 366);
    expect((await db.select(db.subhitos).get()).length, 40);
  });

  test('guarda la versión del contenido', () async {
    await DatabaseInitializer(db).inicializar();
    final config = await db.select(db.configuracionContenido).getSingle();
    expect(config.clave, 'contenido_version');
    expect(config.valor, '1');
  });

  test('no vuelve a cargar el contenido si ya está inicializado', () async {
    final initializer = DatabaseInitializer(db);
    await initializer.inicializar();
    final antes = [
      (await db.select(db.metasNacionales).get()).length,
      (await db.select(db.hitos).get()).length,
      (await db.select(db.subhitos).get()).length,
    ];
    await initializer.inicializar();
    expect([
      (await db.select(db.metasNacionales).get()).length,
      (await db.select(db.hitos).get()).length,
      (await db.select(db.subhitos).get()).length,
    ], antes);
  });
}
