import 'package:drift/drift.dart';
import 'package:metas_nacionales/data/database/app_database.dart';

class MetaNacionalDetalle {
  const MetaNacionalDetalle({
    required this.meta,
    required this.eje,
    required this.metaGlobal,
    required this.referenciaOrigen,
  });

  final MetasNacionale meta;
  final Eje eje;
  final MetasGlobale metaGlobal;
  final ReferenciasOrigenData? referenciaOrigen;
}

class MetaNacionalConEje {
  const MetaNacionalConEje({
    required this.meta,
    required this.eje,
  });

  final MetasNacionale meta;
  final Eje eje;
}

class InstitucionParticipante {
  const InstitucionParticipante({
    required this.institucion,
    required this.participacion,
  });

  final Institucione institucion;
  final ParticipacionesInstitucionale participacion;
}

class InstitucionResumen {
  const InstitucionResumen({
    required this.institucion,
    required this.totalParticipaciones,
  });

  final Institucione institucion;
  final int totalParticipaciones;
}

class InstitucionMetaParticipacion {
  const InstitucionMetaParticipacion({
    required this.meta,
    required this.participacion,
  });

  final MetasNacionale meta;
  final ParticipacionesInstitucionale participacion;
}

class MetasNacionalesRepository {
  MetasNacionalesRepository(this._database);

  final AppDatabase _database;

  Future<List<MetasNacionale>> obtenerMetasNacionales() {
    return _database.select(_database.metasNacionales).get();
  }

  Future<List<MetaNacionalConEje>>
      obtenerMetasNacionalesConEje() async {
    final consulta = _database
        .select(_database.metasNacionales)
        .join([
      innerJoin(
        _database.ejes,
        _database.ejes.id.equalsExp(
          _database.metasNacionales.ejeId,
        ),
      ),
    ]);

    consulta.orderBy([
      OrderingTerm(
        expression: _database.metasNacionales.orden,
      ),
    ]);

    final resultados = await consulta.get();

    return resultados.map((fila) {
      return MetaNacionalConEje(
        meta: fila.readTable(
          _database.metasNacionales,
        ),
        eje: fila.readTable(
          _database.ejes,
        ),
      );
    }).toList();
  }

  Future<MetasNacionale?> obtenerMetaNacionalPorId(
    int id,
  ) {
    return (_database.select(_database.metasNacionales)
          ..where((meta) => meta.id.equals(id)))
        .getSingleOrNull();
  }

  Future<MetasNacionale?> obtenerMetaNacionalPorCodigo(
    String codigo,
  ) {
    return (_database.select(_database.metasNacionales)
          ..where((meta) => meta.codigo.equals(codigo)))
        .getSingleOrNull();
  }

  Future<List<MetasNacionale>> buscarMetasNacionales(
    String texto,
  ) {
    final consulta =
        _database.select(_database.metasNacionales);

    final patron = '%$texto%';

    consulta.where(
      (meta) =>
          meta.codigo.like(patron) |
          meta.nombre.like(patron) |
          meta.descripcion.like(patron),
    );

    return consulta.get();
  }

  Future<List<MetasNacionale>> obtenerMetasPorEje(
    String ejeNombre,
  ) async {
    final consulta =
        _database.select(_database.metasNacionales).join([
      innerJoin(
        _database.ejes,
        _database.ejes.id.equalsExp(
          _database.metasNacionales.ejeId,
        ),
      ),
    ]);

    consulta.where(
      _database.ejes.nombre.equals(ejeNombre),
    );

    consulta.orderBy([
      OrderingTerm(
        expression: _database.metasNacionales.orden,
      ),
    ]);

    final resultados = await consulta.get();

    return resultados
        .map(
          (fila) => fila.readTable(
            _database.metasNacionales,
          ),
        )
        .toList();
  }

  Future<MetaNacionalDetalle?>
      obtenerDetalleMetaNacional(
    String codigo,
  ) async {
    final query =
        _database.select(_database.metasNacionales).join([
      innerJoin(
        _database.ejes,
        _database.ejes.id.equalsExp(
          _database.metasNacionales.ejeId,
        ),
      ),
      innerJoin(
        _database.metasGlobales,
        _database.metasGlobales.id.equalsExp(
          _database.metasNacionales.metaGlobalId,
        ),
      ),
      leftOuterJoin(
        _database.referenciasOrigen,
        _database.referenciasOrigen.id.equalsExp(
          _database.metasNacionales.referenciaOrigenId,
        ),
      ),
    ]);

    query.where(
      _database.metasNacionales.codigo.equals(codigo),
    );

    final resultado =
        await query.getSingleOrNull();

    if (resultado == null) {
      return null;
    }

    return MetaNacionalDetalle(
      meta: resultado.readTable(
        _database.metasNacionales,
      ),
      eje: resultado.readTable(
        _database.ejes,
      ),
      metaGlobal: resultado.readTable(
        _database.metasGlobales,
      ),
      referenciaOrigen: resultado.readTableOrNull(
        _database.referenciasOrigen,
      ),
    );
  }

  Future<List<Hito>> obtenerHitosPorMetaNacional(
    int metaNacionalId,
  ) {
    return (_database.select(_database.hitos)
          ..where(
            (hito) =>
                hito.metaNacionalId.equals(
              metaNacionalId,
            ),
          )
          ..orderBy([
            (hito) => OrderingTerm(
                  expression: hito.orden,
                ),
          ]))
        .get();
  }

  Future<List<Subhito>> obtenerSubhitosPorHito(
    int hitoId,
  ) {
    return (_database.select(_database.subhitos)
          ..where(
            (subhito) =>
                subhito.hitoId.equals(hitoId),
          )
          ..orderBy([
            (subhito) => OrderingTerm(
                  expression: subhito.orden,
                ),
          ]))
        .get();
  }

  Future<List<InstitucionParticipante>>
      obtenerInstitucionesPorMetaNacional(
    int metaNacionalId,
  ) async {
    final consulta = _database
        .select(
          _database.participacionesInstitucionales,
        )
        .join([
      innerJoin(
        _database.instituciones,
        _database.instituciones.id.equalsExp(
          _database
              .participacionesInstitucionales
              .institucionId,
        ),
      ),
    ]);

    consulta.where(
      _database
          .participacionesInstitucionales
          .metaNacionalId
          .equals(metaNacionalId),
    );

    final resultados = await consulta.get();

    return resultados.map((fila) {
      return InstitucionParticipante(
        institucion: fila.readTable(
          _database.instituciones,
        ),
        participacion: fila.readTable(
          _database.participacionesInstitucionales,
        ),
      );
    }).toList();
  }

  Future<List<InstitucionResumen>>
      obtenerInstituciones() async {
    final instituciones =
        await _database.select(
          _database.instituciones,
        ).get();

    final participaciones =
        await _database.select(
          _database.participacionesInstitucionales,
        ).get();

    final conteos = <int, int>{};

    for (final participacion in participaciones) {
      conteos.update(
        participacion.institucionId,
        (cantidad) => cantidad + 1,
        ifAbsent: () => 1,
      );
    }

    instituciones.sort(
      (a, b) => a.nombre.toLowerCase().compareTo(
            b.nombre.toLowerCase(),
          ),
    );

    return instituciones.map((institucion) {
      return InstitucionResumen(
        institucion: institucion,
        totalParticipaciones:
            conteos[institucion.id] ?? 0,
      );
    }).toList();
  }

  Future<Institucione?> obtenerInstitucionPorId(
    int id,
  ) {
    return (_database.select(_database.instituciones)
          ..where(
            (institucion) =>
                institucion.id.equals(id),
          ))
        .getSingleOrNull();
  }

  Future<List<InstitucionMetaParticipacion>>
      obtenerMetasPorInstitucion(
    int institucionId,
  ) async {
    final consulta = _database
        .select(
          _database.participacionesInstitucionales,
        )
        .join([
      innerJoin(
        _database.metasNacionales,
        _database.metasNacionales.id.equalsExp(
          _database
              .participacionesInstitucionales
              .metaNacionalId,
        ),
      ),
    ]);

    consulta.where(
      _database
          .participacionesInstitucionales
          .institucionId
          .equals(institucionId),
    );

    consulta.orderBy([
      OrderingTerm(
        expression: _database.metasNacionales.orden,
      ),
    ]);

    final resultados = await consulta.get();

    return resultados.map((fila) {
      return InstitucionMetaParticipacion(
        meta: fila.readTable(
          _database.metasNacionales,
        ),
        participacion: fila.readTable(
          _database.participacionesInstitucionales,
        ),
      );
    }).toList();
  }
}