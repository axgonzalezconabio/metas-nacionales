import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

class MetaDetailPage extends ConsumerWidget {
  const MetaDetailPage({
    super.key,
    required this.codigo,
  });

  final String codigo;

  static const Color _wine = Color(0xFF641C34);
  static const Color _background = Color(0xFFF6F5F1);
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryAsync =
        ref.watch(metasNacionalesRepositoryProvider);

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _wine,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Meta Nacional',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: repositoryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => const _MessageState(
          message: 'No fue posible cargar la información de la meta.',
        ),
        data: (repository) {
          return FutureBuilder<MetaNacionalDetalle?>(
            future: repository.obtenerDetalleMetaNacional(codigo),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const _MessageState(
                  message: 'No fue posible cargar la meta.',
                );
              }

              final detalle = snapshot.data;

              if (detalle == null) {
                return const _MessageState(
                  message: 'No se encontró la meta nacional.',
                );
              }

              return _MetaContent(detalle: detalle);
            },
          );
        },
      ),
    );
  }
}

class _MetaContent extends ConsumerWidget {
  const _MetaContent({
    required this.detalle,
  });

  final MetaNacionalDetalle detalle;

  static const Color _text = Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meta = detalle.meta;

    final hitosAsync = ref.watch(
      hitosPorMetaProvider(meta.id),
    );

    final institucionesAsync = ref.watch(
      institucionesPorMetaProvider(meta.id),
    );

    final ejeColor = _colorEje(detalle.eje.nombre);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MetaHeader(
                codigo: meta.codigo,
                nombre: meta.nombre,
                ejeNombre: detalle.eje.nombre,
                ejeColor: ejeColor,
              ),

              const SizedBox(height: 18),

              _SectionCard(
                title: 'Descripción',
                icon: Icons.description_outlined,
                child: Text(
                  meta.descripcion?.trim().isNotEmpty == true
                      ? meta.descripcion!.trim()
                      : 'Sin descripción disponible.',
                  style: const TextStyle(
                    color: _text,
                    fontSize: 15.5,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              _ContextSection(
                ejeNombre: detalle.eje.nombre,
                metaGlobalCodigo: detalle.metaGlobal.codigo,
                metaGlobalNombre: detalle.metaGlobal.nombre,
                ejeColor: ejeColor,
              ),

              const SizedBox(height: 16),

              _SectionCard(
                title: 'Hitos',
                icon: Icons.flag_outlined,
                child: hitosAsync.when(
                  loading: () => const _InlineLoading(),
                  error: (error, stack) => const _InlineMessage(
                    message: 'No fue posible cargar los hitos.',
                  ),
                  data: (hitos) {
                    if (hitos.isEmpty) {
                      return const _InlineMessage(
                        message: 'Esta meta no tiene hitos registrados.',
                      );
                    }

                    return Column(
                      children: [
                        for (var i = 0; i < hitos.length; i++) ...[
                          _HitoItem(
                            hito: hitos[i],
                          ),
                          if (i < hitos.length - 1)
                            const SizedBox(height: 10),
                        ],
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              _SectionCard(
                title: 'Instituciones',
                icon: Icons.account_balance_outlined,
                child: institucionesAsync.when(
                  loading: () => const _InlineLoading(),
                  error: (error, stack) => const _InlineMessage(
                    message:
                        'No fue posible cargar las instituciones.',
                  ),
                  data: (instituciones) {
                    if (instituciones.isEmpty) {
                      return const _InlineMessage(
                        message:
                            'Esta meta no tiene instituciones registradas.',
                      );
                    }

                    return _InstitutionsContent(
                      instituciones: instituciones,
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              _SectionCard(
                title: 'Fuente',
                icon: Icons.menu_book_outlined,
                child: _FuenteSection(
                  referencia: detalle.referenciaOrigen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _colorEje(String eje) {
    switch (eje.trim().toUpperCase()) {
      case 'CONSERVAR':
        return const Color(0xFF94A65B);
      case 'EVITAR':
        return const Color(0xFF7C1716);
      case 'SALVAGUARDAR':
        return const Color(0xFF4A6E7D);
      case 'ACTUAR':
        return const Color(0xFFEA5E25);
      default:
        return const Color(0xFF641C34);
    }
  }
}

class _MetaHeader extends StatelessWidget {
  const _MetaHeader({
    required this.codigo,
    required this.nombre,
    required this.ejeNombre,
    required this.ejeColor,
  });

  final String codigo;
  final String nombre;
  final String ejeNombre;
  final Color ejeColor;

  static const Color _wine = Color(0xFF641C34);
  static const Color _text = Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ejeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Text(
                  codigo,
                  style: TextStyle(
                    color: ejeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  nombre,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: ejeColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.eco_outlined,
                  size: 17,
                  color: ejeColor,
                ),
                const SizedBox(width: 7),
                Text(
                  ejeNombre,
                  style: TextStyle(
                    color: ejeColor,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: _wine,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Meta Nacional',
                style: TextStyle(
                  color: _wine,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContextSection extends StatelessWidget {
  const _ContextSection({
    required this.ejeNombre,
    required this.metaGlobalCodigo,
    required this.metaGlobalNombre,
    required this.ejeColor,
  });

  final String ejeNombre;
  final String metaGlobalCodigo;
  final String metaGlobalNombre;
  final Color ejeColor;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Contexto',
      icon: Icons.account_tree_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ContextItem(
            icon: Icons.layers_outlined,
            label: 'Eje de acción',
            value: ejeNombre,
            color: ejeColor,
          ),
          const SizedBox(height: 12),
          _ContextItem(
            icon: Icons.public_outlined,
            label: 'Meta global relacionada',
            value: '$metaGlobalCodigo · $metaGlobalNombre',
            color: const Color(0xFF641C34),
          ),
        ],
      ),
    );
  }
}

class _ContextItem extends StatelessWidget {
  const _ContextItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HitoItem extends ConsumerWidget {
  const _HitoItem({
    required this.hito,
  });

  final Hito hito;

  static const Color _wine = Color(0xFF641C34);
  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subhitosAsync = ref.watch(
      subhitosPorHitoProvider(hito.id),
    );

    final descripcion = hito.descripcion?.trim().isNotEmpty == true
        ? hito.descripcion!.trim()
        : hito.nombre?.trim().isNotEmpty == true
            ? hito.nombre!.trim()
            : 'Sin descripción disponible.';

    final tieneAnio = hito.anio != null;
    final tienePeriodo = hito.periodo?.trim().isNotEmpty == true;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _wine.withValues(alpha: 0.10),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        iconColor: _wine,
        collapsedIconColor:
            Colors.black.withValues(alpha: 0.35),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: _wine.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                hito.codigo,
                style: const TextStyle(
                  color: _wine,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                descripcion,
                style: const TextStyle(
                  color: _text,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: tieneAnio || tienePeriodo
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 54,
                  top: 6,
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (tieneAnio)
                      _HitoTag(
                        icon: Icons.calendar_today_outlined,
                        label: '${hito.anio}',
                      ),
                    if (tienePeriodo)
                      _HitoTag(
                        icon: Icons.schedule_outlined,
                        label: hito.periodo!.trim(),
                      ),
                  ],
                ),
              )
            : null,
        children: [
          subhitosAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
            error: (error, stack) => const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No fue posible cargar los subhitos.',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            data: (subhitos) {
              if (subhitos.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Este hito no tiene subhitos registrados.',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Subhitos',
                      style: TextStyle(
                        color: _wine,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  for (var i = 0; i < subhitos.length; i++) ...[
                    _SubhitoItem(
                      codigo: subhitos[i].codigo,
                      descripcion: subhitos[i].descripcion,
                    ),
                    if (i < subhitos.length - 1)
                      const SizedBox(height: 8),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HitoTag extends StatelessWidget {
  const _HitoTag({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: _muted,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: _muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubhitoItem extends StatelessWidget {
  const _SubhitoItem({
    required this.codigo,
    required this.descripcion,
  });

  final String? codigo;
  final String descripcion;

  static const Color _wine = Color(0xFF641C34);
  static const Color _text = Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context) {
    final codigoLimpio = codigo?.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _wine.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.only(
              top: 7,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: _wine,
              shape: BoxShape.circle,
            ),
          ),
          if (codigoLimpio?.isNotEmpty == true) ...[
            Text(
              codigoLimpio!,
              style: const TextStyle(
                color: _wine,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              descripcion,
              style: const TextStyle(
                color: _text,
                fontSize: 14.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InstitutionsContent extends StatelessWidget {
  const _InstitutionsContent({
    required this.instituciones,
  });

  final List<InstitucionParticipante> instituciones;

  @override
  Widget build(BuildContext context) {
    final coordinadoras = instituciones
        .where(
          (item) =>
              item.participacion.tipoParticipacion
                  .trim()
                  .toUpperCase() ==
              'COORDINADORA',
        )
        .toList();

    final coadyuvantes = instituciones
        .where(
          (item) =>
              item.participacion.tipoParticipacion
                  .trim()
                  .toUpperCase() ==
              'COADYUVANTE',
        )
        .toList();

    final otras = instituciones
        .where(
          (item) =>
              item.participacion.tipoParticipacion
                  .trim()
                  .toUpperCase() !=
                  'COORDINADORA' &&
              item.participacion.tipoParticipacion
                  .trim()
                  .toUpperCase() !=
                  'COADYUVANTE',
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (coordinadoras.isNotEmpty) ...[
          const _InstitutionGroupTitle(
            title: 'Coordinadoras',
            icon: Icons.flag_outlined,
            color: Color(0xFF4A6E7D),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < coordinadoras.length; i++) ...[
            _InstitutionItem(
              item: coordinadoras[i],
              color: const Color(0xFF4A6E7D),
            ),
            if (i < coordinadoras.length - 1)
              const SizedBox(height: 9),
          ],
        ],
        if (coordinadoras.isNotEmpty &&
            coadyuvantes.isNotEmpty)
          const SizedBox(height: 20),
        if (coadyuvantes.isNotEmpty) ...[
          const _InstitutionGroupTitle(
            title: 'Coadyuvantes',
            icon: Icons.handshake_outlined,
            color: Color(0xFF94A65B),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < coadyuvantes.length; i++) ...[
            _InstitutionItem(
              item: coadyuvantes[i],
              color: const Color(0xFF94A65B),
            ),
            if (i < coadyuvantes.length - 1)
              const SizedBox(height: 9),
          ],
        ],
        if ((coordinadoras.isNotEmpty ||
                coadyuvantes.isNotEmpty) &&
            otras.isNotEmpty)
          const SizedBox(height: 20),
        if (otras.isNotEmpty) ...[
          const _InstitutionGroupTitle(
            title: 'Otras participaciones',
            icon: Icons.account_balance_outlined,
            color: Color(0xFF641C34),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < otras.length; i++) ...[
            _InstitutionItem(
              item: otras[i],
              color: const Color(0xFF641C34),
            ),
            if (i < otras.length - 1)
              const SizedBox(height: 9),
          ],
        ],
      ],
    );
  }
}

class _InstitutionGroupTitle extends StatelessWidget {
  const _InstitutionGroupTitle({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _InstitutionItem extends StatelessWidget {
  const _InstitutionItem({
    required this.item,
    required this.color,
  });

  final InstitucionParticipante item;
  final Color color;

  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final institucion = item.institucion;
    final participacion = item.participacion;

    final nombreCorto = institucion.nombreCorto?.trim();
    final descripcion = participacion.descripcion?.trim();

    return Material(
      color: const Color(0xFFF8F7F4),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          context.push(
            '/instituciones/${institucion.id}',
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_outlined,
                  color: color,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      institucion.nombre,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    if (nombreCorto?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        nombreCorto!,
                        style: TextStyle(
                          color: color,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                    if (descripcion?.isNotEmpty == true) ...[
                      const SizedBox(height: 7),
                      Text(
                        descripcion!,
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 13.5,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.black.withValues(alpha: 0.35),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  static const Color _wine = Color(0xFF641C34);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _wine,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2E2E2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _FuenteSection extends StatelessWidget {
  const _FuenteSection({
    required this.referencia,
  });

  final ReferenciasOrigenData? referencia;

  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final fuente = referencia;

    if (fuente == null) {
      return const Text(
        'No hay referencia de origen registrada.',
        style: TextStyle(
          color: _muted,
          fontSize: 15,
          height: 1.5,
        ),
      );
    }

    final campos = <Widget>[];

    if (fuente.documento.trim().isNotEmpty) {
      campos.add(
        _FuenteRow(
          label: 'Documento',
          value: fuente.documento,
        ),
      );
    }

    final edicion = fuente.edicion?.trim();
    if (edicion?.isNotEmpty == true) {
      campos.add(
        _FuenteRow(
          label: 'Edición',
          value: edicion!,
        ),
      );
    }

    if (fuente.anio != null) {
      campos.add(
        _FuenteRow(
          label: 'Año',
          value: fuente.anio.toString(),
        ),
      );
    }

    if (fuente.pagina != null) {
      campos.add(
        _FuenteRow(
          label: 'Página',
          value: fuente.pagina.toString(),
        ),
      );
    }

    final seccion = fuente.seccion?.trim();
    if (seccion?.isNotEmpty == true) {
      campos.add(
        _FuenteRow(
          label: 'Sección',
          value: seccion!,
        ),
      );
    }

    final observacion = fuente.observacion?.trim();
    if (observacion?.isNotEmpty == true) {
      campos.add(
        _FuenteRow(
          label: 'Observación',
          value: observacion!,
        ),
      );
    }

    if (campos.isEmpty) {
      return const Text(
        'No hay información de referencia registrada.',
        style: TextStyle(
          color: _muted,
          fontSize: 15,
          height: 1.5,
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < campos.length; i++) ...[
          campos[i],
          if (i < campos.length - 1)
            const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _FuenteRow extends StatelessWidget {
  const _FuenteRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              color: _muted,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _text,
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _InlineLoading extends StatelessWidget {
  const _InlineLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _InlineMessage extends StatelessWidget {
  const _InlineMessage({
    required this.message,
  });

  final String message;

  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
        color: _muted,
        fontSize: 14.5,
        height: 1.5,
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.message,
  });

  final String message;

  static const Color _text = Color(0xFF2E2E2E);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _text,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}