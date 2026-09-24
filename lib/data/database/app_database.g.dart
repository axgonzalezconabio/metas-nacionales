// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PublicacionesTable extends Publicaciones
    with TableInfo<$PublicacionesTable, Publicacione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PublicacionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _edicionMeta = const VerificationMeta(
    'edicion',
  );
  @override
  late final GeneratedColumn<String> edicion = GeneratedColumn<String>(
    'edicion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
    'anio',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    edicion,
    anio,
    descripcion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'publicaciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Publicacione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('edicion')) {
      context.handle(
        _edicionMeta,
        edicion.isAcceptableOrUnknown(data['edicion']!, _edicionMeta),
      );
    }
    if (data.containsKey('anio')) {
      context.handle(
        _anioMeta,
        anio.isAcceptableOrUnknown(data['anio']!, _anioMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Publicacione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Publicacione(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      edicion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}edicion'],
      ),
      anio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anio'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
    );
  }

  @override
  $PublicacionesTable createAlias(String alias) {
    return $PublicacionesTable(attachedDatabase, alias);
  }
}

class Publicacione extends DataClass implements Insertable<Publicacione> {
  final int id;
  final String nombre;
  final String? edicion;
  final int? anio;
  final String? descripcion;
  const Publicacione({
    required this.id,
    required this.nombre,
    this.edicion,
    this.anio,
    this.descripcion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || edicion != null) {
      map['edicion'] = Variable<String>(edicion);
    }
    if (!nullToAbsent || anio != null) {
      map['anio'] = Variable<int>(anio);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  PublicacionesCompanion toCompanion(bool nullToAbsent) {
    return PublicacionesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      edicion: edicion == null && nullToAbsent
          ? const Value.absent()
          : Value(edicion),
      anio: anio == null && nullToAbsent ? const Value.absent() : Value(anio),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory Publicacione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Publicacione(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      edicion: serializer.fromJson<String?>(json['edicion']),
      anio: serializer.fromJson<int?>(json['anio']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'edicion': serializer.toJson<String?>(edicion),
      'anio': serializer.toJson<int?>(anio),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  Publicacione copyWith({
    int? id,
    String? nombre,
    Value<String?> edicion = const Value.absent(),
    Value<int?> anio = const Value.absent(),
    Value<String?> descripcion = const Value.absent(),
  }) => Publicacione(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    edicion: edicion.present ? edicion.value : this.edicion,
    anio: anio.present ? anio.value : this.anio,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
  );
  Publicacione copyWithCompanion(PublicacionesCompanion data) {
    return Publicacione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      edicion: data.edicion.present ? data.edicion.value : this.edicion,
      anio: data.anio.present ? data.anio.value : this.anio,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Publicacione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edicion: $edicion, ')
          ..write('anio: $anio, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, edicion, anio, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Publicacione &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.edicion == this.edicion &&
          other.anio == this.anio &&
          other.descripcion == this.descripcion);
}

class PublicacionesCompanion extends UpdateCompanion<Publicacione> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> edicion;
  final Value<int?> anio;
  final Value<String?> descripcion;
  const PublicacionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.edicion = const Value.absent(),
    this.anio = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  PublicacionesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.edicion = const Value.absent(),
    this.anio = const Value.absent(),
    this.descripcion = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Publicacione> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? edicion,
    Expression<int>? anio,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (edicion != null) 'edicion': edicion,
      if (anio != null) 'anio': anio,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  PublicacionesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? edicion,
    Value<int?>? anio,
    Value<String?>? descripcion,
  }) {
    return PublicacionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      edicion: edicion ?? this.edicion,
      anio: anio ?? this.anio,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (edicion.present) {
      map['edicion'] = Variable<String>(edicion.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PublicacionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edicion: $edicion, ')
          ..write('anio: $anio, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $ReferenciasOrigenTable extends ReferenciasOrigen
    with TableInfo<$ReferenciasOrigenTable, ReferenciasOrigenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReferenciasOrigenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _documentoMeta = const VerificationMeta(
    'documento',
  );
  @override
  late final GeneratedColumn<String> documento = GeneratedColumn<String>(
    'documento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _edicionMeta = const VerificationMeta(
    'edicion',
  );
  @override
  late final GeneratedColumn<String> edicion = GeneratedColumn<String>(
    'edicion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
    'anio',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paginaMeta = const VerificationMeta('pagina');
  @override
  late final GeneratedColumn<int> pagina = GeneratedColumn<int>(
    'pagina',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seccionMeta = const VerificationMeta(
    'seccion',
  );
  @override
  late final GeneratedColumn<String> seccion = GeneratedColumn<String>(
    'seccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observacionMeta = const VerificationMeta(
    'observacion',
  );
  @override
  late final GeneratedColumn<String> observacion = GeneratedColumn<String>(
    'observacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documento,
    edicion,
    anio,
    pagina,
    seccion,
    observacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'referencias_origen';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReferenciasOrigenData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('documento')) {
      context.handle(
        _documentoMeta,
        documento.isAcceptableOrUnknown(data['documento']!, _documentoMeta),
      );
    } else if (isInserting) {
      context.missing(_documentoMeta);
    }
    if (data.containsKey('edicion')) {
      context.handle(
        _edicionMeta,
        edicion.isAcceptableOrUnknown(data['edicion']!, _edicionMeta),
      );
    }
    if (data.containsKey('anio')) {
      context.handle(
        _anioMeta,
        anio.isAcceptableOrUnknown(data['anio']!, _anioMeta),
      );
    }
    if (data.containsKey('pagina')) {
      context.handle(
        _paginaMeta,
        pagina.isAcceptableOrUnknown(data['pagina']!, _paginaMeta),
      );
    }
    if (data.containsKey('seccion')) {
      context.handle(
        _seccionMeta,
        seccion.isAcceptableOrUnknown(data['seccion']!, _seccionMeta),
      );
    }
    if (data.containsKey('observacion')) {
      context.handle(
        _observacionMeta,
        observacion.isAcceptableOrUnknown(
          data['observacion']!,
          _observacionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReferenciasOrigenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReferenciasOrigenData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      documento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}documento'],
      )!,
      edicion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}edicion'],
      ),
      anio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anio'],
      ),
      pagina: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pagina'],
      ),
      seccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seccion'],
      ),
      observacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observacion'],
      ),
    );
  }

  @override
  $ReferenciasOrigenTable createAlias(String alias) {
    return $ReferenciasOrigenTable(attachedDatabase, alias);
  }
}

class ReferenciasOrigenData extends DataClass
    implements Insertable<ReferenciasOrigenData> {
  final int id;
  final String documento;
  final String? edicion;
  final int? anio;
  final int? pagina;
  final String? seccion;
  final String? observacion;
  const ReferenciasOrigenData({
    required this.id,
    required this.documento,
    this.edicion,
    this.anio,
    this.pagina,
    this.seccion,
    this.observacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['documento'] = Variable<String>(documento);
    if (!nullToAbsent || edicion != null) {
      map['edicion'] = Variable<String>(edicion);
    }
    if (!nullToAbsent || anio != null) {
      map['anio'] = Variable<int>(anio);
    }
    if (!nullToAbsent || pagina != null) {
      map['pagina'] = Variable<int>(pagina);
    }
    if (!nullToAbsent || seccion != null) {
      map['seccion'] = Variable<String>(seccion);
    }
    if (!nullToAbsent || observacion != null) {
      map['observacion'] = Variable<String>(observacion);
    }
    return map;
  }

  ReferenciasOrigenCompanion toCompanion(bool nullToAbsent) {
    return ReferenciasOrigenCompanion(
      id: Value(id),
      documento: Value(documento),
      edicion: edicion == null && nullToAbsent
          ? const Value.absent()
          : Value(edicion),
      anio: anio == null && nullToAbsent ? const Value.absent() : Value(anio),
      pagina: pagina == null && nullToAbsent
          ? const Value.absent()
          : Value(pagina),
      seccion: seccion == null && nullToAbsent
          ? const Value.absent()
          : Value(seccion),
      observacion: observacion == null && nullToAbsent
          ? const Value.absent()
          : Value(observacion),
    );
  }

  factory ReferenciasOrigenData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReferenciasOrigenData(
      id: serializer.fromJson<int>(json['id']),
      documento: serializer.fromJson<String>(json['documento']),
      edicion: serializer.fromJson<String?>(json['edicion']),
      anio: serializer.fromJson<int?>(json['anio']),
      pagina: serializer.fromJson<int?>(json['pagina']),
      seccion: serializer.fromJson<String?>(json['seccion']),
      observacion: serializer.fromJson<String?>(json['observacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'documento': serializer.toJson<String>(documento),
      'edicion': serializer.toJson<String?>(edicion),
      'anio': serializer.toJson<int?>(anio),
      'pagina': serializer.toJson<int?>(pagina),
      'seccion': serializer.toJson<String?>(seccion),
      'observacion': serializer.toJson<String?>(observacion),
    };
  }

  ReferenciasOrigenData copyWith({
    int? id,
    String? documento,
    Value<String?> edicion = const Value.absent(),
    Value<int?> anio = const Value.absent(),
    Value<int?> pagina = const Value.absent(),
    Value<String?> seccion = const Value.absent(),
    Value<String?> observacion = const Value.absent(),
  }) => ReferenciasOrigenData(
    id: id ?? this.id,
    documento: documento ?? this.documento,
    edicion: edicion.present ? edicion.value : this.edicion,
    anio: anio.present ? anio.value : this.anio,
    pagina: pagina.present ? pagina.value : this.pagina,
    seccion: seccion.present ? seccion.value : this.seccion,
    observacion: observacion.present ? observacion.value : this.observacion,
  );
  ReferenciasOrigenData copyWithCompanion(ReferenciasOrigenCompanion data) {
    return ReferenciasOrigenData(
      id: data.id.present ? data.id.value : this.id,
      documento: data.documento.present ? data.documento.value : this.documento,
      edicion: data.edicion.present ? data.edicion.value : this.edicion,
      anio: data.anio.present ? data.anio.value : this.anio,
      pagina: data.pagina.present ? data.pagina.value : this.pagina,
      seccion: data.seccion.present ? data.seccion.value : this.seccion,
      observacion: data.observacion.present
          ? data.observacion.value
          : this.observacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReferenciasOrigenData(')
          ..write('id: $id, ')
          ..write('documento: $documento, ')
          ..write('edicion: $edicion, ')
          ..write('anio: $anio, ')
          ..write('pagina: $pagina, ')
          ..write('seccion: $seccion, ')
          ..write('observacion: $observacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, documento, edicion, anio, pagina, seccion, observacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReferenciasOrigenData &&
          other.id == this.id &&
          other.documento == this.documento &&
          other.edicion == this.edicion &&
          other.anio == this.anio &&
          other.pagina == this.pagina &&
          other.seccion == this.seccion &&
          other.observacion == this.observacion);
}

class ReferenciasOrigenCompanion
    extends UpdateCompanion<ReferenciasOrigenData> {
  final Value<int> id;
  final Value<String> documento;
  final Value<String?> edicion;
  final Value<int?> anio;
  final Value<int?> pagina;
  final Value<String?> seccion;
  final Value<String?> observacion;
  const ReferenciasOrigenCompanion({
    this.id = const Value.absent(),
    this.documento = const Value.absent(),
    this.edicion = const Value.absent(),
    this.anio = const Value.absent(),
    this.pagina = const Value.absent(),
    this.seccion = const Value.absent(),
    this.observacion = const Value.absent(),
  });
  ReferenciasOrigenCompanion.insert({
    this.id = const Value.absent(),
    required String documento,
    this.edicion = const Value.absent(),
    this.anio = const Value.absent(),
    this.pagina = const Value.absent(),
    this.seccion = const Value.absent(),
    this.observacion = const Value.absent(),
  }) : documento = Value(documento);
  static Insertable<ReferenciasOrigenData> custom({
    Expression<int>? id,
    Expression<String>? documento,
    Expression<String>? edicion,
    Expression<int>? anio,
    Expression<int>? pagina,
    Expression<String>? seccion,
    Expression<String>? observacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documento != null) 'documento': documento,
      if (edicion != null) 'edicion': edicion,
      if (anio != null) 'anio': anio,
      if (pagina != null) 'pagina': pagina,
      if (seccion != null) 'seccion': seccion,
      if (observacion != null) 'observacion': observacion,
    });
  }

  ReferenciasOrigenCompanion copyWith({
    Value<int>? id,
    Value<String>? documento,
    Value<String?>? edicion,
    Value<int?>? anio,
    Value<int?>? pagina,
    Value<String?>? seccion,
    Value<String?>? observacion,
  }) {
    return ReferenciasOrigenCompanion(
      id: id ?? this.id,
      documento: documento ?? this.documento,
      edicion: edicion ?? this.edicion,
      anio: anio ?? this.anio,
      pagina: pagina ?? this.pagina,
      seccion: seccion ?? this.seccion,
      observacion: observacion ?? this.observacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (documento.present) {
      map['documento'] = Variable<String>(documento.value);
    }
    if (edicion.present) {
      map['edicion'] = Variable<String>(edicion.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (pagina.present) {
      map['pagina'] = Variable<int>(pagina.value);
    }
    if (seccion.present) {
      map['seccion'] = Variable<String>(seccion.value);
    }
    if (observacion.present) {
      map['observacion'] = Variable<String>(observacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReferenciasOrigenCompanion(')
          ..write('id: $id, ')
          ..write('documento: $documento, ')
          ..write('edicion: $edicion, ')
          ..write('anio: $anio, ')
          ..write('pagina: $pagina, ')
          ..write('seccion: $seccion, ')
          ..write('observacion: $observacion')
          ..write(')'))
        .toString();
  }
}

class $EjesTable extends Ejes with TableInfo<$EjesTable, Eje> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EjesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publicacionIdMeta = const VerificationMeta(
    'publicacionId',
  );
  @override
  late final GeneratedColumn<int> publicacionId = GeneratedColumn<int>(
    'publicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES publicaciones (id)',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    publicacionId,
    orden,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ejes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Eje> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('publicacion_id')) {
      context.handle(
        _publicacionIdMeta,
        publicacionId.isAcceptableOrUnknown(
          data['publicacion_id']!,
          _publicacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publicacionIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Eje map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Eje(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      publicacionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}publicacion_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
    );
  }

  @override
  $EjesTable createAlias(String alias) {
    return $EjesTable(attachedDatabase, alias);
  }
}

class Eje extends DataClass implements Insertable<Eje> {
  final int id;
  final String nombre;
  final String? descripcion;
  final int publicacionId;
  final int orden;
  const Eje({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.publicacionId,
    required this.orden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['publicacion_id'] = Variable<int>(publicacionId);
    map['orden'] = Variable<int>(orden);
    return map;
  }

  EjesCompanion toCompanion(bool nullToAbsent) {
    return EjesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      publicacionId: Value(publicacionId),
      orden: Value(orden),
    );
  }

  factory Eje.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Eje(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      publicacionId: serializer.fromJson<int>(json['publicacionId']),
      orden: serializer.fromJson<int>(json['orden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'publicacionId': serializer.toJson<int>(publicacionId),
      'orden': serializer.toJson<int>(orden),
    };
  }

  Eje copyWith({
    int? id,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? publicacionId,
    int? orden,
  }) => Eje(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    publicacionId: publicacionId ?? this.publicacionId,
    orden: orden ?? this.orden,
  );
  Eje copyWithCompanion(EjesCompanion data) {
    return Eje(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      publicacionId: data.publicacionId.present
          ? data.publicacionId.value
          : this.publicacionId,
      orden: data.orden.present ? data.orden.value : this.orden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Eje(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('publicacionId: $publicacionId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, descripcion, publicacionId, orden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Eje &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.publicacionId == this.publicacionId &&
          other.orden == this.orden);
}

class EjesCompanion extends UpdateCompanion<Eje> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> publicacionId;
  final Value<int> orden;
  const EjesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.publicacionId = const Value.absent(),
    this.orden = const Value.absent(),
  });
  EjesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    required int publicacionId,
    required int orden,
  }) : nombre = Value(nombre),
       publicacionId = Value(publicacionId),
       orden = Value(orden);
  static Insertable<Eje> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? publicacionId,
    Expression<int>? orden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (publicacionId != null) 'publicacion_id': publicacionId,
      if (orden != null) 'orden': orden,
    });
  }

  EjesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? publicacionId,
    Value<int>? orden,
  }) {
    return EjesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      publicacionId: publicacionId ?? this.publicacionId,
      orden: orden ?? this.orden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (publicacionId.present) {
      map['publicacion_id'] = Variable<int>(publicacionId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EjesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('publicacionId: $publicacionId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }
}

class $MetasGlobalesTable extends MetasGlobales
    with TableInfo<$MetasGlobalesTable, MetasGlobale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetasGlobalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ejeIdMeta = const VerificationMeta('ejeId');
  @override
  late final GeneratedColumn<int> ejeId = GeneratedColumn<int>(
    'eje_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ejes (id)',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigo,
    nombre,
    descripcion,
    ejeId,
    orden,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metas_globales';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetasGlobale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('eje_id')) {
      context.handle(
        _ejeIdMeta,
        ejeId.isAcceptableOrUnknown(data['eje_id']!, _ejeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ejeIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetasGlobale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetasGlobale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      ejeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eje_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
    );
  }

  @override
  $MetasGlobalesTable createAlias(String alias) {
    return $MetasGlobalesTable(attachedDatabase, alias);
  }
}

class MetasGlobale extends DataClass implements Insertable<MetasGlobale> {
  final int id;
  final String codigo;
  final String nombre;
  final String? descripcion;
  final int ejeId;
  final int orden;
  const MetasGlobale({
    required this.id,
    required this.codigo,
    required this.nombre,
    this.descripcion,
    required this.ejeId,
    required this.orden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['codigo'] = Variable<String>(codigo);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['eje_id'] = Variable<int>(ejeId);
    map['orden'] = Variable<int>(orden);
    return map;
  }

  MetasGlobalesCompanion toCompanion(bool nullToAbsent) {
    return MetasGlobalesCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      ejeId: Value(ejeId),
      orden: Value(orden),
    );
  }

  factory MetasGlobale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetasGlobale(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      ejeId: serializer.fromJson<int>(json['ejeId']),
      orden: serializer.fromJson<int>(json['orden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'ejeId': serializer.toJson<int>(ejeId),
      'orden': serializer.toJson<int>(orden),
    };
  }

  MetasGlobale copyWith({
    int? id,
    String? codigo,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? ejeId,
    int? orden,
  }) => MetasGlobale(
    id: id ?? this.id,
    codigo: codigo ?? this.codigo,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    ejeId: ejeId ?? this.ejeId,
    orden: orden ?? this.orden,
  );
  MetasGlobale copyWithCompanion(MetasGlobalesCompanion data) {
    return MetasGlobale(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      ejeId: data.ejeId.present ? data.ejeId.value : this.ejeId,
      orden: data.orden.present ? data.orden.value : this.orden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetasGlobale(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ejeId: $ejeId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, codigo, nombre, descripcion, ejeId, orden);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetasGlobale &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.ejeId == this.ejeId &&
          other.orden == this.orden);
}

class MetasGlobalesCompanion extends UpdateCompanion<MetasGlobale> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> ejeId;
  final Value<int> orden;
  const MetasGlobalesCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.ejeId = const Value.absent(),
    this.orden = const Value.absent(),
  });
  MetasGlobalesCompanion.insert({
    this.id = const Value.absent(),
    required String codigo,
    required String nombre,
    this.descripcion = const Value.absent(),
    required int ejeId,
    required int orden,
  }) : codigo = Value(codigo),
       nombre = Value(nombre),
       ejeId = Value(ejeId),
       orden = Value(orden);
  static Insertable<MetasGlobale> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? ejeId,
    Expression<int>? orden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (ejeId != null) 'eje_id': ejeId,
      if (orden != null) 'orden': orden,
    });
  }

  MetasGlobalesCompanion copyWith({
    Value<int>? id,
    Value<String>? codigo,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? ejeId,
    Value<int>? orden,
  }) {
    return MetasGlobalesCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      ejeId: ejeId ?? this.ejeId,
      orden: orden ?? this.orden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (ejeId.present) {
      map['eje_id'] = Variable<int>(ejeId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetasGlobalesCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ejeId: $ejeId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }
}

class $MetasNacionalesTable extends MetasNacionales
    with TableInfo<$MetasNacionalesTable, MetasNacionale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetasNacionalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ejeIdMeta = const VerificationMeta('ejeId');
  @override
  late final GeneratedColumn<int> ejeId = GeneratedColumn<int>(
    'eje_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ejes (id)',
    ),
  );
  static const VerificationMeta _metaGlobalIdMeta = const VerificationMeta(
    'metaGlobalId',
  );
  @override
  late final GeneratedColumn<int> metaGlobalId = GeneratedColumn<int>(
    'meta_global_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES metas_globales (id)',
    ),
  );
  static const VerificationMeta _publicacionIdMeta = const VerificationMeta(
    'publicacionId',
  );
  @override
  late final GeneratedColumn<int> publicacionId = GeneratedColumn<int>(
    'publicacion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES publicaciones (id)',
    ),
  );
  static const VerificationMeta _referenciaOrigenIdMeta =
      const VerificationMeta('referenciaOrigenId');
  @override
  late final GeneratedColumn<int> referenciaOrigenId = GeneratedColumn<int>(
    'referencia_origen_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES referencias_origen (id)',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigo,
    nombre,
    descripcion,
    ejeId,
    metaGlobalId,
    publicacionId,
    referenciaOrigenId,
    orden,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metas_nacionales';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetasNacionale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('eje_id')) {
      context.handle(
        _ejeIdMeta,
        ejeId.isAcceptableOrUnknown(data['eje_id']!, _ejeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ejeIdMeta);
    }
    if (data.containsKey('meta_global_id')) {
      context.handle(
        _metaGlobalIdMeta,
        metaGlobalId.isAcceptableOrUnknown(
          data['meta_global_id']!,
          _metaGlobalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metaGlobalIdMeta);
    }
    if (data.containsKey('publicacion_id')) {
      context.handle(
        _publicacionIdMeta,
        publicacionId.isAcceptableOrUnknown(
          data['publicacion_id']!,
          _publicacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_publicacionIdMeta);
    }
    if (data.containsKey('referencia_origen_id')) {
      context.handle(
        _referenciaOrigenIdMeta,
        referenciaOrigenId.isAcceptableOrUnknown(
          data['referencia_origen_id']!,
          _referenciaOrigenIdMeta,
        ),
      );
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetasNacionale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetasNacionale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      ejeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eje_id'],
      )!,
      metaGlobalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_global_id'],
      )!,
      publicacionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}publicacion_id'],
      )!,
      referenciaOrigenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_origen_id'],
      ),
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
    );
  }

  @override
  $MetasNacionalesTable createAlias(String alias) {
    return $MetasNacionalesTable(attachedDatabase, alias);
  }
}

class MetasNacionale extends DataClass implements Insertable<MetasNacionale> {
  final int id;
  final String codigo;
  final String nombre;
  final String? descripcion;
  final int ejeId;
  final int metaGlobalId;
  final int publicacionId;
  final int? referenciaOrigenId;
  final int orden;
  const MetasNacionale({
    required this.id,
    required this.codigo,
    required this.nombre,
    this.descripcion,
    required this.ejeId,
    required this.metaGlobalId,
    required this.publicacionId,
    this.referenciaOrigenId,
    required this.orden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['codigo'] = Variable<String>(codigo);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['eje_id'] = Variable<int>(ejeId);
    map['meta_global_id'] = Variable<int>(metaGlobalId);
    map['publicacion_id'] = Variable<int>(publicacionId);
    if (!nullToAbsent || referenciaOrigenId != null) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId);
    }
    map['orden'] = Variable<int>(orden);
    return map;
  }

  MetasNacionalesCompanion toCompanion(bool nullToAbsent) {
    return MetasNacionalesCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      ejeId: Value(ejeId),
      metaGlobalId: Value(metaGlobalId),
      publicacionId: Value(publicacionId),
      referenciaOrigenId: referenciaOrigenId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenciaOrigenId),
      orden: Value(orden),
    );
  }

  factory MetasNacionale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetasNacionale(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      ejeId: serializer.fromJson<int>(json['ejeId']),
      metaGlobalId: serializer.fromJson<int>(json['metaGlobalId']),
      publicacionId: serializer.fromJson<int>(json['publicacionId']),
      referenciaOrigenId: serializer.fromJson<int?>(json['referenciaOrigenId']),
      orden: serializer.fromJson<int>(json['orden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'ejeId': serializer.toJson<int>(ejeId),
      'metaGlobalId': serializer.toJson<int>(metaGlobalId),
      'publicacionId': serializer.toJson<int>(publicacionId),
      'referenciaOrigenId': serializer.toJson<int?>(referenciaOrigenId),
      'orden': serializer.toJson<int>(orden),
    };
  }

  MetasNacionale copyWith({
    int? id,
    String? codigo,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? ejeId,
    int? metaGlobalId,
    int? publicacionId,
    Value<int?> referenciaOrigenId = const Value.absent(),
    int? orden,
  }) => MetasNacionale(
    id: id ?? this.id,
    codigo: codigo ?? this.codigo,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    ejeId: ejeId ?? this.ejeId,
    metaGlobalId: metaGlobalId ?? this.metaGlobalId,
    publicacionId: publicacionId ?? this.publicacionId,
    referenciaOrigenId: referenciaOrigenId.present
        ? referenciaOrigenId.value
        : this.referenciaOrigenId,
    orden: orden ?? this.orden,
  );
  MetasNacionale copyWithCompanion(MetasNacionalesCompanion data) {
    return MetasNacionale(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      ejeId: data.ejeId.present ? data.ejeId.value : this.ejeId,
      metaGlobalId: data.metaGlobalId.present
          ? data.metaGlobalId.value
          : this.metaGlobalId,
      publicacionId: data.publicacionId.present
          ? data.publicacionId.value
          : this.publicacionId,
      referenciaOrigenId: data.referenciaOrigenId.present
          ? data.referenciaOrigenId.value
          : this.referenciaOrigenId,
      orden: data.orden.present ? data.orden.value : this.orden,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetasNacionale(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ejeId: $ejeId, ')
          ..write('metaGlobalId: $metaGlobalId, ')
          ..write('publicacionId: $publicacionId, ')
          ..write('referenciaOrigenId: $referenciaOrigenId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    codigo,
    nombre,
    descripcion,
    ejeId,
    metaGlobalId,
    publicacionId,
    referenciaOrigenId,
    orden,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetasNacionale &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.ejeId == this.ejeId &&
          other.metaGlobalId == this.metaGlobalId &&
          other.publicacionId == this.publicacionId &&
          other.referenciaOrigenId == this.referenciaOrigenId &&
          other.orden == this.orden);
}

class MetasNacionalesCompanion extends UpdateCompanion<MetasNacionale> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> ejeId;
  final Value<int> metaGlobalId;
  final Value<int> publicacionId;
  final Value<int?> referenciaOrigenId;
  final Value<int> orden;
  const MetasNacionalesCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.ejeId = const Value.absent(),
    this.metaGlobalId = const Value.absent(),
    this.publicacionId = const Value.absent(),
    this.referenciaOrigenId = const Value.absent(),
    this.orden = const Value.absent(),
  });
  MetasNacionalesCompanion.insert({
    this.id = const Value.absent(),
    required String codigo,
    required String nombre,
    this.descripcion = const Value.absent(),
    required int ejeId,
    required int metaGlobalId,
    required int publicacionId,
    this.referenciaOrigenId = const Value.absent(),
    required int orden,
  }) : codigo = Value(codigo),
       nombre = Value(nombre),
       ejeId = Value(ejeId),
       metaGlobalId = Value(metaGlobalId),
       publicacionId = Value(publicacionId),
       orden = Value(orden);
  static Insertable<MetasNacionale> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? ejeId,
    Expression<int>? metaGlobalId,
    Expression<int>? publicacionId,
    Expression<int>? referenciaOrigenId,
    Expression<int>? orden,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (ejeId != null) 'eje_id': ejeId,
      if (metaGlobalId != null) 'meta_global_id': metaGlobalId,
      if (publicacionId != null) 'publicacion_id': publicacionId,
      if (referenciaOrigenId != null)
        'referencia_origen_id': referenciaOrigenId,
      if (orden != null) 'orden': orden,
    });
  }

  MetasNacionalesCompanion copyWith({
    Value<int>? id,
    Value<String>? codigo,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? ejeId,
    Value<int>? metaGlobalId,
    Value<int>? publicacionId,
    Value<int?>? referenciaOrigenId,
    Value<int>? orden,
  }) {
    return MetasNacionalesCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      ejeId: ejeId ?? this.ejeId,
      metaGlobalId: metaGlobalId ?? this.metaGlobalId,
      publicacionId: publicacionId ?? this.publicacionId,
      referenciaOrigenId: referenciaOrigenId ?? this.referenciaOrigenId,
      orden: orden ?? this.orden,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (ejeId.present) {
      map['eje_id'] = Variable<int>(ejeId.value);
    }
    if (metaGlobalId.present) {
      map['meta_global_id'] = Variable<int>(metaGlobalId.value);
    }
    if (publicacionId.present) {
      map['publicacion_id'] = Variable<int>(publicacionId.value);
    }
    if (referenciaOrigenId.present) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetasNacionalesCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ejeId: $ejeId, ')
          ..write('metaGlobalId: $metaGlobalId, ')
          ..write('publicacionId: $publicacionId, ')
          ..write('referenciaOrigenId: $referenciaOrigenId, ')
          ..write('orden: $orden')
          ..write(')'))
        .toString();
  }
}

class $HitosTable extends Hitos with TableInfo<$HitosTable, Hito> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HitosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metaNacionalIdMeta = const VerificationMeta(
    'metaNacionalId',
  );
  @override
  late final GeneratedColumn<int> metaNacionalId = GeneratedColumn<int>(
    'meta_nacional_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES metas_nacionales (id)',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
    'anio',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodoMeta = const VerificationMeta(
    'periodo',
  );
  @override
  late final GeneratedColumn<String> periodo = GeneratedColumn<String>(
    'periodo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenciaOrigenIdMeta =
      const VerificationMeta('referenciaOrigenId');
  @override
  late final GeneratedColumn<int> referenciaOrigenId = GeneratedColumn<int>(
    'referencia_origen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES referencias_origen (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigo,
    nombre,
    descripcion,
    metaNacionalId,
    orden,
    anio,
    periodo,
    referenciaOrigenId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hitos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hito> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('meta_nacional_id')) {
      context.handle(
        _metaNacionalIdMeta,
        metaNacionalId.isAcceptableOrUnknown(
          data['meta_nacional_id']!,
          _metaNacionalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_metaNacionalIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
        _anioMeta,
        anio.isAcceptableOrUnknown(data['anio']!, _anioMeta),
      );
    }
    if (data.containsKey('periodo')) {
      context.handle(
        _periodoMeta,
        periodo.isAcceptableOrUnknown(data['periodo']!, _periodoMeta),
      );
    }
    if (data.containsKey('referencia_origen_id')) {
      context.handle(
        _referenciaOrigenIdMeta,
        referenciaOrigenId.isAcceptableOrUnknown(
          data['referencia_origen_id']!,
          _referenciaOrigenIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenciaOrigenIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hito map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hito(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      metaNacionalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_nacional_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      anio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anio'],
      ),
      periodo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}periodo'],
      ),
      referenciaOrigenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_origen_id'],
      )!,
    );
  }

  @override
  $HitosTable createAlias(String alias) {
    return $HitosTable(attachedDatabase, alias);
  }
}

class Hito extends DataClass implements Insertable<Hito> {
  final int id;
  final String codigo;
  final String? nombre;
  final String? descripcion;
  final int metaNacionalId;
  final int orden;
  final int? anio;
  final String? periodo;
  final int referenciaOrigenId;
  const Hito({
    required this.id,
    required this.codigo,
    this.nombre,
    this.descripcion,
    required this.metaNacionalId,
    required this.orden,
    this.anio,
    this.periodo,
    required this.referenciaOrigenId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['codigo'] = Variable<String>(codigo);
    if (!nullToAbsent || nombre != null) {
      map['nombre'] = Variable<String>(nombre);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['meta_nacional_id'] = Variable<int>(metaNacionalId);
    map['orden'] = Variable<int>(orden);
    if (!nullToAbsent || anio != null) {
      map['anio'] = Variable<int>(anio);
    }
    if (!nullToAbsent || periodo != null) {
      map['periodo'] = Variable<String>(periodo);
    }
    map['referencia_origen_id'] = Variable<int>(referenciaOrigenId);
    return map;
  }

  HitosCompanion toCompanion(bool nullToAbsent) {
    return HitosCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nombre: nombre == null && nullToAbsent
          ? const Value.absent()
          : Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      metaNacionalId: Value(metaNacionalId),
      orden: Value(orden),
      anio: anio == null && nullToAbsent ? const Value.absent() : Value(anio),
      periodo: periodo == null && nullToAbsent
          ? const Value.absent()
          : Value(periodo),
      referenciaOrigenId: Value(referenciaOrigenId),
    );
  }

  factory Hito.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hito(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String?>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      metaNacionalId: serializer.fromJson<int>(json['metaNacionalId']),
      orden: serializer.fromJson<int>(json['orden']),
      anio: serializer.fromJson<int?>(json['anio']),
      periodo: serializer.fromJson<String?>(json['periodo']),
      referenciaOrigenId: serializer.fromJson<int>(json['referenciaOrigenId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String?>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'metaNacionalId': serializer.toJson<int>(metaNacionalId),
      'orden': serializer.toJson<int>(orden),
      'anio': serializer.toJson<int?>(anio),
      'periodo': serializer.toJson<String?>(periodo),
      'referenciaOrigenId': serializer.toJson<int>(referenciaOrigenId),
    };
  }

  Hito copyWith({
    int? id,
    String? codigo,
    Value<String?> nombre = const Value.absent(),
    Value<String?> descripcion = const Value.absent(),
    int? metaNacionalId,
    int? orden,
    Value<int?> anio = const Value.absent(),
    Value<String?> periodo = const Value.absent(),
    int? referenciaOrigenId,
  }) => Hito(
    id: id ?? this.id,
    codigo: codigo ?? this.codigo,
    nombre: nombre.present ? nombre.value : this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    metaNacionalId: metaNacionalId ?? this.metaNacionalId,
    orden: orden ?? this.orden,
    anio: anio.present ? anio.value : this.anio,
    periodo: periodo.present ? periodo.value : this.periodo,
    referenciaOrigenId: referenciaOrigenId ?? this.referenciaOrigenId,
  );
  Hito copyWithCompanion(HitosCompanion data) {
    return Hito(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      metaNacionalId: data.metaNacionalId.present
          ? data.metaNacionalId.value
          : this.metaNacionalId,
      orden: data.orden.present ? data.orden.value : this.orden,
      anio: data.anio.present ? data.anio.value : this.anio,
      periodo: data.periodo.present ? data.periodo.value : this.periodo,
      referenciaOrigenId: data.referenciaOrigenId.present
          ? data.referenciaOrigenId.value
          : this.referenciaOrigenId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hito(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('metaNacionalId: $metaNacionalId, ')
          ..write('orden: $orden, ')
          ..write('anio: $anio, ')
          ..write('periodo: $periodo, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    codigo,
    nombre,
    descripcion,
    metaNacionalId,
    orden,
    anio,
    periodo,
    referenciaOrigenId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hito &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.metaNacionalId == this.metaNacionalId &&
          other.orden == this.orden &&
          other.anio == this.anio &&
          other.periodo == this.periodo &&
          other.referenciaOrigenId == this.referenciaOrigenId);
}

class HitosCompanion extends UpdateCompanion<Hito> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<String?> nombre;
  final Value<String?> descripcion;
  final Value<int> metaNacionalId;
  final Value<int> orden;
  final Value<int?> anio;
  final Value<String?> periodo;
  final Value<int> referenciaOrigenId;
  const HitosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.metaNacionalId = const Value.absent(),
    this.orden = const Value.absent(),
    this.anio = const Value.absent(),
    this.periodo = const Value.absent(),
    this.referenciaOrigenId = const Value.absent(),
  });
  HitosCompanion.insert({
    this.id = const Value.absent(),
    required String codigo,
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    required int metaNacionalId,
    required int orden,
    this.anio = const Value.absent(),
    this.periodo = const Value.absent(),
    required int referenciaOrigenId,
  }) : codigo = Value(codigo),
       metaNacionalId = Value(metaNacionalId),
       orden = Value(orden),
       referenciaOrigenId = Value(referenciaOrigenId);
  static Insertable<Hito> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? metaNacionalId,
    Expression<int>? orden,
    Expression<int>? anio,
    Expression<String>? periodo,
    Expression<int>? referenciaOrigenId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (metaNacionalId != null) 'meta_nacional_id': metaNacionalId,
      if (orden != null) 'orden': orden,
      if (anio != null) 'anio': anio,
      if (periodo != null) 'periodo': periodo,
      if (referenciaOrigenId != null)
        'referencia_origen_id': referenciaOrigenId,
    });
  }

  HitosCompanion copyWith({
    Value<int>? id,
    Value<String>? codigo,
    Value<String?>? nombre,
    Value<String?>? descripcion,
    Value<int>? metaNacionalId,
    Value<int>? orden,
    Value<int?>? anio,
    Value<String?>? periodo,
    Value<int>? referenciaOrigenId,
  }) {
    return HitosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      metaNacionalId: metaNacionalId ?? this.metaNacionalId,
      orden: orden ?? this.orden,
      anio: anio ?? this.anio,
      periodo: periodo ?? this.periodo,
      referenciaOrigenId: referenciaOrigenId ?? this.referenciaOrigenId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (metaNacionalId.present) {
      map['meta_nacional_id'] = Variable<int>(metaNacionalId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (periodo.present) {
      map['periodo'] = Variable<String>(periodo.value);
    }
    if (referenciaOrigenId.present) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HitosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('metaNacionalId: $metaNacionalId, ')
          ..write('orden: $orden, ')
          ..write('anio: $anio, ')
          ..write('periodo: $periodo, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }
}

class $SubhitosTable extends Subhitos with TableInfo<$SubhitosTable, Subhito> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubhitosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hitoIdMeta = const VerificationMeta('hitoId');
  @override
  late final GeneratedColumn<int> hitoId = GeneratedColumn<int>(
    'hito_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES hitos (id)',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenciaOrigenIdMeta =
      const VerificationMeta('referenciaOrigenId');
  @override
  late final GeneratedColumn<int> referenciaOrigenId = GeneratedColumn<int>(
    'referencia_origen_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES referencias_origen (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    codigo,
    descripcion,
    hitoId,
    orden,
    referenciaOrigenId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subhitos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subhito> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('hito_id')) {
      context.handle(
        _hitoIdMeta,
        hitoId.isAcceptableOrUnknown(data['hito_id']!, _hitoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hitoIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    if (data.containsKey('referencia_origen_id')) {
      context.handle(
        _referenciaOrigenIdMeta,
        referenciaOrigenId.isAcceptableOrUnknown(
          data['referencia_origen_id']!,
          _referenciaOrigenIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subhito map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subhito(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      hitoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hito_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      referenciaOrigenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_origen_id'],
      ),
    );
  }

  @override
  $SubhitosTable createAlias(String alias) {
    return $SubhitosTable(attachedDatabase, alias);
  }
}

class Subhito extends DataClass implements Insertable<Subhito> {
  final int id;
  final String? codigo;
  final String descripcion;
  final int hitoId;
  final int orden;
  final int? referenciaOrigenId;
  const Subhito({
    required this.id,
    this.codigo,
    required this.descripcion,
    required this.hitoId,
    required this.orden,
    this.referenciaOrigenId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    map['descripcion'] = Variable<String>(descripcion);
    map['hito_id'] = Variable<int>(hitoId);
    map['orden'] = Variable<int>(orden);
    if (!nullToAbsent || referenciaOrigenId != null) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId);
    }
    return map;
  }

  SubhitosCompanion toCompanion(bool nullToAbsent) {
    return SubhitosCompanion(
      id: Value(id),
      codigo: codigo == null && nullToAbsent
          ? const Value.absent()
          : Value(codigo),
      descripcion: Value(descripcion),
      hitoId: Value(hitoId),
      orden: Value(orden),
      referenciaOrigenId: referenciaOrigenId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenciaOrigenId),
    );
  }

  factory Subhito.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subhito(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      hitoId: serializer.fromJson<int>(json['hitoId']),
      orden: serializer.fromJson<int>(json['orden']),
      referenciaOrigenId: serializer.fromJson<int?>(json['referenciaOrigenId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'descripcion': serializer.toJson<String>(descripcion),
      'hitoId': serializer.toJson<int>(hitoId),
      'orden': serializer.toJson<int>(orden),
      'referenciaOrigenId': serializer.toJson<int?>(referenciaOrigenId),
    };
  }

  Subhito copyWith({
    int? id,
    Value<String?> codigo = const Value.absent(),
    String? descripcion,
    int? hitoId,
    int? orden,
    Value<int?> referenciaOrigenId = const Value.absent(),
  }) => Subhito(
    id: id ?? this.id,
    codigo: codigo.present ? codigo.value : this.codigo,
    descripcion: descripcion ?? this.descripcion,
    hitoId: hitoId ?? this.hitoId,
    orden: orden ?? this.orden,
    referenciaOrigenId: referenciaOrigenId.present
        ? referenciaOrigenId.value
        : this.referenciaOrigenId,
  );
  Subhito copyWithCompanion(SubhitosCompanion data) {
    return Subhito(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      hitoId: data.hitoId.present ? data.hitoId.value : this.hitoId,
      orden: data.orden.present ? data.orden.value : this.orden,
      referenciaOrigenId: data.referenciaOrigenId.present
          ? data.referenciaOrigenId.value
          : this.referenciaOrigenId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subhito(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descripcion: $descripcion, ')
          ..write('hitoId: $hitoId, ')
          ..write('orden: $orden, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, codigo, descripcion, hitoId, orden, referenciaOrigenId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subhito &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.descripcion == this.descripcion &&
          other.hitoId == this.hitoId &&
          other.orden == this.orden &&
          other.referenciaOrigenId == this.referenciaOrigenId);
}

class SubhitosCompanion extends UpdateCompanion<Subhito> {
  final Value<int> id;
  final Value<String?> codigo;
  final Value<String> descripcion;
  final Value<int> hitoId;
  final Value<int> orden;
  final Value<int?> referenciaOrigenId;
  const SubhitosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.hitoId = const Value.absent(),
    this.orden = const Value.absent(),
    this.referenciaOrigenId = const Value.absent(),
  });
  SubhitosCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    required String descripcion,
    required int hitoId,
    required int orden,
    this.referenciaOrigenId = const Value.absent(),
  }) : descripcion = Value(descripcion),
       hitoId = Value(hitoId),
       orden = Value(orden);
  static Insertable<Subhito> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? descripcion,
    Expression<int>? hitoId,
    Expression<int>? orden,
    Expression<int>? referenciaOrigenId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (descripcion != null) 'descripcion': descripcion,
      if (hitoId != null) 'hito_id': hitoId,
      if (orden != null) 'orden': orden,
      if (referenciaOrigenId != null)
        'referencia_origen_id': referenciaOrigenId,
    });
  }

  SubhitosCompanion copyWith({
    Value<int>? id,
    Value<String?>? codigo,
    Value<String>? descripcion,
    Value<int>? hitoId,
    Value<int>? orden,
    Value<int?>? referenciaOrigenId,
  }) {
    return SubhitosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descripcion: descripcion ?? this.descripcion,
      hitoId: hitoId ?? this.hitoId,
      orden: orden ?? this.orden,
      referenciaOrigenId: referenciaOrigenId ?? this.referenciaOrigenId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (hitoId.present) {
      map['hito_id'] = Variable<int>(hitoId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (referenciaOrigenId.present) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubhitosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descripcion: $descripcion, ')
          ..write('hitoId: $hitoId, ')
          ..write('orden: $orden, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }
}

class $InstitucionesTable extends Instituciones
    with TableInfo<$InstitucionesTable, Institucione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstitucionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreCortoMeta = const VerificationMeta(
    'nombreCorto',
  );
  @override
  late final GeneratedColumn<String> nombreCorto = GeneratedColumn<String>(
    'nombre_corto',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    nombreCorto,
    tipo,
    descripcion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'instituciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Institucione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('nombre_corto')) {
      context.handle(
        _nombreCortoMeta,
        nombreCorto.isAcceptableOrUnknown(
          data['nombre_corto']!,
          _nombreCortoMeta,
        ),
      );
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Institucione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Institucione(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      nombreCorto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_corto'],
      ),
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
    );
  }

  @override
  $InstitucionesTable createAlias(String alias) {
    return $InstitucionesTable(attachedDatabase, alias);
  }
}

class Institucione extends DataClass implements Insertable<Institucione> {
  final int id;
  final String nombre;
  final String? nombreCorto;
  final String? tipo;
  final String? descripcion;
  const Institucione({
    required this.id,
    required this.nombre,
    this.nombreCorto,
    this.tipo,
    this.descripcion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || nombreCorto != null) {
      map['nombre_corto'] = Variable<String>(nombreCorto);
    }
    if (!nullToAbsent || tipo != null) {
      map['tipo'] = Variable<String>(tipo);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  InstitucionesCompanion toCompanion(bool nullToAbsent) {
    return InstitucionesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      nombreCorto: nombreCorto == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreCorto),
      tipo: tipo == null && nullToAbsent ? const Value.absent() : Value(tipo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory Institucione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Institucione(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      nombreCorto: serializer.fromJson<String?>(json['nombreCorto']),
      tipo: serializer.fromJson<String?>(json['tipo']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'nombreCorto': serializer.toJson<String?>(nombreCorto),
      'tipo': serializer.toJson<String?>(tipo),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  Institucione copyWith({
    int? id,
    String? nombre,
    Value<String?> nombreCorto = const Value.absent(),
    Value<String?> tipo = const Value.absent(),
    Value<String?> descripcion = const Value.absent(),
  }) => Institucione(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    nombreCorto: nombreCorto.present ? nombreCorto.value : this.nombreCorto,
    tipo: tipo.present ? tipo.value : this.tipo,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
  );
  Institucione copyWithCompanion(InstitucionesCompanion data) {
    return Institucione(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      nombreCorto: data.nombreCorto.present
          ? data.nombreCorto.value
          : this.nombreCorto,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Institucione(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('nombreCorto: $nombreCorto, ')
          ..write('tipo: $tipo, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, nombreCorto, tipo, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Institucione &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.nombreCorto == this.nombreCorto &&
          other.tipo == this.tipo &&
          other.descripcion == this.descripcion);
}

class InstitucionesCompanion extends UpdateCompanion<Institucione> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> nombreCorto;
  final Value<String?> tipo;
  final Value<String?> descripcion;
  const InstitucionesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.nombreCorto = const Value.absent(),
    this.tipo = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  InstitucionesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.nombreCorto = const Value.absent(),
    this.tipo = const Value.absent(),
    this.descripcion = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Institucione> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? nombreCorto,
    Expression<String>? tipo,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (nombreCorto != null) 'nombre_corto': nombreCorto,
      if (tipo != null) 'tipo': tipo,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  InstitucionesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? nombreCorto,
    Value<String?>? tipo,
    Value<String?>? descripcion,
  }) {
    return InstitucionesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      nombreCorto: nombreCorto ?? this.nombreCorto,
      tipo: tipo ?? this.tipo,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (nombreCorto.present) {
      map['nombre_corto'] = Variable<String>(nombreCorto.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstitucionesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('nombreCorto: $nombreCorto, ')
          ..write('tipo: $tipo, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $ParticipacionesInstitucionalesTable
    extends ParticipacionesInstitucionales
    with
        TableInfo<
          $ParticipacionesInstitucionalesTable,
          ParticipacionesInstitucionale
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParticipacionesInstitucionalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _institucionIdMeta = const VerificationMeta(
    'institucionId',
  );
  @override
  late final GeneratedColumn<int> institucionId = GeneratedColumn<int>(
    'institucion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES instituciones (id)',
    ),
  );
  static const VerificationMeta _metaNacionalIdMeta = const VerificationMeta(
    'metaNacionalId',
  );
  @override
  late final GeneratedColumn<int> metaNacionalId = GeneratedColumn<int>(
    'meta_nacional_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES metas_nacionales (id)',
    ),
  );
  static const VerificationMeta _hitoIdMeta = const VerificationMeta('hitoId');
  @override
  late final GeneratedColumn<int> hitoId = GeneratedColumn<int>(
    'hito_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES hitos (id)',
    ),
  );
  static const VerificationMeta _tipoParticipacionMeta = const VerificationMeta(
    'tipoParticipacion',
  );
  @override
  late final GeneratedColumn<String> tipoParticipacion =
      GeneratedColumn<String>(
        'tipo_participacion',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenciaOrigenIdMeta =
      const VerificationMeta('referenciaOrigenId');
  @override
  late final GeneratedColumn<int> referenciaOrigenId = GeneratedColumn<int>(
    'referencia_origen_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES referencias_origen (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    institucionId,
    metaNacionalId,
    hitoId,
    tipoParticipacion,
    descripcion,
    referenciaOrigenId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'participaciones_institucionales';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParticipacionesInstitucionale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('institucion_id')) {
      context.handle(
        _institucionIdMeta,
        institucionId.isAcceptableOrUnknown(
          data['institucion_id']!,
          _institucionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institucionIdMeta);
    }
    if (data.containsKey('meta_nacional_id')) {
      context.handle(
        _metaNacionalIdMeta,
        metaNacionalId.isAcceptableOrUnknown(
          data['meta_nacional_id']!,
          _metaNacionalIdMeta,
        ),
      );
    }
    if (data.containsKey('hito_id')) {
      context.handle(
        _hitoIdMeta,
        hitoId.isAcceptableOrUnknown(data['hito_id']!, _hitoIdMeta),
      );
    }
    if (data.containsKey('tipo_participacion')) {
      context.handle(
        _tipoParticipacionMeta,
        tipoParticipacion.isAcceptableOrUnknown(
          data['tipo_participacion']!,
          _tipoParticipacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoParticipacionMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('referencia_origen_id')) {
      context.handle(
        _referenciaOrigenIdMeta,
        referenciaOrigenId.isAcceptableOrUnknown(
          data['referencia_origen_id']!,
          _referenciaOrigenIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParticipacionesInstitucionale map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParticipacionesInstitucionale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      institucionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institucion_id'],
      )!,
      metaNacionalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meta_nacional_id'],
      ),
      hitoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hito_id'],
      ),
      tipoParticipacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_participacion'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      referenciaOrigenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_origen_id'],
      ),
    );
  }

  @override
  $ParticipacionesInstitucionalesTable createAlias(String alias) {
    return $ParticipacionesInstitucionalesTable(attachedDatabase, alias);
  }
}

class ParticipacionesInstitucionale extends DataClass
    implements Insertable<ParticipacionesInstitucionale> {
  final int id;
  final int institucionId;
  final int? metaNacionalId;
  final int? hitoId;
  final String tipoParticipacion;
  final String? descripcion;
  final int? referenciaOrigenId;
  const ParticipacionesInstitucionale({
    required this.id,
    required this.institucionId,
    this.metaNacionalId,
    this.hitoId,
    required this.tipoParticipacion,
    this.descripcion,
    this.referenciaOrigenId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['institucion_id'] = Variable<int>(institucionId);
    if (!nullToAbsent || metaNacionalId != null) {
      map['meta_nacional_id'] = Variable<int>(metaNacionalId);
    }
    if (!nullToAbsent || hitoId != null) {
      map['hito_id'] = Variable<int>(hitoId);
    }
    map['tipo_participacion'] = Variable<String>(tipoParticipacion);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || referenciaOrigenId != null) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId);
    }
    return map;
  }

  ParticipacionesInstitucionalesCompanion toCompanion(bool nullToAbsent) {
    return ParticipacionesInstitucionalesCompanion(
      id: Value(id),
      institucionId: Value(institucionId),
      metaNacionalId: metaNacionalId == null && nullToAbsent
          ? const Value.absent()
          : Value(metaNacionalId),
      hitoId: hitoId == null && nullToAbsent
          ? const Value.absent()
          : Value(hitoId),
      tipoParticipacion: Value(tipoParticipacion),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      referenciaOrigenId: referenciaOrigenId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenciaOrigenId),
    );
  }

  factory ParticipacionesInstitucionale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParticipacionesInstitucionale(
      id: serializer.fromJson<int>(json['id']),
      institucionId: serializer.fromJson<int>(json['institucionId']),
      metaNacionalId: serializer.fromJson<int?>(json['metaNacionalId']),
      hitoId: serializer.fromJson<int?>(json['hitoId']),
      tipoParticipacion: serializer.fromJson<String>(json['tipoParticipacion']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      referenciaOrigenId: serializer.fromJson<int?>(json['referenciaOrigenId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'institucionId': serializer.toJson<int>(institucionId),
      'metaNacionalId': serializer.toJson<int?>(metaNacionalId),
      'hitoId': serializer.toJson<int?>(hitoId),
      'tipoParticipacion': serializer.toJson<String>(tipoParticipacion),
      'descripcion': serializer.toJson<String?>(descripcion),
      'referenciaOrigenId': serializer.toJson<int?>(referenciaOrigenId),
    };
  }

  ParticipacionesInstitucionale copyWith({
    int? id,
    int? institucionId,
    Value<int?> metaNacionalId = const Value.absent(),
    Value<int?> hitoId = const Value.absent(),
    String? tipoParticipacion,
    Value<String?> descripcion = const Value.absent(),
    Value<int?> referenciaOrigenId = const Value.absent(),
  }) => ParticipacionesInstitucionale(
    id: id ?? this.id,
    institucionId: institucionId ?? this.institucionId,
    metaNacionalId: metaNacionalId.present
        ? metaNacionalId.value
        : this.metaNacionalId,
    hitoId: hitoId.present ? hitoId.value : this.hitoId,
    tipoParticipacion: tipoParticipacion ?? this.tipoParticipacion,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    referenciaOrigenId: referenciaOrigenId.present
        ? referenciaOrigenId.value
        : this.referenciaOrigenId,
  );
  ParticipacionesInstitucionale copyWithCompanion(
    ParticipacionesInstitucionalesCompanion data,
  ) {
    return ParticipacionesInstitucionale(
      id: data.id.present ? data.id.value : this.id,
      institucionId: data.institucionId.present
          ? data.institucionId.value
          : this.institucionId,
      metaNacionalId: data.metaNacionalId.present
          ? data.metaNacionalId.value
          : this.metaNacionalId,
      hitoId: data.hitoId.present ? data.hitoId.value : this.hitoId,
      tipoParticipacion: data.tipoParticipacion.present
          ? data.tipoParticipacion.value
          : this.tipoParticipacion,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      referenciaOrigenId: data.referenciaOrigenId.present
          ? data.referenciaOrigenId.value
          : this.referenciaOrigenId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParticipacionesInstitucionale(')
          ..write('id: $id, ')
          ..write('institucionId: $institucionId, ')
          ..write('metaNacionalId: $metaNacionalId, ')
          ..write('hitoId: $hitoId, ')
          ..write('tipoParticipacion: $tipoParticipacion, ')
          ..write('descripcion: $descripcion, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    institucionId,
    metaNacionalId,
    hitoId,
    tipoParticipacion,
    descripcion,
    referenciaOrigenId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParticipacionesInstitucionale &&
          other.id == this.id &&
          other.institucionId == this.institucionId &&
          other.metaNacionalId == this.metaNacionalId &&
          other.hitoId == this.hitoId &&
          other.tipoParticipacion == this.tipoParticipacion &&
          other.descripcion == this.descripcion &&
          other.referenciaOrigenId == this.referenciaOrigenId);
}

class ParticipacionesInstitucionalesCompanion
    extends UpdateCompanion<ParticipacionesInstitucionale> {
  final Value<int> id;
  final Value<int> institucionId;
  final Value<int?> metaNacionalId;
  final Value<int?> hitoId;
  final Value<String> tipoParticipacion;
  final Value<String?> descripcion;
  final Value<int?> referenciaOrigenId;
  const ParticipacionesInstitucionalesCompanion({
    this.id = const Value.absent(),
    this.institucionId = const Value.absent(),
    this.metaNacionalId = const Value.absent(),
    this.hitoId = const Value.absent(),
    this.tipoParticipacion = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.referenciaOrigenId = const Value.absent(),
  });
  ParticipacionesInstitucionalesCompanion.insert({
    this.id = const Value.absent(),
    required int institucionId,
    this.metaNacionalId = const Value.absent(),
    this.hitoId = const Value.absent(),
    required String tipoParticipacion,
    this.descripcion = const Value.absent(),
    this.referenciaOrigenId = const Value.absent(),
  }) : institucionId = Value(institucionId),
       tipoParticipacion = Value(tipoParticipacion);
  static Insertable<ParticipacionesInstitucionale> custom({
    Expression<int>? id,
    Expression<int>? institucionId,
    Expression<int>? metaNacionalId,
    Expression<int>? hitoId,
    Expression<String>? tipoParticipacion,
    Expression<String>? descripcion,
    Expression<int>? referenciaOrigenId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (institucionId != null) 'institucion_id': institucionId,
      if (metaNacionalId != null) 'meta_nacional_id': metaNacionalId,
      if (hitoId != null) 'hito_id': hitoId,
      if (tipoParticipacion != null) 'tipo_participacion': tipoParticipacion,
      if (descripcion != null) 'descripcion': descripcion,
      if (referenciaOrigenId != null)
        'referencia_origen_id': referenciaOrigenId,
    });
  }

  ParticipacionesInstitucionalesCompanion copyWith({
    Value<int>? id,
    Value<int>? institucionId,
    Value<int?>? metaNacionalId,
    Value<int?>? hitoId,
    Value<String>? tipoParticipacion,
    Value<String?>? descripcion,
    Value<int?>? referenciaOrigenId,
  }) {
    return ParticipacionesInstitucionalesCompanion(
      id: id ?? this.id,
      institucionId: institucionId ?? this.institucionId,
      metaNacionalId: metaNacionalId ?? this.metaNacionalId,
      hitoId: hitoId ?? this.hitoId,
      tipoParticipacion: tipoParticipacion ?? this.tipoParticipacion,
      descripcion: descripcion ?? this.descripcion,
      referenciaOrigenId: referenciaOrigenId ?? this.referenciaOrigenId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (institucionId.present) {
      map['institucion_id'] = Variable<int>(institucionId.value);
    }
    if (metaNacionalId.present) {
      map['meta_nacional_id'] = Variable<int>(metaNacionalId.value);
    }
    if (hitoId.present) {
      map['hito_id'] = Variable<int>(hitoId.value);
    }
    if (tipoParticipacion.present) {
      map['tipo_participacion'] = Variable<String>(tipoParticipacion.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (referenciaOrigenId.present) {
      map['referencia_origen_id'] = Variable<int>(referenciaOrigenId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParticipacionesInstitucionalesCompanion(')
          ..write('id: $id, ')
          ..write('institucionId: $institucionId, ')
          ..write('metaNacionalId: $metaNacionalId, ')
          ..write('hitoId: $hitoId, ')
          ..write('tipoParticipacion: $tipoParticipacion, ')
          ..write('descripcion: $descripcion, ')
          ..write('referenciaOrigenId: $referenciaOrigenId')
          ..write(')'))
        .toString();
  }
}

class $SiglasAcronimosTable extends SiglasAcronimos
    with TableInfo<$SiglasAcronimosTable, SiglasAcronimo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SiglasAcronimosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _institucionIdMeta = const VerificationMeta(
    'institucionId',
  );
  @override
  late final GeneratedColumn<int> institucionId = GeneratedColumn<int>(
    'institucion_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES instituciones (id)',
    ),
  );
  static const VerificationMeta _siglaMeta = const VerificationMeta('sigla');
  @override
  late final GeneratedColumn<String> sigla = GeneratedColumn<String>(
    'sigla',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, institucionId, sigla, descripcion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'siglas_acronimos';
  @override
  VerificationContext validateIntegrity(
    Insertable<SiglasAcronimo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('institucion_id')) {
      context.handle(
        _institucionIdMeta,
        institucionId.isAcceptableOrUnknown(
          data['institucion_id']!,
          _institucionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institucionIdMeta);
    }
    if (data.containsKey('sigla')) {
      context.handle(
        _siglaMeta,
        sigla.isAcceptableOrUnknown(data['sigla']!, _siglaMeta),
      );
    } else if (isInserting) {
      context.missing(_siglaMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SiglasAcronimo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SiglasAcronimo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      institucionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}institucion_id'],
      )!,
      sigla: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sigla'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
    );
  }

  @override
  $SiglasAcronimosTable createAlias(String alias) {
    return $SiglasAcronimosTable(attachedDatabase, alias);
  }
}

class SiglasAcronimo extends DataClass implements Insertable<SiglasAcronimo> {
  final int id;
  final int institucionId;
  final String sigla;
  final String? descripcion;
  const SiglasAcronimo({
    required this.id,
    required this.institucionId,
    required this.sigla,
    this.descripcion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['institucion_id'] = Variable<int>(institucionId);
    map['sigla'] = Variable<String>(sigla);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    return map;
  }

  SiglasAcronimosCompanion toCompanion(bool nullToAbsent) {
    return SiglasAcronimosCompanion(
      id: Value(id),
      institucionId: Value(institucionId),
      sigla: Value(sigla),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
    );
  }

  factory SiglasAcronimo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiglasAcronimo(
      id: serializer.fromJson<int>(json['id']),
      institucionId: serializer.fromJson<int>(json['institucionId']),
      sigla: serializer.fromJson<String>(json['sigla']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'institucionId': serializer.toJson<int>(institucionId),
      'sigla': serializer.toJson<String>(sigla),
      'descripcion': serializer.toJson<String?>(descripcion),
    };
  }

  SiglasAcronimo copyWith({
    int? id,
    int? institucionId,
    String? sigla,
    Value<String?> descripcion = const Value.absent(),
  }) => SiglasAcronimo(
    id: id ?? this.id,
    institucionId: institucionId ?? this.institucionId,
    sigla: sigla ?? this.sigla,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
  );
  SiglasAcronimo copyWithCompanion(SiglasAcronimosCompanion data) {
    return SiglasAcronimo(
      id: data.id.present ? data.id.value : this.id,
      institucionId: data.institucionId.present
          ? data.institucionId.value
          : this.institucionId,
      sigla: data.sigla.present ? data.sigla.value : this.sigla,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SiglasAcronimo(')
          ..write('id: $id, ')
          ..write('institucionId: $institucionId, ')
          ..write('sigla: $sigla, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, institucionId, sigla, descripcion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiglasAcronimo &&
          other.id == this.id &&
          other.institucionId == this.institucionId &&
          other.sigla == this.sigla &&
          other.descripcion == this.descripcion);
}

class SiglasAcronimosCompanion extends UpdateCompanion<SiglasAcronimo> {
  final Value<int> id;
  final Value<int> institucionId;
  final Value<String> sigla;
  final Value<String?> descripcion;
  const SiglasAcronimosCompanion({
    this.id = const Value.absent(),
    this.institucionId = const Value.absent(),
    this.sigla = const Value.absent(),
    this.descripcion = const Value.absent(),
  });
  SiglasAcronimosCompanion.insert({
    this.id = const Value.absent(),
    required int institucionId,
    required String sigla,
    this.descripcion = const Value.absent(),
  }) : institucionId = Value(institucionId),
       sigla = Value(sigla);
  static Insertable<SiglasAcronimo> custom({
    Expression<int>? id,
    Expression<int>? institucionId,
    Expression<String>? sigla,
    Expression<String>? descripcion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (institucionId != null) 'institucion_id': institucionId,
      if (sigla != null) 'sigla': sigla,
      if (descripcion != null) 'descripcion': descripcion,
    });
  }

  SiglasAcronimosCompanion copyWith({
    Value<int>? id,
    Value<int>? institucionId,
    Value<String>? sigla,
    Value<String?>? descripcion,
  }) {
    return SiglasAcronimosCompanion(
      id: id ?? this.id,
      institucionId: institucionId ?? this.institucionId,
      sigla: sigla ?? this.sigla,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (institucionId.present) {
      map['institucion_id'] = Variable<int>(institucionId.value);
    }
    if (sigla.present) {
      map['sigla'] = Variable<String>(sigla.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiglasAcronimosCompanion(')
          ..write('id: $id, ')
          ..write('institucionId: $institucionId, ')
          ..write('sigla: $sigla, ')
          ..write('descripcion: $descripcion')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionContenidoTable extends ConfiguracionContenido
    with TableInfo<$ConfiguracionContenidoTable, ConfiguracionContenidoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionContenidoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuracion_contenido';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConfiguracionContenidoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  ConfiguracionContenidoData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfiguracionContenidoData(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      )!,
    );
  }

  @override
  $ConfiguracionContenidoTable createAlias(String alias) {
    return $ConfiguracionContenidoTable(attachedDatabase, alias);
  }
}

class ConfiguracionContenidoData extends DataClass
    implements Insertable<ConfiguracionContenidoData> {
  final String clave;
  final String valor;
  const ConfiguracionContenidoData({required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  ConfiguracionContenidoCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionContenidoCompanion(
      clave: Value(clave),
      valor: Value(valor),
    );
  }

  factory ConfiguracionContenidoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfiguracionContenidoData(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  ConfiguracionContenidoData copyWith({String? clave, String? valor}) =>
      ConfiguracionContenidoData(
        clave: clave ?? this.clave,
        valor: valor ?? this.valor,
      );
  ConfiguracionContenidoData copyWithCompanion(
    ConfiguracionContenidoCompanion data,
  ) {
    return ConfiguracionContenidoData(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionContenidoData(')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfiguracionContenidoData &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class ConfiguracionContenidoCompanion
    extends UpdateCompanion<ConfiguracionContenidoData> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<int> rowid;
  const ConfiguracionContenidoCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionContenidoCompanion.insert({
    required String clave,
    required String valor,
    this.rowid = const Value.absent(),
  }) : clave = Value(clave),
       valor = Value(valor);
  static Insertable<ConfiguracionContenidoData> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionContenidoCompanion copyWith({
    Value<String>? clave,
    Value<String>? valor,
    Value<int>? rowid,
  }) {
    return ConfiguracionContenidoCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionContenidoCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PublicacionesTable publicaciones = $PublicacionesTable(this);
  late final $ReferenciasOrigenTable referenciasOrigen =
      $ReferenciasOrigenTable(this);
  late final $EjesTable ejes = $EjesTable(this);
  late final $MetasGlobalesTable metasGlobales = $MetasGlobalesTable(this);
  late final $MetasNacionalesTable metasNacionales = $MetasNacionalesTable(
    this,
  );
  late final $HitosTable hitos = $HitosTable(this);
  late final $SubhitosTable subhitos = $SubhitosTable(this);
  late final $InstitucionesTable instituciones = $InstitucionesTable(this);
  late final $ParticipacionesInstitucionalesTable
  participacionesInstitucionales = $ParticipacionesInstitucionalesTable(this);
  late final $SiglasAcronimosTable siglasAcronimos = $SiglasAcronimosTable(
    this,
  );
  late final $ConfiguracionContenidoTable configuracionContenido =
      $ConfiguracionContenidoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    publicaciones,
    referenciasOrigen,
    ejes,
    metasGlobales,
    metasNacionales,
    hitos,
    subhitos,
    instituciones,
    participacionesInstitucionales,
    siglasAcronimos,
    configuracionContenido,
  ];
}

typedef $$PublicacionesTableCreateCompanionBuilder =
    PublicacionesCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> edicion,
      Value<int?> anio,
      Value<String?> descripcion,
    });
typedef $$PublicacionesTableUpdateCompanionBuilder =
    PublicacionesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> edicion,
      Value<int?> anio,
      Value<String?> descripcion,
    });

final class $$PublicacionesTableReferences
    extends BaseReferences<_$AppDatabase, $PublicacionesTable, Publicacione> {
  $$PublicacionesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EjesTable, List<Eje>> _ejesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ejes,
    aliasName: 'publicaciones__id__ejes__publicacion_id',
  );

  $$EjesTableProcessedTableManager get ejesRefs {
    final manager = $$EjesTableTableManager(
      $_db,
      $_db.ejes,
    ).filter((f) => f.publicacionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ejesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MetasNacionalesTable, List<MetasNacionale>>
  _metasNacionalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metasNacionales,
    aliasName: 'publicaciones__id__metas_nacionales__publicacion_id',
  );

  $$MetasNacionalesTableProcessedTableManager get metasNacionalesRefs {
    final manager = $$MetasNacionalesTableTableManager(
      $_db,
      $_db.metasNacionales,
    ).filter((f) => f.publicacionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metasNacionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PublicacionesTableFilterComposer
    extends Composer<_$AppDatabase, $PublicacionesTable> {
  $$PublicacionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get edicion => $composableBuilder(
    column: $table.edicion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ejesRefs(
    Expression<bool> Function($$EjesTableFilterComposer f) f,
  ) {
    final $$EjesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.publicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableFilterComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> metasNacionalesRefs(
    Expression<bool> Function($$MetasNacionalesTableFilterComposer f) f,
  ) {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.publicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PublicacionesTableOrderingComposer
    extends Composer<_$AppDatabase, $PublicacionesTable> {
  $$PublicacionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get edicion => $composableBuilder(
    column: $table.edicion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PublicacionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PublicacionesTable> {
  $$PublicacionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get edicion =>
      $composableBuilder(column: $table.edicion, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  Expression<T> ejesRefs<T extends Object>(
    Expression<T> Function($$EjesTableAnnotationComposer a) f,
  ) {
    final $$EjesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.publicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableAnnotationComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> metasNacionalesRefs<T extends Object>(
    Expression<T> Function($$MetasNacionalesTableAnnotationComposer a) f,
  ) {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.publicacionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PublicacionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PublicacionesTable,
          Publicacione,
          $$PublicacionesTableFilterComposer,
          $$PublicacionesTableOrderingComposer,
          $$PublicacionesTableAnnotationComposer,
          $$PublicacionesTableCreateCompanionBuilder,
          $$PublicacionesTableUpdateCompanionBuilder,
          (Publicacione, $$PublicacionesTableReferences),
          Publicacione,
          PrefetchHooks Function({bool ejesRefs, bool metasNacionalesRefs})
        > {
  $$PublicacionesTableTableManager(_$AppDatabase db, $PublicacionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PublicacionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PublicacionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PublicacionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> edicion = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => PublicacionesCompanion(
                id: id,
                nombre: nombre,
                edicion: edicion,
                anio: anio,
                descripcion: descripcion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> edicion = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => PublicacionesCompanion.insert(
                id: id,
                nombre: nombre,
                edicion: edicion,
                anio: anio,
                descripcion: descripcion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PublicacionesTable, Publicacione>(table),
                  $$PublicacionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ejesRefs = false, metasNacionalesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ejesRefs) db.ejes,
                    if (metasNacionalesRefs) db.metasNacionales,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ejesRefs)
                        await $_getPrefetchedData<
                          Publicacione,
                          $PublicacionesTable,
                          Eje
                        >(
                          currentTable: table,
                          referencedTable: $$PublicacionesTableReferences
                              ._ejesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PublicacionesTableReferences(
                                db,
                                table,
                                p0,
                              ).ejesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.publicacionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (metasNacionalesRefs)
                        await $_getPrefetchedData<
                          Publicacione,
                          $PublicacionesTable,
                          MetasNacionale
                        >(
                          currentTable: table,
                          referencedTable: $$PublicacionesTableReferences
                              ._metasNacionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PublicacionesTableReferences(
                                db,
                                table,
                                p0,
                              ).metasNacionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.publicacionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PublicacionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PublicacionesTable,
      Publicacione,
      $$PublicacionesTableFilterComposer,
      $$PublicacionesTableOrderingComposer,
      $$PublicacionesTableAnnotationComposer,
      $$PublicacionesTableCreateCompanionBuilder,
      $$PublicacionesTableUpdateCompanionBuilder,
      (Publicacione, $$PublicacionesTableReferences),
      Publicacione,
      PrefetchHooks Function({bool ejesRefs, bool metasNacionalesRefs})
    >;
typedef $$ReferenciasOrigenTableCreateCompanionBuilder =
    ReferenciasOrigenCompanion Function({
      Value<int> id,
      required String documento,
      Value<String?> edicion,
      Value<int?> anio,
      Value<int?> pagina,
      Value<String?> seccion,
      Value<String?> observacion,
    });
typedef $$ReferenciasOrigenTableUpdateCompanionBuilder =
    ReferenciasOrigenCompanion Function({
      Value<int> id,
      Value<String> documento,
      Value<String?> edicion,
      Value<int?> anio,
      Value<int?> pagina,
      Value<String?> seccion,
      Value<String?> observacion,
    });

final class $$ReferenciasOrigenTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReferenciasOrigenTable,
          ReferenciasOrigenData
        > {
  $$ReferenciasOrigenTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MetasNacionalesTable, List<MetasNacionale>>
  _metasNacionalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metasNacionales,
    aliasName: 'referencias_origen__id__metas_nacionales__referencia_origen_id',
  );

  $$MetasNacionalesTableProcessedTableManager get metasNacionalesRefs {
    final manager =
        $$MetasNacionalesTableTableManager($_db, $_db.metasNacionales).filter(
          (f) => f.referenciaOrigenId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _metasNacionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HitosTable, List<Hito>> _hitosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.hitos,
    aliasName: 'referencias_origen__id__hitos__referencia_origen_id',
  );

  $$HitosTableProcessedTableManager get hitosRefs {
    final manager = $$HitosTableTableManager($_db, $_db.hitos).filter(
      (f) => f.referenciaOrigenId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_hitosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubhitosTable, List<Subhito>> _subhitosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subhitos,
    aliasName: 'referencias_origen__id__subhitos__referencia_origen_id',
  );

  $$SubhitosTableProcessedTableManager get subhitosRefs {
    final manager = $$SubhitosTableTableManager($_db, $_db.subhitos).filter(
      (f) => f.referenciaOrigenId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_subhitosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ParticipacionesInstitucionalesTable,
    List<ParticipacionesInstitucionale>
  >
  _participacionesInstitucionalesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.participacionesInstitucionales,
        aliasName: 'referencias_origen__id__participaciones_institucionales__referencia_origen_id',
      );

  $$ParticipacionesInstitucionalesTableProcessedTableManager
  get participacionesInstitucionalesRefs {
    final manager =
        $$ParticipacionesInstitucionalesTableTableManager(
          $_db,
          $_db.participacionesInstitucionales,
        ).filter(
          (f) => f.referenciaOrigenId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _participacionesInstitucionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReferenciasOrigenTableFilterComposer
    extends Composer<_$AppDatabase, $ReferenciasOrigenTable> {
  $$ReferenciasOrigenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documento => $composableBuilder(
    column: $table.documento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get edicion => $composableBuilder(
    column: $table.edicion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pagina => $composableBuilder(
    column: $table.pagina,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seccion => $composableBuilder(
    column: $table.seccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> metasNacionalesRefs(
    Expression<bool> Function($$MetasNacionalesTableFilterComposer f) f,
  ) {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> hitosRefs(
    Expression<bool> Function($$HitosTableFilterComposer f) f,
  ) {
    final $$HitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableFilterComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> subhitosRefs(
    Expression<bool> Function($$SubhitosTableFilterComposer f) f,
  ) {
    final $$SubhitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subhitos,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubhitosTableFilterComposer(
            $db: $db,
            $table: $db.subhitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> participacionesInstitucionalesRefs(
    Expression<bool> Function(
      $$ParticipacionesInstitucionalesTableFilterComposer f,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.referenciaOrigenId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableFilterComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReferenciasOrigenTableOrderingComposer
    extends Composer<_$AppDatabase, $ReferenciasOrigenTable> {
  $$ReferenciasOrigenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documento => $composableBuilder(
    column: $table.documento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get edicion => $composableBuilder(
    column: $table.edicion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pagina => $composableBuilder(
    column: $table.pagina,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seccion => $composableBuilder(
    column: $table.seccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReferenciasOrigenTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReferenciasOrigenTable> {
  $$ReferenciasOrigenTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documento =>
      $composableBuilder(column: $table.documento, builder: (column) => column);

  GeneratedColumn<String> get edicion =>
      $composableBuilder(column: $table.edicion, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<int> get pagina =>
      $composableBuilder(column: $table.pagina, builder: (column) => column);

  GeneratedColumn<String> get seccion =>
      $composableBuilder(column: $table.seccion, builder: (column) => column);

  GeneratedColumn<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => column,
  );

  Expression<T> metasNacionalesRefs<T extends Object>(
    Expression<T> Function($$MetasNacionalesTableAnnotationComposer a) f,
  ) {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> hitosRefs<T extends Object>(
    Expression<T> Function($$HitosTableAnnotationComposer a) f,
  ) {
    final $$HitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableAnnotationComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> subhitosRefs<T extends Object>(
    Expression<T> Function($$SubhitosTableAnnotationComposer a) f,
  ) {
    final $$SubhitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subhitos,
      getReferencedColumn: (t) => t.referenciaOrigenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubhitosTableAnnotationComposer(
            $db: $db,
            $table: $db.subhitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> participacionesInstitucionalesRefs<T extends Object>(
    Expression<T> Function(
      $$ParticipacionesInstitucionalesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.referenciaOrigenId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableAnnotationComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ReferenciasOrigenTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReferenciasOrigenTable,
          ReferenciasOrigenData,
          $$ReferenciasOrigenTableFilterComposer,
          $$ReferenciasOrigenTableOrderingComposer,
          $$ReferenciasOrigenTableAnnotationComposer,
          $$ReferenciasOrigenTableCreateCompanionBuilder,
          $$ReferenciasOrigenTableUpdateCompanionBuilder,
          (ReferenciasOrigenData, $$ReferenciasOrigenTableReferences),
          ReferenciasOrigenData,
          PrefetchHooks Function({
            bool metasNacionalesRefs,
            bool hitosRefs,
            bool subhitosRefs,
            bool participacionesInstitucionalesRefs,
          })
        > {
  $$ReferenciasOrigenTableTableManager(
    _$AppDatabase db,
    $ReferenciasOrigenTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReferenciasOrigenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReferenciasOrigenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReferenciasOrigenTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> documento = const Value.absent(),
                Value<String?> edicion = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<int?> pagina = const Value.absent(),
                Value<String?> seccion = const Value.absent(),
                Value<String?> observacion = const Value.absent(),
              }) => ReferenciasOrigenCompanion(
                id: id,
                documento: documento,
                edicion: edicion,
                anio: anio,
                pagina: pagina,
                seccion: seccion,
                observacion: observacion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String documento,
                Value<String?> edicion = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<int?> pagina = const Value.absent(),
                Value<String?> seccion = const Value.absent(),
                Value<String?> observacion = const Value.absent(),
              }) => ReferenciasOrigenCompanion.insert(
                id: id,
                documento: documento,
                edicion: edicion,
                anio: anio,
                pagina: pagina,
                seccion: seccion,
                observacion: observacion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReferenciasOrigenTable, ReferenciasOrigenData>(
                    table,
                  ),
                  $$ReferenciasOrigenTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                metasNacionalesRefs = false,
                hitosRefs = false,
                subhitosRefs = false,
                participacionesInstitucionalesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (metasNacionalesRefs) db.metasNacionales,
                    if (hitosRefs) db.hitos,
                    if (subhitosRefs) db.subhitos,
                    if (participacionesInstitucionalesRefs)
                      db.participacionesInstitucionales,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (metasNacionalesRefs)
                        await $_getPrefetchedData<
                          ReferenciasOrigenData,
                          $ReferenciasOrigenTable,
                          MetasNacionale
                        >(
                          currentTable: table,
                          referencedTable: $$ReferenciasOrigenTableReferences
                              ._metasNacionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReferenciasOrigenTableReferences(
                                db,
                                table,
                                p0,
                              ).metasNacionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.referenciaOrigenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (hitosRefs)
                        await $_getPrefetchedData<
                          ReferenciasOrigenData,
                          $ReferenciasOrigenTable,
                          Hito
                        >(
                          currentTable: table,
                          referencedTable: $$ReferenciasOrigenTableReferences
                              ._hitosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReferenciasOrigenTableReferences(
                                db,
                                table,
                                p0,
                              ).hitosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.referenciaOrigenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (subhitosRefs)
                        await $_getPrefetchedData<
                          ReferenciasOrigenData,
                          $ReferenciasOrigenTable,
                          Subhito
                        >(
                          currentTable: table,
                          referencedTable: $$ReferenciasOrigenTableReferences
                              ._subhitosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReferenciasOrigenTableReferences(
                                db,
                                table,
                                p0,
                              ).subhitosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.referenciaOrigenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (participacionesInstitucionalesRefs)
                        await $_getPrefetchedData<
                          ReferenciasOrigenData,
                          $ReferenciasOrigenTable,
                          ParticipacionesInstitucionale
                        >(
                          currentTable: table,
                          referencedTable: $$ReferenciasOrigenTableReferences
                              ._participacionesInstitucionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReferenciasOrigenTableReferences(
                                db,
                                table,
                                p0,
                              ).participacionesInstitucionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.referenciaOrigenId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReferenciasOrigenTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReferenciasOrigenTable,
      ReferenciasOrigenData,
      $$ReferenciasOrigenTableFilterComposer,
      $$ReferenciasOrigenTableOrderingComposer,
      $$ReferenciasOrigenTableAnnotationComposer,
      $$ReferenciasOrigenTableCreateCompanionBuilder,
      $$ReferenciasOrigenTableUpdateCompanionBuilder,
      (ReferenciasOrigenData, $$ReferenciasOrigenTableReferences),
      ReferenciasOrigenData,
      PrefetchHooks Function({
        bool metasNacionalesRefs,
        bool hitosRefs,
        bool subhitosRefs,
        bool participacionesInstitucionalesRefs,
      })
    >;
typedef $$EjesTableCreateCompanionBuilder = EjesCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> descripcion,
  required int publicacionId,
  required int orden,
});
typedef $$EjesTableUpdateCompanionBuilder = EjesCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> descripcion,
  Value<int> publicacionId,
  Value<int> orden,
});

final class $$EjesTableReferences
    extends BaseReferences<_$AppDatabase, $EjesTable, Eje> {
  $$EjesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PublicacionesTable _publicacionIdTable(_$AppDatabase db) =>
      db.publicaciones.createAlias('ejes__publicacion_id__publicaciones__id');

  $$PublicacionesTableProcessedTableManager get publicacionId {
    final $_column = $_itemColumn<int>('publicacion_id')!;

    final manager = $$PublicacionesTableTableManager(
      $_db,
      $_db.publicaciones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_publicacionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MetasGlobalesTable, List<MetasGlobale>>
  _metasGlobalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metasGlobales,
    aliasName: 'ejes__id__metas_globales__eje_id',
  );

  $$MetasGlobalesTableProcessedTableManager get metasGlobalesRefs {
    final manager = $$MetasGlobalesTableTableManager(
      $_db,
      $_db.metasGlobales,
    ).filter((f) => f.ejeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_metasGlobalesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MetasNacionalesTable, List<MetasNacionale>>
  _metasNacionalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metasNacionales,
    aliasName: 'ejes__id__metas_nacionales__eje_id',
  );

  $$MetasNacionalesTableProcessedTableManager get metasNacionalesRefs {
    final manager = $$MetasNacionalesTableTableManager(
      $_db,
      $_db.metasNacionales,
    ).filter((f) => f.ejeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metasNacionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EjesTableFilterComposer extends Composer<_$AppDatabase, $EjesTable> {
  $$EjesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  $$PublicacionesTableFilterComposer get publicacionId {
    final $$PublicacionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableFilterComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> metasGlobalesRefs(
    Expression<bool> Function($$MetasGlobalesTableFilterComposer f) f,
  ) {
    final $$MetasGlobalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasGlobales,
      getReferencedColumn: (t) => t.ejeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasGlobalesTableFilterComposer(
            $db: $db,
            $table: $db.metasGlobales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> metasNacionalesRefs(
    Expression<bool> Function($$MetasNacionalesTableFilterComposer f) f,
  ) {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.ejeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EjesTableOrderingComposer extends Composer<_$AppDatabase, $EjesTable> {
  $$EjesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  $$PublicacionesTableOrderingComposer get publicacionId {
    final $$PublicacionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableOrderingComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EjesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EjesTable> {
  $$EjesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  $$PublicacionesTableAnnotationComposer get publicacionId {
    final $$PublicacionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableAnnotationComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> metasGlobalesRefs<T extends Object>(
    Expression<T> Function($$MetasGlobalesTableAnnotationComposer a) f,
  ) {
    final $$MetasGlobalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasGlobales,
      getReferencedColumn: (t) => t.ejeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasGlobalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasGlobales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> metasNacionalesRefs<T extends Object>(
    Expression<T> Function($$MetasNacionalesTableAnnotationComposer a) f,
  ) {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.ejeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EjesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EjesTable,
          Eje,
          $$EjesTableFilterComposer,
          $$EjesTableOrderingComposer,
          $$EjesTableAnnotationComposer,
          $$EjesTableCreateCompanionBuilder,
          $$EjesTableUpdateCompanionBuilder,
          (Eje, $$EjesTableReferences),
          Eje,
          PrefetchHooks Function({
            bool publicacionId,
            bool metasGlobalesRefs,
            bool metasNacionalesRefs,
          })
        > {
  $$EjesTableTableManager(_$AppDatabase db, $EjesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EjesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EjesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EjesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> publicacionId = const Value.absent(),
                Value<int> orden = const Value.absent(),
              }) => EjesCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                publicacionId: publicacionId,
                orden: orden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                required int publicacionId,
                required int orden,
              }) => EjesCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                publicacionId: publicacionId,
                orden: orden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EjesTable, Eje>(table),
                  $$EjesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                publicacionId = false,
                metasGlobalesRefs = false,
                metasNacionalesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (metasGlobalesRefs) db.metasGlobales,
                    if (metasNacionalesRefs) db.metasNacionales,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (publicacionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.publicacionId,
                            referencedTable: $$EjesTableReferences
                                ._publicacionIdTable(db),
                            referencedColumn: $$EjesTableReferences
                                ._publicacionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (metasGlobalesRefs)
                        await $_getPrefetchedData<
                          Eje,
                          $EjesTable,
                          MetasGlobale
                        >(
                          currentTable: table,
                          referencedTable: $$EjesTableReferences
                              ._metasGlobalesRefsTable(db),
                          managerFromTypedResult: (p0) => $$EjesTableReferences(
                            db,
                            table,
                            p0,
                          ).metasGlobalesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.ejeId == item.id),
                          typedResults: items,
                        ),
                      if (metasNacionalesRefs)
                        await $_getPrefetchedData<
                          Eje,
                          $EjesTable,
                          MetasNacionale
                        >(
                          currentTable: table,
                          referencedTable: $$EjesTableReferences
                              ._metasNacionalesRefsTable(db),
                          managerFromTypedResult: (p0) => $$EjesTableReferences(
                            db,
                            table,
                            p0,
                          ).metasNacionalesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.ejeId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EjesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EjesTable,
      Eje,
      $$EjesTableFilterComposer,
      $$EjesTableOrderingComposer,
      $$EjesTableAnnotationComposer,
      $$EjesTableCreateCompanionBuilder,
      $$EjesTableUpdateCompanionBuilder,
      (Eje, $$EjesTableReferences),
      Eje,
      PrefetchHooks Function({
        bool publicacionId,
        bool metasGlobalesRefs,
        bool metasNacionalesRefs,
      })
    >;
typedef $$MetasGlobalesTableCreateCompanionBuilder =
    MetasGlobalesCompanion Function({
      Value<int> id,
      required String codigo,
      required String nombre,
      Value<String?> descripcion,
      required int ejeId,
      required int orden,
    });
typedef $$MetasGlobalesTableUpdateCompanionBuilder =
    MetasGlobalesCompanion Function({
      Value<int> id,
      Value<String> codigo,
      Value<String> nombre,
      Value<String?> descripcion,
      Value<int> ejeId,
      Value<int> orden,
    });

final class $$MetasGlobalesTableReferences
    extends BaseReferences<_$AppDatabase, $MetasGlobalesTable, MetasGlobale> {
  $$MetasGlobalesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EjesTable _ejeIdTable(_$AppDatabase db) =>
      db.ejes.createAlias('metas_globales__eje_id__ejes__id');

  $$EjesTableProcessedTableManager get ejeId {
    final $_column = $_itemColumn<int>('eje_id')!;

    final manager = $$EjesTableTableManager(
      $_db,
      $_db.ejes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ejeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MetasNacionalesTable, List<MetasNacionale>>
  _metasNacionalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.metasNacionales,
    aliasName: 'metas_globales__id__metas_nacionales__meta_global_id',
  );

  $$MetasNacionalesTableProcessedTableManager get metasNacionalesRefs {
    final manager = $$MetasNacionalesTableTableManager(
      $_db,
      $_db.metasNacionales,
    ).filter((f) => f.metaGlobalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metasNacionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MetasGlobalesTableFilterComposer
    extends Composer<_$AppDatabase, $MetasGlobalesTable> {
  $$MetasGlobalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  $$EjesTableFilterComposer get ejeId {
    final $$EjesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableFilterComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> metasNacionalesRefs(
    Expression<bool> Function($$MetasNacionalesTableFilterComposer f) f,
  ) {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.metaGlobalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MetasGlobalesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetasGlobalesTable> {
  $$MetasGlobalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  $$EjesTableOrderingComposer get ejeId {
    final $$EjesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableOrderingComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetasGlobalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetasGlobalesTable> {
  $$MetasGlobalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  $$EjesTableAnnotationComposer get ejeId {
    final $$EjesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableAnnotationComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> metasNacionalesRefs<T extends Object>(
    Expression<T> Function($$MetasNacionalesTableAnnotationComposer a) f,
  ) {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.metaGlobalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MetasGlobalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetasGlobalesTable,
          MetasGlobale,
          $$MetasGlobalesTableFilterComposer,
          $$MetasGlobalesTableOrderingComposer,
          $$MetasGlobalesTableAnnotationComposer,
          $$MetasGlobalesTableCreateCompanionBuilder,
          $$MetasGlobalesTableUpdateCompanionBuilder,
          (MetasGlobale, $$MetasGlobalesTableReferences),
          MetasGlobale,
          PrefetchHooks Function({bool ejeId, bool metasNacionalesRefs})
        > {
  $$MetasGlobalesTableTableManager(_$AppDatabase db, $MetasGlobalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetasGlobalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetasGlobalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetasGlobalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> ejeId = const Value.absent(),
                Value<int> orden = const Value.absent(),
              }) => MetasGlobalesCompanion(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                ejeId: ejeId,
                orden: orden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String codigo,
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                required int ejeId,
                required int orden,
              }) => MetasGlobalesCompanion.insert(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                ejeId: ejeId,
                orden: orden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetasGlobalesTable, MetasGlobale>(table),
                  $$MetasGlobalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ejeId = false, metasNacionalesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (metasNacionalesRefs) db.metasNacionales,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ejeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ejeId,
                            referencedTable: $$MetasGlobalesTableReferences
                                ._ejeIdTable(db),
                            referencedColumn: $$MetasGlobalesTableReferences
                                ._ejeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (metasNacionalesRefs)
                        await $_getPrefetchedData<
                          MetasGlobale,
                          $MetasGlobalesTable,
                          MetasNacionale
                        >(
                          currentTable: table,
                          referencedTable: $$MetasGlobalesTableReferences
                              ._metasNacionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MetasGlobalesTableReferences(
                                db,
                                table,
                                p0,
                              ).metasNacionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.metaGlobalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MetasGlobalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetasGlobalesTable,
      MetasGlobale,
      $$MetasGlobalesTableFilterComposer,
      $$MetasGlobalesTableOrderingComposer,
      $$MetasGlobalesTableAnnotationComposer,
      $$MetasGlobalesTableCreateCompanionBuilder,
      $$MetasGlobalesTableUpdateCompanionBuilder,
      (MetasGlobale, $$MetasGlobalesTableReferences),
      MetasGlobale,
      PrefetchHooks Function({bool ejeId, bool metasNacionalesRefs})
    >;
typedef $$MetasNacionalesTableCreateCompanionBuilder =
    MetasNacionalesCompanion Function({
      Value<int> id,
      required String codigo,
      required String nombre,
      Value<String?> descripcion,
      required int ejeId,
      required int metaGlobalId,
      required int publicacionId,
      Value<int?> referenciaOrigenId,
      required int orden,
    });
typedef $$MetasNacionalesTableUpdateCompanionBuilder =
    MetasNacionalesCompanion Function({
      Value<int> id,
      Value<String> codigo,
      Value<String> nombre,
      Value<String?> descripcion,
      Value<int> ejeId,
      Value<int> metaGlobalId,
      Value<int> publicacionId,
      Value<int?> referenciaOrigenId,
      Value<int> orden,
    });

final class $$MetasNacionalesTableReferences
    extends
        BaseReferences<_$AppDatabase, $MetasNacionalesTable, MetasNacionale> {
  $$MetasNacionalesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EjesTable _ejeIdTable(_$AppDatabase db) =>
      db.ejes.createAlias('metas_nacionales__eje_id__ejes__id');

  $$EjesTableProcessedTableManager get ejeId {
    final $_column = $_itemColumn<int>('eje_id')!;

    final manager = $$EjesTableTableManager(
      $_db,
      $_db.ejes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ejeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MetasGlobalesTable _metaGlobalIdTable(_$AppDatabase db) => db
      .metasGlobales
      .createAlias('metas_nacionales__meta_global_id__metas_globales__id');

  $$MetasGlobalesTableProcessedTableManager get metaGlobalId {
    final $_column = $_itemColumn<int>('meta_global_id')!;

    final manager = $$MetasGlobalesTableTableManager(
      $_db,
      $_db.metasGlobales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metaGlobalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PublicacionesTable _publicacionIdTable(_$AppDatabase db) => db
      .publicaciones
      .createAlias('metas_nacionales__publicacion_id__publicaciones__id');

  $$PublicacionesTableProcessedTableManager get publicacionId {
    final $_column = $_itemColumn<int>('publicacion_id')!;

    final manager = $$PublicacionesTableTableManager(
      $_db,
      $_db.publicaciones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_publicacionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReferenciasOrigenTable _referenciaOrigenIdTable(_$AppDatabase db) =>
      db.referenciasOrigen.createAlias(
        'metas_nacionales__referencia_origen_id__referencias_origen__id',
      );

  $$ReferenciasOrigenTableProcessedTableManager? get referenciaOrigenId {
    final $_column = $_itemColumn<int>('referencia_origen_id');
    if ($_column == null) return null;
    final manager = $$ReferenciasOrigenTableTableManager(
      $_db,
      $_db.referenciasOrigen,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_referenciaOrigenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HitosTable, List<Hito>> _hitosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.hitos,
    aliasName: 'metas_nacionales__id__hitos__meta_nacional_id',
  );

  $$HitosTableProcessedTableManager get hitosRefs {
    final manager = $$HitosTableTableManager(
      $_db,
      $_db.hitos,
    ).filter((f) => f.metaNacionalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_hitosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ParticipacionesInstitucionalesTable,
    List<ParticipacionesInstitucionale>
  >
  _participacionesInstitucionalesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.participacionesInstitucionales,
        aliasName: 'metas_nacionales__id__participaciones_institucionales__meta_nacional_id',
      );

  $$ParticipacionesInstitucionalesTableProcessedTableManager
  get participacionesInstitucionalesRefs {
    final manager = $$ParticipacionesInstitucionalesTableTableManager(
      $_db,
      $_db.participacionesInstitucionales,
    ).filter((f) => f.metaNacionalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _participacionesInstitucionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MetasNacionalesTableFilterComposer
    extends Composer<_$AppDatabase, $MetasNacionalesTable> {
  $$MetasNacionalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  $$EjesTableFilterComposer get ejeId {
    final $$EjesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableFilterComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasGlobalesTableFilterComposer get metaGlobalId {
    final $$MetasGlobalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaGlobalId,
      referencedTable: $db.metasGlobales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasGlobalesTableFilterComposer(
            $db: $db,
            $table: $db.metasGlobales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PublicacionesTableFilterComposer get publicacionId {
    final $$PublicacionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableFilterComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableFilterComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableFilterComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> hitosRefs(
    Expression<bool> Function($$HitosTableFilterComposer f) f,
  ) {
    final $$HitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.metaNacionalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableFilterComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> participacionesInstitucionalesRefs(
    Expression<bool> Function(
      $$ParticipacionesInstitucionalesTableFilterComposer f,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.metaNacionalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableFilterComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MetasNacionalesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetasNacionalesTable> {
  $$MetasNacionalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  $$EjesTableOrderingComposer get ejeId {
    final $$EjesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableOrderingComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasGlobalesTableOrderingComposer get metaGlobalId {
    final $$MetasGlobalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaGlobalId,
      referencedTable: $db.metasGlobales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasGlobalesTableOrderingComposer(
            $db: $db,
            $table: $db.metasGlobales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PublicacionesTableOrderingComposer get publicacionId {
    final $$PublicacionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableOrderingComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableOrderingComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableOrderingComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetasNacionalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetasNacionalesTable> {
  $$MetasNacionalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  $$EjesTableAnnotationComposer get ejeId {
    final $$EjesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ejeId,
      referencedTable: $db.ejes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EjesTableAnnotationComposer(
            $db: $db,
            $table: $db.ejes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasGlobalesTableAnnotationComposer get metaGlobalId {
    final $$MetasGlobalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaGlobalId,
      referencedTable: $db.metasGlobales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasGlobalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasGlobales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PublicacionesTableAnnotationComposer get publicacionId {
    final $$PublicacionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.publicacionId,
      referencedTable: $db.publicaciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PublicacionesTableAnnotationComposer(
            $db: $db,
            $table: $db.publicaciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableAnnotationComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.referenciaOrigenId,
          referencedTable: $db.referenciasOrigen,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReferenciasOrigenTableAnnotationComposer(
                $db: $db,
                $table: $db.referenciasOrigen,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> hitosRefs<T extends Object>(
    Expression<T> Function($$HitosTableAnnotationComposer a) f,
  ) {
    final $$HitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.metaNacionalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableAnnotationComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> participacionesInstitucionalesRefs<T extends Object>(
    Expression<T> Function(
      $$ParticipacionesInstitucionalesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.metaNacionalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableAnnotationComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MetasNacionalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetasNacionalesTable,
          MetasNacionale,
          $$MetasNacionalesTableFilterComposer,
          $$MetasNacionalesTableOrderingComposer,
          $$MetasNacionalesTableAnnotationComposer,
          $$MetasNacionalesTableCreateCompanionBuilder,
          $$MetasNacionalesTableUpdateCompanionBuilder,
          (MetasNacionale, $$MetasNacionalesTableReferences),
          MetasNacionale,
          PrefetchHooks Function({
            bool ejeId,
            bool metaGlobalId,
            bool publicacionId,
            bool referenciaOrigenId,
            bool hitosRefs,
            bool participacionesInstitucionalesRefs,
          })
        > {
  $$MetasNacionalesTableTableManager(
    _$AppDatabase db,
    $MetasNacionalesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetasNacionalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetasNacionalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetasNacionalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> ejeId = const Value.absent(),
                Value<int> metaGlobalId = const Value.absent(),
                Value<int> publicacionId = const Value.absent(),
                Value<int?> referenciaOrigenId = const Value.absent(),
                Value<int> orden = const Value.absent(),
              }) => MetasNacionalesCompanion(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                ejeId: ejeId,
                metaGlobalId: metaGlobalId,
                publicacionId: publicacionId,
                referenciaOrigenId: referenciaOrigenId,
                orden: orden,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String codigo,
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                required int ejeId,
                required int metaGlobalId,
                required int publicacionId,
                Value<int?> referenciaOrigenId = const Value.absent(),
                required int orden,
              }) => MetasNacionalesCompanion.insert(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                ejeId: ejeId,
                metaGlobalId: metaGlobalId,
                publicacionId: publicacionId,
                referenciaOrigenId: referenciaOrigenId,
                orden: orden,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetasNacionalesTable, MetasNacionale>(table),
                  $$MetasNacionalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ejeId = false,
                metaGlobalId = false,
                publicacionId = false,
                referenciaOrigenId = false,
                hitosRefs = false,
                participacionesInstitucionalesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (hitosRefs) db.hitos,
                    if (participacionesInstitucionalesRefs)
                      db.participacionesInstitucionales,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ejeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ejeId,
                            referencedTable: $$MetasNacionalesTableReferences
                                ._ejeIdTable(db),
                            referencedColumn: $$MetasNacionalesTableReferences
                                ._ejeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (metaGlobalId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.metaGlobalId,
                            referencedTable: $$MetasNacionalesTableReferences
                                ._metaGlobalIdTable(db),
                            referencedColumn: $$MetasNacionalesTableReferences
                                ._metaGlobalIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (publicacionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.publicacionId,
                            referencedTable: $$MetasNacionalesTableReferences
                                ._publicacionIdTable(db),
                            referencedColumn: $$MetasNacionalesTableReferences
                                ._publicacionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (referenciaOrigenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.referenciaOrigenId,
                            referencedTable: $$MetasNacionalesTableReferences
                                ._referenciaOrigenIdTable(db),
                            referencedColumn: $$MetasNacionalesTableReferences
                                ._referenciaOrigenIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (hitosRefs)
                        await $_getPrefetchedData<
                          MetasNacionale,
                          $MetasNacionalesTable,
                          Hito
                        >(
                          currentTable: table,
                          referencedTable: $$MetasNacionalesTableReferences
                              ._hitosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MetasNacionalesTableReferences(
                                db,
                                table,
                                p0,
                              ).hitosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.metaNacionalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (participacionesInstitucionalesRefs)
                        await $_getPrefetchedData<
                          MetasNacionale,
                          $MetasNacionalesTable,
                          ParticipacionesInstitucionale
                        >(
                          currentTable: table,
                          referencedTable: $$MetasNacionalesTableReferences
                              ._participacionesInstitucionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MetasNacionalesTableReferences(
                                db,
                                table,
                                p0,
                              ).participacionesInstitucionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.metaNacionalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MetasNacionalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetasNacionalesTable,
      MetasNacionale,
      $$MetasNacionalesTableFilterComposer,
      $$MetasNacionalesTableOrderingComposer,
      $$MetasNacionalesTableAnnotationComposer,
      $$MetasNacionalesTableCreateCompanionBuilder,
      $$MetasNacionalesTableUpdateCompanionBuilder,
      (MetasNacionale, $$MetasNacionalesTableReferences),
      MetasNacionale,
      PrefetchHooks Function({
        bool ejeId,
        bool metaGlobalId,
        bool publicacionId,
        bool referenciaOrigenId,
        bool hitosRefs,
        bool participacionesInstitucionalesRefs,
      })
    >;
typedef $$HitosTableCreateCompanionBuilder = HitosCompanion Function({
  Value<int> id,
  required String codigo,
  Value<String?> nombre,
  Value<String?> descripcion,
  required int metaNacionalId,
  required int orden,
  Value<int?> anio,
  Value<String?> periodo,
  required int referenciaOrigenId,
});
typedef $$HitosTableUpdateCompanionBuilder = HitosCompanion Function({
  Value<int> id,
  Value<String> codigo,
  Value<String?> nombre,
  Value<String?> descripcion,
  Value<int> metaNacionalId,
  Value<int> orden,
  Value<int?> anio,
  Value<String?> periodo,
  Value<int> referenciaOrigenId,
});

final class $$HitosTableReferences
    extends BaseReferences<_$AppDatabase, $HitosTable, Hito> {
  $$HitosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MetasNacionalesTable _metaNacionalIdTable(_$AppDatabase db) => db
      .metasNacionales
      .createAlias('hitos__meta_nacional_id__metas_nacionales__id');

  $$MetasNacionalesTableProcessedTableManager get metaNacionalId {
    final $_column = $_itemColumn<int>('meta_nacional_id')!;

    final manager = $$MetasNacionalesTableTableManager(
      $_db,
      $_db.metasNacionales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metaNacionalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReferenciasOrigenTable _referenciaOrigenIdTable(_$AppDatabase db) =>
      db.referenciasOrigen.createAlias(
        'hitos__referencia_origen_id__referencias_origen__id',
      );

  $$ReferenciasOrigenTableProcessedTableManager get referenciaOrigenId {
    final $_column = $_itemColumn<int>('referencia_origen_id')!;

    final manager = $$ReferenciasOrigenTableTableManager(
      $_db,
      $_db.referenciasOrigen,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_referenciaOrigenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubhitosTable, List<Subhito>> _subhitosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subhitos,
    aliasName: 'hitos__id__subhitos__hito_id',
  );

  $$SubhitosTableProcessedTableManager get subhitosRefs {
    final manager = $$SubhitosTableTableManager(
      $_db,
      $_db.subhitos,
    ).filter((f) => f.hitoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subhitosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ParticipacionesInstitucionalesTable,
    List<ParticipacionesInstitucionale>
  >
  _participacionesInstitucionalesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.participacionesInstitucionales,
        aliasName: 'hitos__id__participaciones_institucionales__hito_id',
      );

  $$ParticipacionesInstitucionalesTableProcessedTableManager
  get participacionesInstitucionalesRefs {
    final manager = $$ParticipacionesInstitucionalesTableTableManager(
      $_db,
      $_db.participacionesInstitucionales,
    ).filter((f) => f.hitoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _participacionesInstitucionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HitosTableFilterComposer extends Composer<_$AppDatabase, $HitosTable> {
  $$HitosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodo => $composableBuilder(
    column: $table.periodo,
    builder: (column) => ColumnFilters(column),
  );

  $$MetasNacionalesTableFilterComposer get metaNacionalId {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableFilterComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableFilterComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subhitosRefs(
    Expression<bool> Function($$SubhitosTableFilterComposer f) f,
  ) {
    final $$SubhitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subhitos,
      getReferencedColumn: (t) => t.hitoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubhitosTableFilterComposer(
            $db: $db,
            $table: $db.subhitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> participacionesInstitucionalesRefs(
    Expression<bool> Function(
      $$ParticipacionesInstitucionalesTableFilterComposer f,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.hitoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableFilterComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HitosTableOrderingComposer
    extends Composer<_$AppDatabase, $HitosTable> {
  $$HitosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodo => $composableBuilder(
    column: $table.periodo,
    builder: (column) => ColumnOrderings(column),
  );

  $$MetasNacionalesTableOrderingComposer get metaNacionalId {
    final $$MetasNacionalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableOrderingComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableOrderingComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableOrderingComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HitosTableAnnotationComposer
    extends Composer<_$AppDatabase, $HitosTable> {
  $$HitosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<String> get periodo =>
      $composableBuilder(column: $table.periodo, builder: (column) => column);

  $$MetasNacionalesTableAnnotationComposer get metaNacionalId {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableAnnotationComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.referenciaOrigenId,
          referencedTable: $db.referenciasOrigen,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReferenciasOrigenTableAnnotationComposer(
                $db: $db,
                $table: $db.referenciasOrigen,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> subhitosRefs<T extends Object>(
    Expression<T> Function($$SubhitosTableAnnotationComposer a) f,
  ) {
    final $$SubhitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subhitos,
      getReferencedColumn: (t) => t.hitoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubhitosTableAnnotationComposer(
            $db: $db,
            $table: $db.subhitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> participacionesInstitucionalesRefs<T extends Object>(
    Expression<T> Function(
      $$ParticipacionesInstitucionalesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.hitoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableAnnotationComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HitosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HitosTable,
          Hito,
          $$HitosTableFilterComposer,
          $$HitosTableOrderingComposer,
          $$HitosTableAnnotationComposer,
          $$HitosTableCreateCompanionBuilder,
          $$HitosTableUpdateCompanionBuilder,
          (Hito, $$HitosTableReferences),
          Hito,
          PrefetchHooks Function({
            bool metaNacionalId,
            bool referenciaOrigenId,
            bool subhitosRefs,
            bool participacionesInstitucionalesRefs,
          })
        > {
  $$HitosTableTableManager(_$AppDatabase db, $HitosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HitosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HitosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HitosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String?> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> metaNacionalId = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<String?> periodo = const Value.absent(),
                Value<int> referenciaOrigenId = const Value.absent(),
              }) => HitosCompanion(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                metaNacionalId: metaNacionalId,
                orden: orden,
                anio: anio,
                periodo: periodo,
                referenciaOrigenId: referenciaOrigenId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String codigo,
                Value<String?> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                required int metaNacionalId,
                required int orden,
                Value<int?> anio = const Value.absent(),
                Value<String?> periodo = const Value.absent(),
                required int referenciaOrigenId,
              }) => HitosCompanion.insert(
                id: id,
                codigo: codigo,
                nombre: nombre,
                descripcion: descripcion,
                metaNacionalId: metaNacionalId,
                orden: orden,
                anio: anio,
                periodo: periodo,
                referenciaOrigenId: referenciaOrigenId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HitosTable, Hito>(table),
                  $$HitosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                metaNacionalId = false,
                referenciaOrigenId = false,
                subhitosRefs = false,
                participacionesInstitucionalesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subhitosRefs) db.subhitos,
                    if (participacionesInstitucionalesRefs)
                      db.participacionesInstitucionales,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (metaNacionalId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.metaNacionalId,
                            referencedTable: $$HitosTableReferences
                                ._metaNacionalIdTable(db),
                            referencedColumn: $$HitosTableReferences
                                ._metaNacionalIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (referenciaOrigenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.referenciaOrigenId,
                            referencedTable: $$HitosTableReferences
                                ._referenciaOrigenIdTable(db),
                            referencedColumn: $$HitosTableReferences
                                ._referenciaOrigenIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subhitosRefs)
                        await $_getPrefetchedData<Hito, $HitosTable, Subhito>(
                          currentTable: table,
                          referencedTable: $$HitosTableReferences
                              ._subhitosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HitosTableReferences(
                                db,
                                table,
                                p0,
                              ).subhitosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.hitoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (participacionesInstitucionalesRefs)
                        await $_getPrefetchedData<
                          Hito,
                          $HitosTable,
                          ParticipacionesInstitucionale
                        >(
                          currentTable: table,
                          referencedTable: $$HitosTableReferences
                              ._participacionesInstitucionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HitosTableReferences(
                                db,
                                table,
                                p0,
                              ).participacionesInstitucionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.hitoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HitosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HitosTable,
      Hito,
      $$HitosTableFilterComposer,
      $$HitosTableOrderingComposer,
      $$HitosTableAnnotationComposer,
      $$HitosTableCreateCompanionBuilder,
      $$HitosTableUpdateCompanionBuilder,
      (Hito, $$HitosTableReferences),
      Hito,
      PrefetchHooks Function({
        bool metaNacionalId,
        bool referenciaOrigenId,
        bool subhitosRefs,
        bool participacionesInstitucionalesRefs,
      })
    >;
typedef $$SubhitosTableCreateCompanionBuilder = SubhitosCompanion Function({
  Value<int> id,
  Value<String?> codigo,
  required String descripcion,
  required int hitoId,
  required int orden,
  Value<int?> referenciaOrigenId,
});
typedef $$SubhitosTableUpdateCompanionBuilder = SubhitosCompanion Function({
  Value<int> id,
  Value<String?> codigo,
  Value<String> descripcion,
  Value<int> hitoId,
  Value<int> orden,
  Value<int?> referenciaOrigenId,
});

final class $$SubhitosTableReferences
    extends BaseReferences<_$AppDatabase, $SubhitosTable, Subhito> {
  $$SubhitosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HitosTable _hitoIdTable(_$AppDatabase db) =>
      db.hitos.createAlias('subhitos__hito_id__hitos__id');

  $$HitosTableProcessedTableManager get hitoId {
    final $_column = $_itemColumn<int>('hito_id')!;

    final manager = $$HitosTableTableManager(
      $_db,
      $_db.hitos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hitoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReferenciasOrigenTable _referenciaOrigenIdTable(_$AppDatabase db) =>
      db.referenciasOrigen.createAlias(
        'subhitos__referencia_origen_id__referencias_origen__id',
      );

  $$ReferenciasOrigenTableProcessedTableManager? get referenciaOrigenId {
    final $_column = $_itemColumn<int>('referencia_origen_id');
    if ($_column == null) return null;
    final manager = $$ReferenciasOrigenTableTableManager(
      $_db,
      $_db.referenciasOrigen,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_referenciaOrigenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubhitosTableFilterComposer
    extends Composer<_$AppDatabase, $SubhitosTable> {
  $$SubhitosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  $$HitosTableFilterComposer get hitoId {
    final $$HitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableFilterComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableFilterComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableFilterComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubhitosTableOrderingComposer
    extends Composer<_$AppDatabase, $SubhitosTable> {
  $$SubhitosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  $$HitosTableOrderingComposer get hitoId {
    final $$HitosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableOrderingComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableOrderingComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableOrderingComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubhitosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubhitosTable> {
  $$SubhitosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  $$HitosTableAnnotationComposer get hitoId {
    final $$HitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableAnnotationComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableAnnotationComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.referenciaOrigenId,
          referencedTable: $db.referenciasOrigen,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReferenciasOrigenTableAnnotationComposer(
                $db: $db,
                $table: $db.referenciasOrigen,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SubhitosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubhitosTable,
          Subhito,
          $$SubhitosTableFilterComposer,
          $$SubhitosTableOrderingComposer,
          $$SubhitosTableAnnotationComposer,
          $$SubhitosTableCreateCompanionBuilder,
          $$SubhitosTableUpdateCompanionBuilder,
          (Subhito, $$SubhitosTableReferences),
          Subhito,
          PrefetchHooks Function({bool hitoId, bool referenciaOrigenId})
        > {
  $$SubhitosTableTableManager(_$AppDatabase db, $SubhitosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubhitosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubhitosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubhitosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> codigo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<int> hitoId = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<int?> referenciaOrigenId = const Value.absent(),
              }) => SubhitosCompanion(
                id: id,
                codigo: codigo,
                descripcion: descripcion,
                hitoId: hitoId,
                orden: orden,
                referenciaOrigenId: referenciaOrigenId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> codigo = const Value.absent(),
                required String descripcion,
                required int hitoId,
                required int orden,
                Value<int?> referenciaOrigenId = const Value.absent(),
              }) => SubhitosCompanion.insert(
                id: id,
                codigo: codigo,
                descripcion: descripcion,
                hitoId: hitoId,
                orden: orden,
                referenciaOrigenId: referenciaOrigenId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubhitosTable, Subhito>(table),
                  $$SubhitosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({hitoId = false, referenciaOrigenId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (hitoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.hitoId,
                            referencedTable: $$SubhitosTableReferences
                                ._hitoIdTable(db),
                            referencedColumn: $$SubhitosTableReferences
                                ._hitoIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (referenciaOrigenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.referenciaOrigenId,
                            referencedTable: $$SubhitosTableReferences
                                ._referenciaOrigenIdTable(db),
                            referencedColumn: $$SubhitosTableReferences
                                ._referenciaOrigenIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SubhitosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubhitosTable,
      Subhito,
      $$SubhitosTableFilterComposer,
      $$SubhitosTableOrderingComposer,
      $$SubhitosTableAnnotationComposer,
      $$SubhitosTableCreateCompanionBuilder,
      $$SubhitosTableUpdateCompanionBuilder,
      (Subhito, $$SubhitosTableReferences),
      Subhito,
      PrefetchHooks Function({bool hitoId, bool referenciaOrigenId})
    >;
typedef $$InstitucionesTableCreateCompanionBuilder =
    InstitucionesCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> nombreCorto,
      Value<String?> tipo,
      Value<String?> descripcion,
    });
typedef $$InstitucionesTableUpdateCompanionBuilder =
    InstitucionesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> nombreCorto,
      Value<String?> tipo,
      Value<String?> descripcion,
    });

final class $$InstitucionesTableReferences
    extends BaseReferences<_$AppDatabase, $InstitucionesTable, Institucione> {
  $$InstitucionesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ParticipacionesInstitucionalesTable,
    List<ParticipacionesInstitucionale>
  >
  _participacionesInstitucionalesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.participacionesInstitucionales,
    aliasName:
        'instituciones__id__participaciones_institucionales__institucion_id',
  );

  $$ParticipacionesInstitucionalesTableProcessedTableManager
  get participacionesInstitucionalesRefs {
    final manager = $$ParticipacionesInstitucionalesTableTableManager(
      $_db,
      $_db.participacionesInstitucionales,
    ).filter((f) => f.institucionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _participacionesInstitucionalesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SiglasAcronimosTable, List<SiglasAcronimo>>
  _siglasAcronimosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.siglasAcronimos,
    aliasName: 'instituciones__id__siglas_acronimos__institucion_id',
  );

  $$SiglasAcronimosTableProcessedTableManager get siglasAcronimosRefs {
    final manager = $$SiglasAcronimosTableTableManager(
      $_db,
      $_db.siglasAcronimos,
    ).filter((f) => f.institucionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _siglasAcronimosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstitucionesTableFilterComposer
    extends Composer<_$AppDatabase, $InstitucionesTable> {
  $$InstitucionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreCorto => $composableBuilder(
    column: $table.nombreCorto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> participacionesInstitucionalesRefs(
    Expression<bool> Function(
      $$ParticipacionesInstitucionalesTableFilterComposer f,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.institucionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableFilterComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> siglasAcronimosRefs(
    Expression<bool> Function($$SiglasAcronimosTableFilterComposer f) f,
  ) {
    final $$SiglasAcronimosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.siglasAcronimos,
      getReferencedColumn: (t) => t.institucionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SiglasAcronimosTableFilterComposer(
            $db: $db,
            $table: $db.siglasAcronimos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstitucionesTableOrderingComposer
    extends Composer<_$AppDatabase, $InstitucionesTable> {
  $$InstitucionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreCorto => $composableBuilder(
    column: $table.nombreCorto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstitucionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstitucionesTable> {
  $$InstitucionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get nombreCorto => $composableBuilder(
    column: $table.nombreCorto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  Expression<T> participacionesInstitucionalesRefs<T extends Object>(
    Expression<T> Function(
      $$ParticipacionesInstitucionalesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ParticipacionesInstitucionalesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.participacionesInstitucionales,
          getReferencedColumn: (t) => t.institucionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ParticipacionesInstitucionalesTableAnnotationComposer(
                $db: $db,
                $table: $db.participacionesInstitucionales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> siglasAcronimosRefs<T extends Object>(
    Expression<T> Function($$SiglasAcronimosTableAnnotationComposer a) f,
  ) {
    final $$SiglasAcronimosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.siglasAcronimos,
      getReferencedColumn: (t) => t.institucionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SiglasAcronimosTableAnnotationComposer(
            $db: $db,
            $table: $db.siglasAcronimos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstitucionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstitucionesTable,
          Institucione,
          $$InstitucionesTableFilterComposer,
          $$InstitucionesTableOrderingComposer,
          $$InstitucionesTableAnnotationComposer,
          $$InstitucionesTableCreateCompanionBuilder,
          $$InstitucionesTableUpdateCompanionBuilder,
          (Institucione, $$InstitucionesTableReferences),
          Institucione,
          PrefetchHooks Function({
            bool participacionesInstitucionalesRefs,
            bool siglasAcronimosRefs,
          })
        > {
  $$InstitucionesTableTableManager(_$AppDatabase db, $InstitucionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstitucionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstitucionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstitucionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> nombreCorto = const Value.absent(),
                Value<String?> tipo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => InstitucionesCompanion(
                id: id,
                nombre: nombre,
                nombreCorto: nombreCorto,
                tipo: tipo,
                descripcion: descripcion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> nombreCorto = const Value.absent(),
                Value<String?> tipo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => InstitucionesCompanion.insert(
                id: id,
                nombre: nombre,
                nombreCorto: nombreCorto,
                tipo: tipo,
                descripcion: descripcion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InstitucionesTable, Institucione>(table),
                  $$InstitucionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                participacionesInstitucionalesRefs = false,
                siglasAcronimosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (participacionesInstitucionalesRefs)
                      db.participacionesInstitucionales,
                    if (siglasAcronimosRefs) db.siglasAcronimos,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (participacionesInstitucionalesRefs)
                        await $_getPrefetchedData<
                          Institucione,
                          $InstitucionesTable,
                          ParticipacionesInstitucionale
                        >(
                          currentTable: table,
                          referencedTable: $$InstitucionesTableReferences
                              ._participacionesInstitucionalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstitucionesTableReferences(
                                db,
                                table,
                                p0,
                              ).participacionesInstitucionalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.institucionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (siglasAcronimosRefs)
                        await $_getPrefetchedData<
                          Institucione,
                          $InstitucionesTable,
                          SiglasAcronimo
                        >(
                          currentTable: table,
                          referencedTable: $$InstitucionesTableReferences
                              ._siglasAcronimosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstitucionesTableReferences(
                                db,
                                table,
                                p0,
                              ).siglasAcronimosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.institucionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InstitucionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstitucionesTable,
      Institucione,
      $$InstitucionesTableFilterComposer,
      $$InstitucionesTableOrderingComposer,
      $$InstitucionesTableAnnotationComposer,
      $$InstitucionesTableCreateCompanionBuilder,
      $$InstitucionesTableUpdateCompanionBuilder,
      (Institucione, $$InstitucionesTableReferences),
      Institucione,
      PrefetchHooks Function({
        bool participacionesInstitucionalesRefs,
        bool siglasAcronimosRefs,
      })
    >;
typedef $$ParticipacionesInstitucionalesTableCreateCompanionBuilder =
    ParticipacionesInstitucionalesCompanion Function({
      Value<int> id,
      required int institucionId,
      Value<int?> metaNacionalId,
      Value<int?> hitoId,
      required String tipoParticipacion,
      Value<String?> descripcion,
      Value<int?> referenciaOrigenId,
    });
typedef $$ParticipacionesInstitucionalesTableUpdateCompanionBuilder =
    ParticipacionesInstitucionalesCompanion Function({
      Value<int> id,
      Value<int> institucionId,
      Value<int?> metaNacionalId,
      Value<int?> hitoId,
      Value<String> tipoParticipacion,
      Value<String?> descripcion,
      Value<int?> referenciaOrigenId,
    });

final class $$ParticipacionesInstitucionalesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ParticipacionesInstitucionalesTable,
          ParticipacionesInstitucionale
        > {
  $$ParticipacionesInstitucionalesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstitucionesTable _institucionIdTable(_$AppDatabase db) =>
      db.instituciones.createAlias(
        'participaciones_institucionales__institucion_id__instituciones__id',
      );

  $$InstitucionesTableProcessedTableManager get institucionId {
    final $_column = $_itemColumn<int>('institucion_id')!;

    final manager = $$InstitucionesTableTableManager(
      $_db,
      $_db.instituciones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_institucionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MetasNacionalesTable _metaNacionalIdTable(
    _$AppDatabase db,
  ) => db.metasNacionales.createAlias(
    'participaciones_institucionales__meta_nacional_id__metas_nacionales__id',
  );

  $$MetasNacionalesTableProcessedTableManager? get metaNacionalId {
    final $_column = $_itemColumn<int>('meta_nacional_id');
    if ($_column == null) return null;
    final manager = $$MetasNacionalesTableTableManager(
      $_db,
      $_db.metasNacionales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metaNacionalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HitosTable _hitoIdTable(_$AppDatabase db) => db.hitos.createAlias(
    'participaciones_institucionales__hito_id__hitos__id',
  );

  $$HitosTableProcessedTableManager? get hitoId {
    final $_column = $_itemColumn<int>('hito_id');
    if ($_column == null) return null;
    final manager = $$HitosTableTableManager(
      $_db,
      $_db.hitos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hitoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReferenciasOrigenTable _referenciaOrigenIdTable(_$AppDatabase db) =>
      db.referenciasOrigen.createAlias(
        'participaciones_institucionales__referencia_origen_id__referencias_origen__id',
      );

  $$ReferenciasOrigenTableProcessedTableManager? get referenciaOrigenId {
    final $_column = $_itemColumn<int>('referencia_origen_id');
    if ($_column == null) return null;
    final manager = $$ReferenciasOrigenTableTableManager(
      $_db,
      $_db.referenciasOrigen,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_referenciaOrigenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParticipacionesInstitucionalesTableFilterComposer
    extends Composer<_$AppDatabase, $ParticipacionesInstitucionalesTable> {
  $$ParticipacionesInstitucionalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoParticipacion => $composableBuilder(
    column: $table.tipoParticipacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  $$InstitucionesTableFilterComposer get institucionId {
    final $$InstitucionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableFilterComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasNacionalesTableFilterComposer get metaNacionalId {
    final $$MetasNacionalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableFilterComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HitosTableFilterComposer get hitoId {
    final $$HitosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableFilterComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableFilterComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableFilterComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParticipacionesInstitucionalesTableOrderingComposer
    extends Composer<_$AppDatabase, $ParticipacionesInstitucionalesTable> {
  $$ParticipacionesInstitucionalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoParticipacion => $composableBuilder(
    column: $table.tipoParticipacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstitucionesTableOrderingComposer get institucionId {
    final $$InstitucionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableOrderingComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasNacionalesTableOrderingComposer get metaNacionalId {
    final $$MetasNacionalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableOrderingComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HitosTableOrderingComposer get hitoId {
    final $$HitosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableOrderingComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableOrderingComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.referenciaOrigenId,
      referencedTable: $db.referenciasOrigen,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReferenciasOrigenTableOrderingComposer(
            $db: $db,
            $table: $db.referenciasOrigen,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParticipacionesInstitucionalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParticipacionesInstitucionalesTable> {
  $$ParticipacionesInstitucionalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipoParticipacion => $composableBuilder(
    column: $table.tipoParticipacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  $$InstitucionesTableAnnotationComposer get institucionId {
    final $$InstitucionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableAnnotationComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetasNacionalesTableAnnotationComposer get metaNacionalId {
    final $$MetasNacionalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metaNacionalId,
      referencedTable: $db.metasNacionales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetasNacionalesTableAnnotationComposer(
            $db: $db,
            $table: $db.metasNacionales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HitosTableAnnotationComposer get hitoId {
    final $$HitosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hitoId,
      referencedTable: $db.hitos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HitosTableAnnotationComposer(
            $db: $db,
            $table: $db.hitos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReferenciasOrigenTableAnnotationComposer get referenciaOrigenId {
    final $$ReferenciasOrigenTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.referenciaOrigenId,
          referencedTable: $db.referenciasOrigen,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReferenciasOrigenTableAnnotationComposer(
                $db: $db,
                $table: $db.referenciasOrigen,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ParticipacionesInstitucionalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParticipacionesInstitucionalesTable,
          ParticipacionesInstitucionale,
          $$ParticipacionesInstitucionalesTableFilterComposer,
          $$ParticipacionesInstitucionalesTableOrderingComposer,
          $$ParticipacionesInstitucionalesTableAnnotationComposer,
          $$ParticipacionesInstitucionalesTableCreateCompanionBuilder,
          $$ParticipacionesInstitucionalesTableUpdateCompanionBuilder,
          (
            ParticipacionesInstitucionale,
            $$ParticipacionesInstitucionalesTableReferences,
          ),
          ParticipacionesInstitucionale,
          PrefetchHooks Function({
            bool institucionId,
            bool metaNacionalId,
            bool hitoId,
            bool referenciaOrigenId,
          })
        > {
  $$ParticipacionesInstitucionalesTableTableManager(
    _$AppDatabase db,
    $ParticipacionesInstitucionalesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParticipacionesInstitucionalesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ParticipacionesInstitucionalesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ParticipacionesInstitucionalesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> institucionId = const Value.absent(),
                Value<int?> metaNacionalId = const Value.absent(),
                Value<int?> hitoId = const Value.absent(),
                Value<String> tipoParticipacion = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int?> referenciaOrigenId = const Value.absent(),
              }) => ParticipacionesInstitucionalesCompanion(
                id: id,
                institucionId: institucionId,
                metaNacionalId: metaNacionalId,
                hitoId: hitoId,
                tipoParticipacion: tipoParticipacion,
                descripcion: descripcion,
                referenciaOrigenId: referenciaOrigenId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int institucionId,
                Value<int?> metaNacionalId = const Value.absent(),
                Value<int?> hitoId = const Value.absent(),
                required String tipoParticipacion,
                Value<String?> descripcion = const Value.absent(),
                Value<int?> referenciaOrigenId = const Value.absent(),
              }) => ParticipacionesInstitucionalesCompanion.insert(
                id: id,
                institucionId: institucionId,
                metaNacionalId: metaNacionalId,
                hitoId: hitoId,
                tipoParticipacion: tipoParticipacion,
                descripcion: descripcion,
                referenciaOrigenId: referenciaOrigenId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ParticipacionesInstitucionalesTable,
                    ParticipacionesInstitucionale
                  >(table),
                  $$ParticipacionesInstitucionalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                institucionId = false,
                metaNacionalId = false,
                hitoId = false,
                referenciaOrigenId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (institucionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.institucionId,
                            referencedTable:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._institucionIdTable(db),
                            referencedColumn:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._institucionIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (metaNacionalId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.metaNacionalId,
                            referencedTable:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._metaNacionalIdTable(db),
                            referencedColumn:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._metaNacionalIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (hitoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.hitoId,
                            referencedTable:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._hitoIdTable(db),
                            referencedColumn:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._hitoIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (referenciaOrigenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.referenciaOrigenId,
                            referencedTable:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._referenciaOrigenIdTable(db),
                            referencedColumn:
                                $$ParticipacionesInstitucionalesTableReferences
                                    ._referenciaOrigenIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ParticipacionesInstitucionalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParticipacionesInstitucionalesTable,
      ParticipacionesInstitucionale,
      $$ParticipacionesInstitucionalesTableFilterComposer,
      $$ParticipacionesInstitucionalesTableOrderingComposer,
      $$ParticipacionesInstitucionalesTableAnnotationComposer,
      $$ParticipacionesInstitucionalesTableCreateCompanionBuilder,
      $$ParticipacionesInstitucionalesTableUpdateCompanionBuilder,
      (
        ParticipacionesInstitucionale,
        $$ParticipacionesInstitucionalesTableReferences,
      ),
      ParticipacionesInstitucionale,
      PrefetchHooks Function({
        bool institucionId,
        bool metaNacionalId,
        bool hitoId,
        bool referenciaOrigenId,
      })
    >;
typedef $$SiglasAcronimosTableCreateCompanionBuilder =
    SiglasAcronimosCompanion Function({
      Value<int> id,
      required int institucionId,
      required String sigla,
      Value<String?> descripcion,
    });
typedef $$SiglasAcronimosTableUpdateCompanionBuilder =
    SiglasAcronimosCompanion Function({
      Value<int> id,
      Value<int> institucionId,
      Value<String> sigla,
      Value<String?> descripcion,
    });

final class $$SiglasAcronimosTableReferences
    extends
        BaseReferences<_$AppDatabase, $SiglasAcronimosTable, SiglasAcronimo> {
  $$SiglasAcronimosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstitucionesTable _institucionIdTable(_$AppDatabase db) => db
      .instituciones
      .createAlias('siglas_acronimos__institucion_id__instituciones__id');

  $$InstitucionesTableProcessedTableManager get institucionId {
    final $_column = $_itemColumn<int>('institucion_id')!;

    final manager = $$InstitucionesTableTableManager(
      $_db,
      $_db.instituciones,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_institucionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SiglasAcronimosTableFilterComposer
    extends Composer<_$AppDatabase, $SiglasAcronimosTable> {
  $$SiglasAcronimosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sigla => $composableBuilder(
    column: $table.sigla,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  $$InstitucionesTableFilterComposer get institucionId {
    final $$InstitucionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableFilterComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SiglasAcronimosTableOrderingComposer
    extends Composer<_$AppDatabase, $SiglasAcronimosTable> {
  $$SiglasAcronimosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sigla => $composableBuilder(
    column: $table.sigla,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstitucionesTableOrderingComposer get institucionId {
    final $$InstitucionesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableOrderingComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SiglasAcronimosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SiglasAcronimosTable> {
  $$SiglasAcronimosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sigla =>
      $composableBuilder(column: $table.sigla, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  $$InstitucionesTableAnnotationComposer get institucionId {
    final $$InstitucionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.institucionId,
      referencedTable: $db.instituciones,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstitucionesTableAnnotationComposer(
            $db: $db,
            $table: $db.instituciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SiglasAcronimosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SiglasAcronimosTable,
          SiglasAcronimo,
          $$SiglasAcronimosTableFilterComposer,
          $$SiglasAcronimosTableOrderingComposer,
          $$SiglasAcronimosTableAnnotationComposer,
          $$SiglasAcronimosTableCreateCompanionBuilder,
          $$SiglasAcronimosTableUpdateCompanionBuilder,
          (SiglasAcronimo, $$SiglasAcronimosTableReferences),
          SiglasAcronimo,
          PrefetchHooks Function({bool institucionId})
        > {
  $$SiglasAcronimosTableTableManager(
    _$AppDatabase db,
    $SiglasAcronimosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SiglasAcronimosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SiglasAcronimosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SiglasAcronimosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> institucionId = const Value.absent(),
                Value<String> sigla = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
              }) => SiglasAcronimosCompanion(
                id: id,
                institucionId: institucionId,
                sigla: sigla,
                descripcion: descripcion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int institucionId,
                required String sigla,
                Value<String?> descripcion = const Value.absent(),
              }) => SiglasAcronimosCompanion.insert(
                id: id,
                institucionId: institucionId,
                sigla: sigla,
                descripcion: descripcion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SiglasAcronimosTable, SiglasAcronimo>(table),
                  $$SiglasAcronimosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({institucionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (institucionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.institucionId,
                        referencedTable: $$SiglasAcronimosTableReferences
                            ._institucionIdTable(db),
                        referencedColumn: $$SiglasAcronimosTableReferences
                            ._institucionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SiglasAcronimosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SiglasAcronimosTable,
      SiglasAcronimo,
      $$SiglasAcronimosTableFilterComposer,
      $$SiglasAcronimosTableOrderingComposer,
      $$SiglasAcronimosTableAnnotationComposer,
      $$SiglasAcronimosTableCreateCompanionBuilder,
      $$SiglasAcronimosTableUpdateCompanionBuilder,
      (SiglasAcronimo, $$SiglasAcronimosTableReferences),
      SiglasAcronimo,
      PrefetchHooks Function({bool institucionId})
    >;
typedef $$ConfiguracionContenidoTableCreateCompanionBuilder =
    ConfiguracionContenidoCompanion Function({
      required String clave,
      required String valor,
      Value<int> rowid,
    });
typedef $$ConfiguracionContenidoTableUpdateCompanionBuilder =
    ConfiguracionContenidoCompanion Function({
      Value<String> clave,
      Value<String> valor,
      Value<int> rowid,
    });

class $$ConfiguracionContenidoTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionContenidoTable> {
  $$ConfiguracionContenidoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConfiguracionContenidoTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionContenidoTable> {
  $$ConfiguracionContenidoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfiguracionContenidoTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionContenidoTable> {
  $$ConfiguracionContenidoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$ConfiguracionContenidoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfiguracionContenidoTable,
          ConfiguracionContenidoData,
          $$ConfiguracionContenidoTableFilterComposer,
          $$ConfiguracionContenidoTableOrderingComposer,
          $$ConfiguracionContenidoTableAnnotationComposer,
          $$ConfiguracionContenidoTableCreateCompanionBuilder,
          $$ConfiguracionContenidoTableUpdateCompanionBuilder,
          (
            ConfiguracionContenidoData,
            BaseReferences<
              _$AppDatabase,
              $ConfiguracionContenidoTable,
              ConfiguracionContenidoData
            >,
          ),
          ConfiguracionContenidoData,
          PrefetchHooks Function()
        > {
  $$ConfiguracionContenidoTableTableManager(
    _$AppDatabase db,
    $ConfiguracionContenidoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionContenidoTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ConfiguracionContenidoTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ConfiguracionContenidoTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String> valor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionContenidoCompanion(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clave,
                required String valor,
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionContenidoCompanion.insert(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ConfiguracionContenidoTable,
                    ConfiguracionContenidoData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ConfiguracionContenidoTable,
                    ConfiguracionContenidoData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConfiguracionContenidoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfiguracionContenidoTable,
      ConfiguracionContenidoData,
      $$ConfiguracionContenidoTableFilterComposer,
      $$ConfiguracionContenidoTableOrderingComposer,
      $$ConfiguracionContenidoTableAnnotationComposer,
      $$ConfiguracionContenidoTableCreateCompanionBuilder,
      $$ConfiguracionContenidoTableUpdateCompanionBuilder,
      (
        ConfiguracionContenidoData,
        BaseReferences<
          _$AppDatabase,
          $ConfiguracionContenidoTable,
          ConfiguracionContenidoData
        >,
      ),
      ConfiguracionContenidoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PublicacionesTableTableManager get publicaciones =>
      $$PublicacionesTableTableManager(_db, _db.publicaciones);
  $$ReferenciasOrigenTableTableManager get referenciasOrigen =>
      $$ReferenciasOrigenTableTableManager(_db, _db.referenciasOrigen);
  $$EjesTableTableManager get ejes => $$EjesTableTableManager(_db, _db.ejes);
  $$MetasGlobalesTableTableManager get metasGlobales =>
      $$MetasGlobalesTableTableManager(_db, _db.metasGlobales);
  $$MetasNacionalesTableTableManager get metasNacionales =>
      $$MetasNacionalesTableTableManager(_db, _db.metasNacionales);
  $$HitosTableTableManager get hitos =>
      $$HitosTableTableManager(_db, _db.hitos);
  $$SubhitosTableTableManager get subhitos =>
      $$SubhitosTableTableManager(_db, _db.subhitos);
  $$InstitucionesTableTableManager get instituciones =>
      $$InstitucionesTableTableManager(_db, _db.instituciones);
  $$ParticipacionesInstitucionalesTableTableManager
  get participacionesInstitucionales =>
      $$ParticipacionesInstitucionalesTableTableManager(
        _db,
        _db.participacionesInstitucionales,
      );
  $$SiglasAcronimosTableTableManager get siglasAcronimos =>
      $$SiglasAcronimosTableTableManager(_db, _db.siglasAcronimos);
  $$ConfiguracionContenidoTableTableManager get configuracionContenido =>
      $$ConfiguracionContenidoTableTableManager(
        _db,
        _db.configuracionContenido,
      );
}
