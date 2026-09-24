import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

class InstitucionDetailPage extends ConsumerWidget {
  const InstitucionDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  static const Color _wine = Color(0xFF641C34);
  static const Color _background = Color(0xFFF6F5F1);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final institucionAsync =
        ref.watch(institucionPorIdProvider(id));

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _wine,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Institución',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: institucionAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'No fue posible cargar la institución.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (institucion) {
          if (institucion == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No se encontró la institución.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return _InstitucionContent(
            institucion: institucion,
          );
        },
      ),
    );
  }
}

class _InstitucionContent extends ConsumerWidget {
  const _InstitucionContent({
    required this.institucion,
  });

  final Institucione institucion;

  static const Color _text = Color(0xFF2E2E2E);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final participacionesAsync =
        ref.watch(
          metasPorInstitucionProvider(
            institucion.id,
          ),
        );

    final nombreCorto =
        institucion.nombreCorto?.trim();

    final tieneNombreCorto =
        nombreCorto != null &&
        nombreCorto.isNotEmpty;

    final tipo = institucion.tipo?.trim();

    final tieneTipo =
        tipo != null && tipo.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _InstitutionHeader(
                institucion: institucion,
                nombreCorto: nombreCorto,
                tieneNombreCorto:
                    tieneNombreCorto,
                tipo: tipo,
                tieneTipo: tieneTipo,
              ),
              const SizedBox(height: 18),
              if (institucion.descripcion
                      ?.trim()
                      .isNotEmpty ==
                  true)
                _SectionCard(
                  title: 'Descripción',
                  icon: Icons.description_outlined,
                  child: Text(
                    institucion.descripcion!.trim(),
                    style: const TextStyle(
                      color: _text,
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              participacionesAsync.when(
                loading: () => const _LoadingSection(),
                error: (error, stack) =>
                    const _ErrorSection(),
                data: (participaciones) {
                  return _ParticipacionesSection(
                    participaciones:
                        participaciones,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstitutionHeader extends StatelessWidget {
  const _InstitutionHeader({
    required this.institucion,
    required this.nombreCorto,
    required this.tieneNombreCorto,
    required this.tipo,
    required this.tieneTipo,
  });

  final Institucione institucion;
  final String? nombreCorto;
  final bool tieneNombreCorto;
  final String? tipo;
  final bool tieneTipo;

  static const Color _wine = Color(0xFF641C34);
  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.black.withValues(
            alpha: 0.05,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: _wine.withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.account_balance_rounded,
              color: _wine,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                if (tieneNombreCorto)
                  Text(
                    nombreCorto!,
                    style: const TextStyle(
                      color: _wine,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  institucion.nombre,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                if (tieneTipo) ...[
                  const SizedBox(height: 8),
                  Text(
                    tipo!,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipacionesSection extends StatelessWidget {
  const _ParticipacionesSection({
    required this.participaciones,
  });

  final List<InstitucionMetaParticipacion>
      participaciones;

  static const Color _wine = Color(0xFF641C34);
  static const Color _coordinadora =
      Color(0xFF4A6E7D);
  static const Color _coadyuvante =
      Color(0xFF94A65B);
  static const Color _muted =
      Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final coordinadoras = participaciones
        .where(
          (item) =>
              item.participacion.tipoParticipacion
                  .toUpperCase() ==
              'COORDINADORA',
        )
        .toList();

    final coadyuvantes = participaciones
        .where(
          (item) =>
              item.participacion.tipoParticipacion
                  .toUpperCase() ==
              'COADYUVANTE',
        )
        .toList();

    if (participaciones.isEmpty) {
      return _SectionCard(
        title: 'Participación',
        icon: Icons.link_rounded,
        child: const Text(
          'Esta institución no tiene participaciones registradas.',
          style: TextStyle(
            color: _muted,
            fontSize: 14,
          ),
        ),
      );
    }

    return Column(
      children: [
        if (coordinadoras.isNotEmpty)
          _ParticipationGroup(
            title: 'Coordinadora',
            icon: Icons.flag_rounded,
            color: _coordinadora,
            metas: coordinadoras,
          ),
        if (coordinadoras.isNotEmpty &&
            coadyuvantes.isNotEmpty)
          const SizedBox(height: 18),
        if (coadyuvantes.isNotEmpty)
          _ParticipationGroup(
            title: 'Coadyuvante',
            icon: Icons.handshake_outlined,
            color: _coadyuvante,
            metas: coadyuvantes,
          ),
        if (coordinadoras.isEmpty &&
            coadyuvantes.isEmpty)
          _SectionCard(
            title: 'Participación',
            icon: Icons.link_rounded,
            child: Text(
              'Se encontraron participaciones, pero no tienen un tipo reconocido.',
              style: TextStyle(
                color: _muted,
                fontSize: 14,
              ),
            ),
          ),
        const SizedBox(height: 18),
        _SectionCard(
          title: 'Total de participaciones',
          icon: Icons.analytics_outlined,
          child: Text(
            '${participaciones.length} '
            '${participaciones.length == 1 ? 'participación registrada' : 'participaciones registradas'}',
            style: const TextStyle(
              color: _wine,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _ParticipationGroup extends StatelessWidget {
  const _ParticipationGroup({
    required this.title,
    required this.icon,
    required this.color,
    required this.metas,
  });

  final String title;
  final IconData icon;
  final Color color;
  final List<InstitucionMetaParticipacion>
      metas;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: title,
      icon: icon,
      iconColor: color,
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: color.withValues(
            alpha: 0.10,
          ),
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: Text(
          '${metas.length}',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < metas.length; i++) ...[
            _MetaInstitutionItem(
              item: metas[i],
              color: color,
            ),
            if (i < metas.length - 1)
              const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _MetaInstitutionItem
    extends StatelessWidget {
  const _MetaInstitutionItem({
    required this.item,
    required this.color,
  });

  final InstitucionMetaParticipacion item;
  final Color color;

  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final meta = item.meta;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.push('/metas/${meta.codigo}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 4,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Text(
                meta.codigo,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                meta.nombre,
                style: const TextStyle(
                  color: _text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: _muted,
              size: 21,
            ),
          ],
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
    this.iconColor,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Color? iconColor;
  final Widget? trailing;

  static const Color _wine = Color(0xFF641C34);

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? _wine;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withValues(
            alpha: 0.05,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 21,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (trailing != null) ...[
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  const _ErrorSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'Participación',
      icon: Icons.link_rounded,
      child: Text(
        'No fue posible cargar las participaciones de la institución.',
      ),
    );
  }
}