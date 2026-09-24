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

  tearDown(() async {
    await database.close();
  });

  group('Auditoría de códigos contra la Guía Rápida 2026', () {
    test(
      'las 47 metas nacionales tienen exactamente sus códigos oficiales',
      () async {
        const codigos = {
          '1.1',
          '1.2',
          '1.3',
          '1.4',
          '2.1',
          '2.2',
          '2.3',
          '3.1',
          '3.2',
          '4.0',
          '5.0',
          '6.1',
          '6.2',
          '6.3',
          '7.1',
          '7.2',
          '7.3',
          '7.4',
          '7.5',
          '8.1',
          '8.2',
          '9.0',
          '10.1',
          '10.2',
          '10.3',
          '10.4',
          '10.5',
          '11.0',
          '12.0',
          '13.0',
          '14.1',
          '14.2',
          '15.0',
          '16.0',
          '17.1',
          '17.2',
          '18.0',
          '19.1',
          '19.2',
          '19.3',
          '19.4',
          '20.1',
          '20.2',
          '21.1',
          '21.2',
          '22.0',
          '23.0',
        };

        final metas = await database.select(database.metasNacionales).get();
        expect(metas.length, 47);
        expect(metas.map((m) => m.codigo).toSet(), codigos);
      },
    );

    test(
      'los 366 hitos principales tienen códigos completos y sin duplicados',
      () async {
        const hitosPorMeta = <String, int>{
          '1.1': 17,
          '1.2': 8,
          '1.3': 5,
          '1.4': 13,
          '2.1': 6,
          '2.2': 15,
          '2.3': 10,
          '3.1': 9,
          '3.2': 8,
          '4.0': 9,
          '5.0': 5,
          '6.1': 7,
          '6.2': 7,
          '6.3': 8,
          '7.1': 8,
          '7.2': 13,
          '7.3': 9,
          '7.4': 2,
          '7.5': 20,
          '8.1': 13,
          '8.2': 9,
          '9.0': 7,
          '10.1': 5,
          '10.2': 6,
          '10.3': 11,
          '10.4': 6,
          '10.5': 8,
          '11.0': 8,
          '12.0': 6,
          '13.0': 16,
          '14.1': 5,
          '14.2': 9,
          '15.0': 6,
          '16.0': 12,
          '17.1': 5,
          '17.2': 4,
          '18.0': 6,
          '19.1': 7,
          '19.2': 3,
          '19.3': 0,
          '19.4': 8,
          '20.1': 7,
          '20.2': 2,
          '21.1': 3,
          '21.2': 0,
          '22.0': 5,
          '23.0': 10,
        };

        final hitos = await database.select(database.hitos).get();
        final metas = await database.select(database.metasNacionales).get();
        final metaPorId = {for (final meta in metas) meta.id: meta.codigo};

        expect(hitos.length, 366);
        expect(hitos.map((h) => h.codigo).toSet().length, 366);

        for (final entry in hitosPorMeta.entries) {
          final metaCodigo = entry.key;
          final esperados = entry.value;
          final deMeta = hitos
              .where((hito) => metaPorId[hito.metaNacionalId] == metaCodigo)
              .toList();

          expect(deMeta.length, esperados, reason: 'Meta $metaCodigo');

          final codigos = deMeta.map((hito) => hito.codigo).toSet();
          final codigosEsperados = {
            for (var i = 1; i <= esperados; i++) '$metaCodigo.$i',
          };

          expect(codigos, codigosEsperados, reason: 'Códigos de $metaCodigo');
          expect(
            deMeta.every((hito) => hito.orden >= 1 && hito.orden <= esperados),
            isTrue,
            reason: 'Orden de hitos de $metaCodigo',
          );
        }

        expect(
          hitos.where(
            (hito) => hito.codigo.contains(RegExp(r'\.\d+\.\d+\.\d+')),
          ),
          isEmpty,
          reason: 'Los códigos de subhitos no deben existir en Hitos.',
        );
      },
    );

    test('los 37 subhitos tienen exactamente su hito padre', () async {
      const subhitosPorHito = <String, List<String>>{
        '2.3.1': ['2.3.1.1'],
        '4.0.1': [
          '4.0.1.1',
          '4.0.1.2',
          '4.0.1.3',
          '4.0.1.4',
          '4.0.1.5',
          '4.0.1.6',
          '4.0.1.7',
        ],
        '8.1.12': ['8.1.12.1', '8.1.12.2', '8.1.12.3', '8.1.12.4', '8.1.12.5'],
        '14.1.3': ['14.1.3.1', '14.1.3.2'],
        '21.1.1': [
          '21.1.1.1',
          '21.1.1.2',
          '21.1.1.3',
          '21.1.1.4',
          '21.1.1.5',
          '21.1.1.6',
          '21.1.1.7',
          '21.1.1.8',
          '21.1.1.9',
          '21.1.1.10',
          '21.1.1.11',
          '21.1.1.12',
          '21.1.1.13',
          '21.1.1.14',
          '21.1.1.15',
          '21.1.1.16',
          '21.1.1.17',
          '21.1.1.18',
        ],
        '21.1.2': ['21.1.2.1', '21.1.2.2'],
        '21.1.3': ['21.1.3.1', '21.1.3.2'],
      };

      final hitos = await database.select(database.hitos).get();
      final subhitos = await database.select(database.subhitos).get();
      final hitoPorId = {for (final hito in hitos) hito.id: hito.codigo};

      expect(subhitos.length, 37);
      expect(subhitos.map((s) => s.codigo).toSet().length, 37);

      final esperados = <String, String>{};
      for (final entry in subhitosPorHito.entries) {
        for (final codigo in entry.value) {
          esperados[codigo] = entry.key;
        }
      }

      expect(subhitos.map((s) => s.codigo).toSet(), esperados.keys.toSet());

      for (final subhito in subhitos) {
        expect(
          hitoPorId[subhito.hitoId],
          esperados[subhito.codigo],
          reason: 'Padre de ${subhito.codigo}',
        );
      }
    });

    test('19.3 y 21.2 no tienen hitos definidos en la Guía', () async {
      final hitos = await database.select(database.hitos).get();
      final metas = await database.select(database.metasNacionales).get();
      final metaPorId = {for (final meta in metas) meta.id: meta.codigo};

      expect(
        hitos.where((hito) => metaPorId[hito.metaNacionalId] == '19.3'),
        isEmpty,
      );
      expect(
        hitos.where((hito) => metaPorId[hito.metaNacionalId] == '21.2'),
        isEmpty,
      );
    });
  });
}
