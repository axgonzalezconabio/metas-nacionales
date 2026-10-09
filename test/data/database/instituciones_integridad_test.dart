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

  group('Integridad institucional del seed', () {
    test('debe cargar las instituciones y siglas de la Guía', () async {
      final instituciones = await database.select(database.instituciones).get();
      final siglas = await database.select(database.siglasAcronimos).get();
      expect(instituciones.length, 74);
      expect(siglas.length, 73);
      expect(instituciones.map((i) => i.nombre).toSet().length, instituciones.length);
      expect(siglas.map((s) => s.sigla).toSet().length, siglas.length);
    });

    test('todas las siglas apuntan a una institución válida', () async {
      final ids = (await database.select(database.instituciones).get()).map((i) => i.id).toSet();
      for (final sigla in await database.select(database.siglasAcronimos).get()) {
        expect(ids.contains(sigla.institucionId), isTrue, reason: sigla.sigla);
        expect(sigla.sigla.trim(), isNotEmpty);
        expect(sigla.descripcion?.trim(), isNotEmpty);
      }
    });

    test('debe cargar las participaciones de la matriz institucional', () async {
      final participaciones = await database.select(database.participacionesInstitucionales).get();
      // Total observado tras las correcciones. Contrastar con la matriz oficial.
      expect(participaciones.length, 329);
      final institucionIds = (await database.select(database.instituciones).get()).map((i) => i.id).toSet();
      final metaIds = (await database.select(database.metasNacionales).get()).map((m) => m.id).toSet();
      for (final p in participaciones) {
        expect(institucionIds.contains(p.institucionId), isTrue);
        expect(metaIds.contains(p.metaNacionalId), isTrue);
        expect({'COORDINADORA', 'COADYUVANTE'}.contains(p.tipoParticipacion), isTrue);
        expect(p.hitoId, isNull);
      }
    });

    test('no debe haber participaciones duplicadas', () async {
      final participaciones = await database.select(database.participacionesInstitucionales).get();
      final claves = participaciones.map((p) => '${p.institucionId}|${p.metaNacionalId}|${p.tipoParticipacion}').toSet();
      expect(claves.length, participaciones.length);
    });

    test('la Administración Pública Federal participa como coadyuvante en 14.1, 18.0 y 21.2', () async {
      final instituciones = await database.select(database.instituciones).get();
      final apf = instituciones.firstWhere((i) => i.nombre == 'Administración Pública Federal');
      final metas = await database.select(database.metasNacionales).get();
      final codigoPorId = {for (final m in metas) m.id: m.codigo};
      final participaciones = await database.select(database.participacionesInstitucionales).get();
      final apfMetas = participaciones
          .where((p) => p.institucionId == apf.id && p.tipoParticipacion == 'COADYUVANTE')
          .map((p) => codigoPorId[p.metaNacionalId]).toSet();
      expect(apfMetas, {'14.1', '18.0', '21.2'});
    });
  });
}
