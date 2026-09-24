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

  group('Integridad del contenido del seed', () {
    test('debe cargar una publicación', () async {
      final publicaciones = await database.select(database.publicaciones).get();

      expect(publicaciones.length, 1);
      expect(publicaciones.single.anio, 2026);
      expect(publicaciones.single.edicion, 'Primera edición');
    });

    test('debe cargar los 4 ejes oficiales', () async {
      final ejes = await database.select(database.ejes).get();

      expect(ejes.length, 4);
      expect(ejes.map((e) => e.nombre).toSet(), {
        'Conservar',
        'Evitar',
        'Salvaguardar',
        'Actuar',
      });
    });

    test('debe cargar las 23 metas globales', () async {
      final metas = await database.select(database.metasGlobales).get();

      expect(metas.length, 23);
      expect(metas.map((m) => m.codigo).toSet(), {
        for (var i = 1; i <= 23; i++) '$i',
      });
    });

    test('debe cargar exactamente las 47 metas nacionales oficiales', () async {
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
      final encontrados = metas.map((m) => m.codigo).toSet();

      expect(metas.length, 47);
      expect(encontrados, codigos);
    });

    test('todas las metas nacionales tienen eje y meta global válidos', () async {
      final ejes = await database.select(database.ejes).get();
      final globales = await database.select(database.metasGlobales).get();

      final ejeIds = ejes.map((e) => e.id).toSet();
      final globalIds = globales.map((m) => m.id).toSet();

      final metas = await database.select(database.metasNacionales).get();
      for (final meta in metas) {
        expect(
          ejeIds.contains(meta.ejeId),
          isTrue,
          reason: 'Meta ${meta.codigo}: ejeId inválido ${meta.ejeId}',
        );

        expect(
          globalIds.contains(meta.metaGlobalId),
          isTrue,
          reason:
              'Meta ${meta.codigo}: metaGlobalId inválido ${meta.metaGlobalId}',
        );

        expect(
          meta.nombre.trim(),
          isNotEmpty,
          reason: 'Meta ${meta.codigo}: nombre vacío',
        );

        expect(
          meta.descripcion?.trim(),
          isNotEmpty,
          reason: 'Meta ${meta.codigo}: descripción=[${meta.descripcion}]',
        );
      }
    });

    test('las metas nacionales están asignadas al eje correcto', () async {
      const conservar = {
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
      };
      const evitar = {
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
      };
      const salvaguardar = {
        '9.0',
        '10.1',
        '10.2',
        '10.3',
        '10.4',
        '10.5',
        '11.0',
        '12.0',
        '13.0',
      };
      const actuar = {
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

      final ejes = await database.select(database.ejes).get();
      final ejePorId = {for (final eje in ejes) eje.id: eje.nombre};

      final metas = await database.select(database.metasNacionales).get();

      for (final meta in metas) {
        final eje = ejePorId[meta.ejeId];

        if (conservar.contains(meta.codigo)) {
          expect(eje, 'Conservar', reason: meta.codigo);
        } else if (evitar.contains(meta.codigo)) {
          expect(eje, 'Evitar', reason: meta.codigo);
        } else if (salvaguardar.contains(meta.codigo)) {
          expect(eje, 'Salvaguardar', reason: meta.codigo);
        } else if (actuar.contains(meta.codigo)) {
          expect(eje, 'Actuar', reason: meta.codigo);
        } else {
          fail('Meta nacional no contemplada: ${meta.codigo}');
        }
      }
    });

    test('los hitos actuales del seed tienen relaciones válidas', () async {
      final metas = await database.select(database.metasNacionales).get();
      final metaIds = metas.map((m) => m.id).toSet();

      final referencias = await database
          .select(database.referenciasOrigen)
          .get();
      final referenciaIds = referencias.map((r) => r.id).toSet();

      final hitos = await database.select(database.hitos).get();

      // 1.1 = 17, 1.2 = 8, 1.3 = 5, 1.4 = 13.
      expect(hitos.length, 366);

      final subhitos = await database.select(database.subhitos).get();
      expect(subhitos.length, 37);
      expect(
        subhitos.map((s) => s.codigo).toSet(),
        containsAll(<String>{
          '2.3.1.1',
          '4.0.1.1',
          '4.0.1.2',
          '4.0.1.3',
          '4.0.1.4',
          '4.0.1.5',
          '4.0.1.6',
          '4.0.1.7',
          '8.1.12.1',
          '14.1.3.1',
          '14.1.3.2',
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
          '21.1.2.1',
          '21.1.2.2',
          '21.1.3.1',
          '21.1.3.2',
        }),
      );
      expect(
        hitos.map((h) => h.codigo).toSet().length,
        hitos.length,
        reason: 'No debe haber códigos de hito duplicados.',
      );

      for (final hito in hitos) {
        expect(
          metaIds.contains(hito.metaNacionalId),
          isTrue,
          reason:
              'Hito ${hito.codigo}: meta nacional inexistente '
              '${hito.metaNacionalId}',
        );

        expect(
          referenciaIds.contains(hito.referenciaOrigenId),
          isTrue,
          reason:
              'Hito ${hito.codigo}: referencia inexistente '
              '${hito.referenciaOrigenId}',
        );

        expect(hito.codigo.trim(), isNotEmpty);
        expect(hito.descripcion?.trim(), isNotEmpty);
      }
    });

    test(
      'los hitos están asociados a las metas nacionales correctas',
      () async {
        final metas = await database.select(database.metasNacionales).get();
        final metaPorId = {for (final meta in metas) meta.id: meta.codigo};

        final hitos = await database.select(database.hitos).get();

        for (final hito in hitos) {
          final metaCodigo = metaPorId[hito.metaNacionalId];

          expect(
            hito.codigo.startsWith('$metaCodigo.'),
            isTrue,
            reason:
                'El hito ${hito.codigo} no corresponde a la meta $metaCodigo.',
          );
        }
      },
    );

    test('las referencias de origen del seed son de la Guía 2026', () async {
      final referencias = await database
          .select(database.referenciasOrigen)
          .get();

      expect(referencias, isNotEmpty);

      for (final referencia in referencias) {
        expect(referencia.documento, contains('Metas Nacionales'));
        expect(referencia.edicion, 'Primera edición');
        expect(referencia.anio, 2026);
        expect(referencia.pagina, isNotNull);
        expect(referencia.seccion, isNotNull);
      }
    });

    test(
      'el contenido debe poder cargarse dentro de una transacción completa',
      () async {
        final publicaciones = await database
            .select(database.publicaciones)
            .get();
        final ejes = await database.select(database.ejes).get();
        final globales = await database.select(database.metasGlobales).get();
        final nacionales = await database
            .select(database.metasNacionales)
            .get();
        final hitos = await database.select(database.hitos).get();

        expect(publicaciones.length, 1);
        expect(ejes.length, 4);
        expect(globales.length, 23);
        expect(nacionales.length, 47);
        expect(hitos.length, 366);
      },
    );
  });
}
