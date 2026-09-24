import 'package:drift/drift.dart';

import 'database_connection.dart';

part 'app_database.g.dart';

/// E10 - Referencia de origen
class ReferenciasOrigen extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get documento => text()();

  TextColumn get edicion => text().nullable()();

  IntColumn get anio => integer().nullable()();

  IntColumn get pagina => integer().nullable()();

  TextColumn get seccion => text().nullable()();

  TextColumn get observacion => text().nullable()();
}

/// E01 - Publicación
class Publicaciones extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text()();

  TextColumn get edicion => text().nullable()();

  IntColumn get anio => integer().nullable()();

  TextColumn get descripcion => text().nullable()();
}

/// E02 - Eje
class Ejes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text()();

  TextColumn get descripcion => text().nullable()();

  IntColumn get publicacionId =>
      integer().references(Publicaciones, #id)();

  IntColumn get orden => integer()();

  
  List<Index> get customIndexes => [
        Index(
          'idx_ejes_publicacion',
          'CREATE INDEX idx_ejes_publicacion ON ejes (publicacion_id)',
        ),
      ];
}

/// E03 - Meta Global
class MetasGlobales extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get codigo => text()();

  TextColumn get nombre => text()();

  TextColumn get descripcion => text().nullable()();

  IntColumn get ejeId =>
      integer().references(Ejes, #id)();

  IntColumn get orden => integer()();

  
  List<Index> get customIndexes => [
        Index(
          'idx_metas_globales_eje',
          'CREATE INDEX idx_metas_globales_eje ON metas_globales (eje_id)',
        ),
      ];
}

/// E04 - Meta Nacional
class MetasNacionales extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get codigo => text()();

  TextColumn get nombre => text()();

  TextColumn get descripcion => text().nullable()();

  IntColumn get ejeId =>
      integer().references(Ejes, #id)();

  IntColumn get metaGlobalId =>
      integer().references(MetasGlobales, #id)();

  IntColumn get publicacionId =>
      integer().references(Publicaciones, #id)();

  IntColumn get referenciaOrigenId =>
      integer().nullable().references(ReferenciasOrigen, #id)();

  IntColumn get orden => integer()();

  
  List<Index> get customIndexes => [
        Index(
          'idx_metas_nacionales_codigo_publicacion',
          'CREATE UNIQUE INDEX idx_metas_nacionales_codigo_publicacion '
              'ON metas_nacionales (codigo, publicacion_id)',
        ),
        Index(
          'idx_metas_nacionales_eje',
          'CREATE INDEX idx_metas_nacionales_eje '
              'ON metas_nacionales (eje_id)',
        ),
        Index(
          'idx_metas_nacionales_meta_global',
          'CREATE INDEX idx_metas_nacionales_meta_global '
              'ON metas_nacionales (meta_global_id)',
        ),
      ];
}

/// E05 - Hito
class Hitos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get codigo => text()();

  TextColumn get nombre => text().nullable()();

  TextColumn get descripcion => text().nullable()();

  IntColumn get metaNacionalId =>
      integer().references(MetasNacionales, #id)();

  IntColumn get orden => integer()();

  IntColumn get anio => integer().nullable()();

  TextColumn get periodo => text().nullable()();

  IntColumn get referenciaOrigenId =>
      integer().references(ReferenciasOrigen, #id)();

  
  List<Index> get customIndexes => [
        Index(
          'idx_hitos_meta_nacional',
          'CREATE INDEX idx_hitos_meta_nacional '
              'ON hitos (meta_nacional_id)',
        ),
      ];
}

/// E06 - Subhito
class Subhitos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get codigo => text().nullable()();

  TextColumn get descripcion => text()();

  IntColumn get hitoId =>
      integer().references(Hitos, #id)();

  IntColumn get orden => integer()();

  IntColumn get referenciaOrigenId =>
      integer().nullable().references(ReferenciasOrigen, #id)();

  
  List<Index> get customIndexes => [
        Index(
          'idx_subhitos_hito',
          'CREATE INDEX idx_subhitos_hito ON subhitos (hito_id)',
        ),
      ];
}

/// E07 - Institución
class Instituciones extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text()();

  TextColumn get nombreCorto => text().nullable()();

  TextColumn get tipo => text().nullable()();

  TextColumn get descripcion => text().nullable()();
}

/// E08 - Participación Institucional
class ParticipacionesInstitucionales extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get institucionId =>
      integer().references(Instituciones, #id)();

  IntColumn get metaNacionalId =>
      integer().nullable().references(MetasNacionales, #id)();

  IntColumn get hitoId =>
      integer().nullable().references(Hitos, #id)();

  TextColumn get tipoParticipacion => text()();

  TextColumn get descripcion => text().nullable()();

  IntColumn get referenciaOrigenId =>
      integer().nullable().references(ReferenciasOrigen, #id)();

  
  List<Index> get customIndexes => [
        Index(
          'idx_participaciones_institucion',
          'CREATE INDEX idx_participaciones_institucion '
              'ON participaciones_institucionales (institucion_id)',
        ),
        Index(
          'idx_participaciones_meta_nacional',
          'CREATE INDEX idx_participaciones_meta_nacional '
              'ON participaciones_institucionales (meta_nacional_id)',
        ),
        Index(
          'idx_participaciones_hito',
          'CREATE INDEX idx_participaciones_hito '
              'ON participaciones_institucionales (hito_id)',
        ),
      ];
}

/// E09 - Sigla / Acrónimo
class SiglasAcronimos extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get institucionId =>
      integer().references(Instituciones, #id)();

  TextColumn get sigla => text()();

  TextColumn get descripcion => text().nullable()();

  
  List<Index> get customIndexes => [
        Index(
          'idx_siglas_institucion',
          'CREATE INDEX idx_siglas_institucion '
              'ON siglas_acronimos (institucion_id)',
        ),
      ];
}
/// Control de versión del contenido cargado en la base de datos.
class ConfiguracionContenido extends Table {
  TextColumn get clave => text()();

  TextColumn get valor => text()();

  @override
  Set<Column> get primaryKey => {clave};
}

@DriftDatabase(
  tables: [
    Publicaciones,
    ReferenciasOrigen,
    Ejes,
    MetasGlobales,
    MetasNacionales,
    Hitos,
    Subhitos,
    Instituciones,
    ParticipacionesInstitucionales,
    SiglasAcronimos,
    ConfiguracionContenido,

  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(configuracionContenido);
      }
    },
  );
}