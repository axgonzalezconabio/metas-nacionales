import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

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

  group('ContenidoSeed', () {
    test('carga una publicación', () async {
      final publicaciones =
          await database.select(database.publicaciones).get();

      expect(publicaciones.length, 1);

      expect(
        publicaciones.first.nombre,
        'Metas Nacionales para la implementación del Marco Mundial de Biodiversidad Kunming-Montreal en México',
      );

      expect(publicaciones.first.anio, 2026);
    });

    test('carga los cuatro ejes de acción', () async {
      final ejes = await database.select(database.ejes).get();

      expect(ejes.length, 4);

      expect(
        ejes.map((e) => e.nombre).toList(),
        [
          'Conservar',
          'Evitar',
          'Salvaguardar',
          'Actuar',
        ],
      );
    });

    test('carga las 23 metas globales', () async {
      final metasGlobales =
          await database.select(database.metasGlobales).get();

      expect(metasGlobales.length, 23);

      final codigos =
          metasGlobales.map((meta) => meta.codigo).toSet();

      expect(codigos.length, 23);

      for (var i = 1; i <= 23; i++) {
        expect(codigos.contains(i.toString()), isTrue);
      }
    });

    test('distribuye las 23 metas globales entre los cuatro ejes', () async {
      final ejes = await database.select(database.ejes).get();
      final metasGlobales =
          await database.select(database.metasGlobales).get();

      final ejePorNombre = {
        for (final eje in ejes) eje.nombre: eje.id,
      };

      final conteos = <String, int>{
        'Conservar': 0,
        'Evitar': 0,
        'Salvaguardar': 0,
        'Actuar': 0,
      };

      for (final meta in metasGlobales) {
        final eje = ejes.firstWhere(
          (eje) => eje.id == meta.ejeId,
        );

        conteos[eje.nombre] = conteos[eje.nombre]! + 1;
      }

      expect(conteos['Conservar'], 4);
      expect(conteos['Evitar'], 4);
      expect(conteos['Salvaguardar'], 5);
      expect(conteos['Actuar'], 10);

      expect(ejePorNombre.length, 4);
    });

    test('carga las 47 metas nacionales', () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      expect(metasNacionales.length, 47);
    });

    test('los códigos de las metas nacionales son únicos', () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      final codigos =
          metasNacionales.map((meta) => meta.codigo).toList();

      expect(codigos.toSet().length, 47);
    });

    test('contiene todos los códigos oficiales de las 47 metas nacionales',
        () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      final codigos =
          metasNacionales.map((meta) => meta.codigo).toSet();

      const esperados = {
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

      expect(codigos, equals(esperados));
    });

    test('todas las metas nacionales tienen eje y meta global', () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      final ejes = await database.select(database.ejes).get();

      final metasGlobales =
          await database.select(database.metasGlobales).get();

      final idsEjes = ejes.map((eje) => eje.id).toSet();
      final idsMetasGlobales =
          metasGlobales.map((meta) => meta.id).toSet();

      for (final meta in metasNacionales) {
        expect(idsEjes.contains(meta.ejeId), isTrue);
        expect(
          idsMetasGlobales.contains(meta.metaGlobalId),
          isTrue,
        );
      }
    });

    test('las metas nacionales pertenecen al eje correcto', () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      final ejes = await database.select(database.ejes).get();

      final ejePorId = {
        for (final eje in ejes) eje.id: eje.nombre,
      };

      const codigosConservar = {
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

      const codigosEvitar = {
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

      const codigosSalvaguardar = {
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

      const codigosActuar = {
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

      for (final meta in metasNacionales) {
        final ejeNombre = ejePorId[meta.ejeId];

        if (codigosConservar.contains(meta.codigo)) {
          expect(ejeNombre, 'Conservar');
        } else if (codigosEvitar.contains(meta.codigo)) {
          expect(ejeNombre, 'Evitar');
        } else if (codigosSalvaguardar.contains(meta.codigo)) {
          expect(ejeNombre, 'Salvaguardar');
        } else if (codigosActuar.contains(meta.codigo)) {
          expect(ejeNombre, 'Actuar');
        } else {
          fail(
            'La meta nacional ${meta.codigo} no está clasificada.',
          );
        }
      }
    });

    test('las metas nacionales tienen descripción', () async {
      final metasNacionales =
          await database.select(database.metasNacionales).get();

      for (final meta in metasNacionales) {
        expect(meta.nombre.trim().isNotEmpty, isTrue);
        expect(
          meta.descripcion?.trim().isNotEmpty,
          isTrue,
        );
      }
    });
  });
}