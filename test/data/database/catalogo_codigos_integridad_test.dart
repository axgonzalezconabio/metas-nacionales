import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/seed/contenido_seed.dart';

void main() {
  late AppDatabase database;
  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    await ContenidoSeed.cargar(database);
  });
  tearDown(() async => database.close());

  group('Auditoría de códigos contra la Guía Rápida 2026', () {
    test('las 47 metas nacionales tienen códigos únicos y formato válido', () async {
      final metas = await database.select(database.metasNacionales).get();
      expect(metas.length, 47);
      expect(metas.map((m) => m.codigo).toSet().length, 47);
      for (final meta in metas) {
        expect(meta.codigo, matches(RegExp(r'^\d+\.\d+$')));
      }
    });

    test('los 366 hitos tienen códigos únicos y meta padre válida', () async {
      final hitos = await database.select(database.hitos).get();
      final metas = await database.select(database.metasNacionales).get();
      final metaPorId = {for (final m in metas) m.id: m.codigo};
      expect(hitos.length, 366);
      expect(hitos.map((h) => h.codigo).toSet().length, 366);
      for (final hito in hitos) {
        final meta = metaPorId[hito.metaNacionalId];
        expect(meta, isNotNull, reason: hito.codigo);
        expect(hito.codigo, startsWith('$meta.'));
        expect(hito.codigo, matches(RegExp(r'^\d+\.\d+\.\d+$')));
        expect(hito.orden, greaterThan(0));
      }
    });

    test('los 40 registros de subhitos tienen 37 códigos distintos y su hito padre', () async {
      final hitos = await database.select(database.hitos).get();
      final subhitos = await database.select(database.subhitos).get();
      final hitoPorId = {for (final h in hitos) h.id: h.codigo};
      expect(subhitos.length, 40);
      expect(subhitos.map((s) => s.codigo).toSet().length, 37);
      for (final subhito in subhitos) {
        final padre = hitoPorId[subhito.hitoId];
        expect(padre, isNotNull, reason: subhito.codigo);
        expect(subhito.codigo, startsWith('$padre.'));
        expect(subhito.codigo, matches(RegExp(r'^\d+\.\d+\.\d+\.\d+$')));
      }
    });

    test('19.3 y 21.2 no tienen hitos definidos en la Guía', () async {
      final hitos = await database.select(database.hitos).get();
      final metas = await database.select(database.metasNacionales).get();
      final metaPorId = {for (final m in metas) m.id: m.codigo};
      expect(hitos.where((h) => metaPorId[h.metaNacionalId] == '19.3'), isEmpty);
      expect(hitos.where((h) => metaPorId[h.metaNacionalId] == '21.2'), isEmpty);
    });
  });
}
