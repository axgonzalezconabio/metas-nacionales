import 'package:drift/drift.dart';

import '../database/app_database.dart';

class ContenidoSeed {
  static Future<void> cargar(AppDatabase database) async {
    await database.transaction(() async {
      // Publicación oficial
      final publicacionId = await database
          .into(database.publicaciones)
          .insert(
            PublicacionesCompanion.insert(
              nombre:
                  'Metas Nacionales para la implementación del Marco Mundial de Biodiversidad Kunming-Montreal en México',
              edicion: const Value('Primera edición'),
              anio: const Value(2026),
              descripcion: const Value(
                'Guía Rápida para la implementación del Marco Mundial de Biodiversidad Kunming-Montreal en México.',
              ),
            ),
          );

      // Ejes oficiales
      await database.into(database.ejes).insert(
            EjesCompanion.insert(
              nombre: 'Conservar',
              descripcion: const Value(
                'Planeación espacial, restauración, conservación de áreas, especies y sectores productivos.',
              ),
              publicacionId: publicacionId,
              orden: 1,
            ),
          );

      await database.into(database.ejes).insert(
            EjesCompanion.insert(
              nombre: 'Evitar',
              descripcion: const Value(
                'Uso y comercio sustentables, especies exóticas invasoras, contaminación, cambio climático y bioseguridad.',
              ),
              publicacionId: publicacionId,
              orden: 2,
            ),
          );

      await database.into(database.ejes).insert(
            EjesCompanion.insert(
              nombre: 'Salvaguardar',
              descripcion: const Value(
                'Contribuciones de la naturaleza, espacios verdes y azules, recursos genéticos e integración de biodiversidad.',
              ),
              publicacionId: publicacionId,
              orden: 3,
            ),
          );

      await database.into(database.ejes).insert(
            EjesCompanion.insert(
              nombre: 'Actuar',
              descripcion: const Value(
                'Toma de decisiones, responsabilidad empresarial y financiera, consumo, incentivos, financiamiento, capacidades, conocimiento, participación social e igualdad de género.',
              ),
              publicacionId: publicacionId,
              orden: 4,
            ),
          );
    });
  }
}