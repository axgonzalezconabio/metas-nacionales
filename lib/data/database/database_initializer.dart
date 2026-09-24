import 'app_database.dart';
import '../seed/contenido_seed.dart';

class DatabaseInitializer {
  DatabaseInitializer(this.database);

  final AppDatabase database;

  static const int contenidoVersionActual = 1;

  Future<void> inicializar() async {
    final version = await _obtenerVersionContenido();

    if (version == null) {
      await ContenidoSeed.cargar(database);

      await _guardarVersionContenido(
        contenidoVersionActual,
      );

      return;
    }

    if (version < contenidoVersionActual) {
      await _actualizarContenido(
        version,
        contenidoVersionActual,
      );
    }
  }

  Future<int?> _obtenerVersionContenido() async {
    final resultado = await (database.select(
      database.configuracionContenido,
    )..where(
        (config) => config.clave.equals('contenido_version'),
      ))
        .getSingleOrNull();

    if (resultado == null) {
      return null;
    }

    return int.tryParse(resultado.valor);
  }

  Future<void> _guardarVersionContenido(int version) async {
    await database.into(database.configuracionContenido).insertOnConflictUpdate(
          ConfiguracionContenidoCompanion.insert(
            clave: 'contenido_version',
            valor: version.toString(),
          ),
        );
  }

  Future<void> _actualizarContenido(
    int versionActual,
    int nuevaVersion,
  ) async {
    // Aquí agregaremos las migraciones de contenido
    // cuando exista una nueva versión oficial.

    throw UnimplementedError(
      'No existe una migración de contenido '
      'de $versionActual a $nuevaVersion.',
    );
  }
}