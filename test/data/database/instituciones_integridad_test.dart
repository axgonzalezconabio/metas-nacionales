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

  group('Integridad institucional del seed', () {
    test('debe cargar las instituciones y siglas de la Guía', () async {
      final instituciones =
          await database.select(database.instituciones).get();
      final siglas =
          await database.select(database.siglasAcronimos).get();

      expect(instituciones.length, 74);
      expect(siglas.length, 73);

      expect(
        instituciones.map((i) => i.nombre).toSet().length,
        instituciones.length,
        reason: 'No debe haber instituciones duplicadas.',
      );

      expect(
        siglas.map((s) => s.sigla).toSet().length,
        siglas.length,
        reason: 'No debe haber siglas duplicadas.',
      );
    });

    test('todas las siglas apuntan a una institución válida', () async {
      final instituciones =
          await database.select(database.instituciones).get();
      final institucionIds = instituciones.map((i) => i.id).toSet();

      final siglas =
          await database.select(database.siglasAcronimos).get();

      for (final sigla in siglas) {
        expect(
          institucionIds.contains(sigla.institucionId),
          isTrue,
          reason:
              'La sigla ${sigla.sigla} apunta a una institución inexistente.',
        );
        expect(sigla.sigla.trim(), isNotEmpty);
        expect(sigla.descripcion?.trim(), isNotEmpty);
      }
    });

    test('debe cargar las participaciones de la matriz institucional', () async {
      final participaciones =
          await database.select(database.participacionesInstitucionales).get();

      expect(participaciones.length, 330);

      final instituciones =
          await database.select(database.instituciones).get();
      final institucionIds = instituciones.map((i) => i.id).toSet();

      final metas =
          await database.select(database.metasNacionales).get();
      final metaIds = metas.map((m) => m.id).toSet();

      for (final participacion in participaciones) {
        expect(
          institucionIds.contains(participacion.institucionId),
          isTrue,
        );
        expect(
          metaIds.contains(participacion.metaNacionalId),
          isTrue,
        );
        expect(
          {'COORDINADORA', 'COADYUVANTE'}
              .contains(participacion.tipoParticipacion),
          isTrue,
          reason:
              'Tipo inválido: ${participacion.tipoParticipacion}',
        );
        expect(
          participacion.hitoId,
          isNull,
          reason:
              'La matriz institucional se asocia a la meta nacional; '
              'los responsables por hito se manejarán por separado.',
        );
      }
    });

    test('no debe haber participaciones duplicadas', () async {
      final participaciones =
          await database.select(database.participacionesInstitucionales).get();

      final claves = participaciones
          .map(
            (p) =>
                '${p.institucionId}|${p.metaNacionalId}|${p.tipoParticipacion}',
          )
          .toSet();

      expect(claves.length, participaciones.length);
    });

    test('la Administración Pública Federal participa como coadyuvante en 14.1, 18.0 y 21.2',
        () async {
      final instituciones =
          await database.select(database.instituciones).get();
      final apf = instituciones.firstWhere(
        (i) => i.nombre == 'Administración Pública Federal',
      );

      final metas =
          await database.select(database.metasNacionales).get();
      final metaPorCodigo = {
        for (final meta in metas) meta.codigo: meta.id,
      };

      final participaciones =
          await database.select(database.participacionesInstitucionales).get();

      final apfMetas = participaciones
          .where(
            (p) =>
                p.institucionId == apf.id &&
                p.tipoParticipacion == 'COADYUVANTE',
          )
          .map(
            (p) => metaPorCodigo.entries
                .firstWhere((e) => e.value == p.metaNacionalId)
                .key,
          )
          .toSet();

      expect(apfMetas, {'14.1', '18.0', '21.2'});
    });
  });
}
