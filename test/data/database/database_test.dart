import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:drift/native.dart'; 
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Las relaciones de SQLite funcionan correctamente', () async {
    final database = AppDatabase(
      NativeDatabase.memory(),
    );
        // Publicación
    final publicacionId = await database
        .into(database.publicaciones)
        .insert(
          PublicacionesCompanion.insert(
            nombre: 'Publicación de prueba',
            edicion: const Value('2026'),
            anio: const Value(2026),
          ),
        );

    // Eje
    final ejeId = await database
        .into(database.ejes)
        .insert(
          EjesCompanion.insert(
            nombre: 'CONSERVAR',
            publicacionId: publicacionId,
            orden: 1,
          ),
        );

    // Meta global
    final metaGlobalId = await database
        .into(database.metasGlobales)
        .insert(
          MetasGlobalesCompanion.insert(
            codigo: 'MG-01',
            nombre: 'Meta global de prueba',
            ejeId: ejeId,
            orden: 1,
          ),
        );

    // Meta nacional
    final metaNacionalId = await database
        .into(database.metasNacionales)
        .insert(
          MetasNacionalesCompanion.insert(
            codigo: '1.0',
            nombre: 'Meta nacional de prueba',
            ejeId: ejeId,
            metaGlobalId: metaGlobalId,
            publicacionId: publicacionId,
            orden: 1,
          ),
        );

    // Referencia de origen
    final referenciaId = await database
        .into(database.referenciasOrigen)
        .insert(
          ReferenciasOrigenCompanion.insert(
            documento: 'Prueba',
            edicion: const Value('2026'),
            anio: const Value(2026),
            pagina: const Value(1),
          ),
        );

    // Hito
    final hitoId = await database
        .into(database.hitos)
        .insert(
          HitosCompanion.insert(
            codigo: '1.0-H1',
            metaNacionalId: metaNacionalId,
            orden: 1,
            referenciaOrigenId: referenciaId,
          ),
        );

    // Verificar relaciones
    final eje = await (database.select(database.ejes)
          ..where((tabla) => tabla.id.equals(ejeId)))
        .getSingle();

    final metaGlobal = await (database.select(database.metasGlobales)
          ..where((tabla) => tabla.id.equals(metaGlobalId)))
        .getSingle();

    final metaNacional = await (database.select(database.metasNacionales)
          ..where((tabla) => tabla.id.equals(metaNacionalId)))
        .getSingle();

    final hito = await (database.select(database.hitos)
          ..where((tabla) => tabla.id.equals(hitoId)))
        .getSingle();

    expect(eje.publicacionId, publicacionId);
    expect(metaGlobal.ejeId, ejeId);
    expect(metaNacional.ejeId, ejeId);
    expect(metaNacional.metaGlobalId, metaGlobalId);
    expect(metaNacional.publicacionId, publicacionId);
    expect(hito.metaNacionalId, metaNacionalId);

    await database.close();
  });
}