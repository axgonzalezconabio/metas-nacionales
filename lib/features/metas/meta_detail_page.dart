import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';

import 'package:metas_nacionales/data/database/app_database.dart';

import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

Color _colorPorPilar(String nombre) {

  switch (nombre.toLowerCase().trim()) {

    case 'conservar':

      return const Color(0xFF94A65B);

    case 'evitar':

      return const Color(0xFF7C1716);

    case 'salvaguardar':

      return const Color(0xFF4A6E7D);

    case 'actuar':

      return const Color(0xFFEA5E25);

    default:

      return const Color(0xFF641C34);

  }

}

String _codigoMetaGlobalVisible(String codigo) {

  final numero = double.tryParse(codigo);

  if (numero == null) return codigo;

  if (numero == numero.truncateToDouble()) {

    return numero.toInt().toString();

  }

  return codigo;

}

String _corregirSiglas(String texto) {

  const siglas = [

    'nom-059-semarnat-2010',

    'conabio',

    'semarnat',

    'conanp',

    'conagua',

    'conafor',

    'conaza',

    'conapesca',

    'conuee',

    'conabio-ac cites',

    'conabio-carb',

    'conabio-csiamc',

    'conabio-dap',

    'conabio-deeb',

    'anam',

    'anp',

    'apb',

    'asea',

    'abc',

    'abe',

    'abrrd',

  
  
  
    'cenaprece',

    'cenapred',

    'cfp',

    'cibiogem',

    'cicc',

    'ciconmar',

    'cjf',

    'cma',

    'cmnucc',

    'cnpa',

    'cnpi',

    'cofepris',

    'dgpac',

    'dgot',

    'eca',

    'eei',

    'emfs',

    'enaredd+',

    'fip',

    'gm',

    'gt-adapt',

    'gt-redd+',

    'hfc',

    'hcfc',

    'imipas',

    'impi',

    'imta',

    'inecc',

    'inegi',

    'inifap',

    'inpi',

    'insp',

    'lgaas',

    'lgeepa',

    'nap',

    'ndc',

    'nom',

    'oit',

    'omec',

  
  
    'pace',

    'pecc',

    'pemex',

    'pfn',

    'picla',

    'pimvs',

    'pmt',

    'pmp',

    'pnmsmcm',

    'pnra',

    'poem',

    'profepa',

    'psa',

    'ran',

    'redd+',

    'sbn',

    'scian',

    'simoh-mx',

    'snib',

    'secihti',

    'sectur',

    'sedatu',

    'sedena',

    'segob',

    'semar',

    'sener',

    'senasica',

    'sep',

    'shcp',

    'sict',

    'siagrobd',

    'smmm',

    'simar',

  
  
  
  
  
    'eccbio',

    'snira',

    'eneei',

    'satif',

    'renom',

    'wdoecm',

    'prosectur',

    'ogm',

    'sre',

    'sre-amexcid',

    'uma',

    'uaiff',

    'upa',

    'upp',

    'zrp',

    'unam',

    'ipn',

    'uam',

    'ine',

    'inah',

    'inapesca',

    'fao',

    'onu',

    'cfe',

    'semarnat-cecadesu',

    'semarnat-dgcgmc',

    'semarnat-dggfsoe',

    'semarnat-dgielgca',

    'semarnat-dgimar',

    'semarnat-dgira',

    'semarnat-dgit',

    'semarnat-dgpac',

    'semarnat-dgpeea',

    'semarnat-dgra',

    'semarnat-dgvs',

    'semarnat-dgzfmtac',

    'semarnat-ucai',

    'semarnat-ucaj',

    'semarnat-ucorgt',

    'semarnat-ucppvsdh',

  ];

  var resultado = texto;

  // Primero las siglas más largas para evitar

  // que una sigla simple interfiera con una compuesta.

  final siglasOrdenadas = [...siglas]

    ..sort((a, b) => b.length.compareTo(a.length));

  for (final sigla in siglasOrdenadas) {

    resultado = resultado.replaceAllMapped(

      RegExp(

        r'(?<![A-Za-zÀ-ÖØ-öø-ÿ0-9])' +

            RegExp.escape(sigla) +

            r'(?![A-Za-zÀ-ÖØ-öø-ÿ0-9])',

        caseSensitive: false,

      ),

      (_) => sigla.toUpperCase(),

    );

  }

  return resultado;

}

class MetaDetailPage extends ConsumerWidget {

  const MetaDetailPage({

    super.key,

    required this.codigo,

  });

  final String codigo;

  static const Color _background = Color(0xFFF6F5F1);

  static const Color _text = Color(0xFF2E2E2E);

  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final repositoryAsync = ref.watch(metasNacionalesRepositoryProvider);

    return repositoryAsync.when(

      loading: () => const Scaffold(

        backgroundColor: _background,

        body: Center(child: CircularProgressIndicator()),

      ),

      error: (error, stack) => const Scaffold(

        backgroundColor: _background,

        body: Center(

          child: Padding(

            padding: EdgeInsets.all(24),

            child: Text(

              'No fue posible cargar la información de la meta.',

              textAlign: TextAlign.center,

              style: TextStyle(color: _text, fontSize: 16),

            ),

          ),

        ),

      ),

      data: (repository) => FutureBuilder<MetaNacionalDetalle?>(

        future: repository.obtenerDetalleMetaNacional(codigo),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Scaffold(

              backgroundColor: _background,

              body: Center(child: CircularProgressIndicator()),

            );

          }

          if (snapshot.hasError) {

            return const Scaffold(

              backgroundColor: _background,

              body: Center(

                child: Padding(

                  padding: EdgeInsets.all(24),

                  child: Text(

                    'No fue posible cargar la meta.',

                    textAlign: TextAlign.center,

                  ),

                ),

              ),

            );

          }

          final detalle = snapshot.data;

          if (detalle == null) {

            return const Scaffold(

              backgroundColor: _background,

              body: Center(

                child: Padding(

                  padding: EdgeInsets.all(24),

                  child: Text(

                    'No se encontró la meta nacional.',

                    textAlign: TextAlign.center,

                  ),

                ),

              ),

            );

          }

          final accentColor = _colorPorPilar(detalle.eje.nombre);

          final pageBackground = Color.lerp(

            _background,

            accentColor,

            0.06,

          )!;

          return Scaffold(

            backgroundColor: pageBackground,

            appBar: AppBar(

              backgroundColor: accentColor,

              foregroundColor: Colors.white,

              elevation: 0,

              title: const Text(

                'Meta Nacional',

                style: TextStyle(fontWeight: FontWeight.w700),

              ),

            ),

            body: _MetaContent(

              detalle: detalle,

              accentColor: accentColor,

            ),

          );

        },

      ),

    );

  }

}

class _MetaContent extends ConsumerWidget {

  const _MetaContent({

    required this.detalle,

    required this.accentColor,

  });

  final MetaNacionalDetalle detalle;

  final Color accentColor;

    static const Color _text = Color(0xFF2E2E2E);

  static const Color _muted = Color(0xFF6B6B6B);

  @override

  Widget build(

    BuildContext context,

    WidgetRef ref,

  ) {

    final meta = detalle.meta;

    final hitosAsync =

        ref.watch(hitosPorMetaProvider(meta.id));

    final institucionesAsync =

        ref.watch(

          institucionesPorMetaProvider(meta.id),

        );

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

              Text(

                'META NACIONAL ${meta.codigo}',

                style: TextStyle(

                  color: accentColor,

                  fontSize: 13,

                  fontWeight: FontWeight.w800,

                  letterSpacing: 0.8,

                ),

              ),

              const SizedBox(height: 8),

              Text(

                meta.nombre,

                style: const TextStyle(

                  color: _text,

                  fontSize: 26,

                  fontWeight: FontWeight.w800,

                  height: 1.2,

                ),

              ),

              const SizedBox(height: 24),

              // DESCRIPCIÓN

              _SectionCard(

                accentColor: accentColor,

                title: 'Descripción',

                icon: Icons.description_outlined,

                child: Text(

                  _corregirSiglas(

                    meta.descripcion ??

                      'Sin descripción disponible.',

                  ),

                  style: const TextStyle(

                    color: _text,

                    fontSize: 16,

                    height: 1.55,

                  ),

                ),

              ),

              const SizedBox(height: 16),

              // CONTEXTO

              _SectionCard(

                accentColor: accentColor,

                title: 'Contexto',

                icon: Icons.account_tree_outlined,

                child: Column(

                  children: [

                    _InfoRow(

                      label: 'Pilar',

                      value: detalle.eje.nombre,

                    ),

                    const SizedBox(height: 12),

                    InkWell(

                      borderRadius: BorderRadius.circular(10),

                      onTap: () {

                        context.push(

                          '/metas-globales/${detalle.metaGlobal.codigo}',

                        );

                      },

                      child: Padding(

                        padding: const EdgeInsets.symmetric(

                          vertical: 6,

                        ),

                        child: Row(

                          crossAxisAlignment:

                              CrossAxisAlignment.start,

                          children: [

                            const SizedBox(

                              width: 110,

                              child: Text(

                                'Meta global',

                                style: TextStyle(

                                  fontWeight: FontWeight.w700,

                                  color: Color(0xFF6B6B6B),

                                ),

                              ),

                            ),

                            const SizedBox(width: 12),

                            Expanded(

                              child: Row(

                                crossAxisAlignment:

                                    CrossAxisAlignment.start,

                                children: [

                                  Expanded(

                                    child: Text(

                                      '${_codigoMetaGlobalVisible(detalle.metaGlobal.codigo)} · '

                                      '${detalle.metaGlobal.nombre}', 

                                      style: TextStyle(

                                        color: accentColor,

                                        fontWeight: FontWeight.w700,

                                      ),

                                    ),

                                  ),

                                  Icon(

                                    Icons.chevron_right,

                                    color: accentColor,

                                    size: 21,

                                  ),

                                ],

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 16),

              // HITOS

              _SectionCard(

                accentColor: accentColor,

                title: 'Hitos',

                icon: Icons.flag_outlined,

                child: hitosAsync.when(

                  loading: () => const Padding(

                    padding: EdgeInsets.symmetric(

                      vertical: 8,

                    ),

                    child: Center(

                      child: CircularProgressIndicator(),

                    ),

                  ),

                  error: (error, stack) => const Text(

                    'No fue posible cargar los hitos.',

                    style: TextStyle(

                      color: _muted,

                      fontSize: 15,

                      height: 1.5,

                    ),

                  ),

                  data: (hitos) {

                    if (hitos.isEmpty) {

                      return const Text(

                        'Esta meta no tiene hitos registrados.',

                        style: TextStyle(

                          color: _muted,

                          fontSize: 15,

                          height: 1.5,

                        ),

                      );

                    }

                    return Column(

                      children: [

                        for (var i = 0;

                            i < hitos.length;

                            i++) ...[

                          _HitoItem(

                            hito: hitos[i],

                            accentColor: accentColor,

                          ),

                          if (i < hitos.length - 1)

                            const SizedBox(height: 12),

                        ],

                      ],

                    );

                  },

                ),

              ),

              const SizedBox(height: 16),

              // INSTITUCIONES

              _SectionCard(

                accentColor: accentColor,

                title: 'Instituciones',

                icon: Icons.account_balance_outlined,

                child: institucionesAsync.when(

                  loading: () => const Padding(

                    padding: EdgeInsets.symmetric(

                      vertical: 8,

                    ),

                    child: Center(

                      child: CircularProgressIndicator(),

                    ),

                  ),

                  error: (error, stack) => const Text(

                    'No fue posible cargar las instituciones.',

                    style: TextStyle(

                      color: _muted,

                      fontSize: 15,

                      height: 1.5,

                    ),

                  ),

                  data: (instituciones) {

                    if (instituciones.isEmpty) {

                      return const Text(

                        'Esta meta no tiene instituciones registradas.',

                        style: TextStyle(

                          color: _muted,

                          fontSize: 15,

                          height: 1.5,

                        ),

                      );

                    }

                    final coordinadoras =

                        instituciones

                            .where(

                              (item) =>

                                  item.participacion

                                      .tipoParticipacion

                                      .toUpperCase() ==

                                  'COORDINADORA',

                            )

                            .toList();

                    final coadyuvantes =

                        instituciones

                            .where(

                              (item) =>

                                  item.participacion

                                      .tipoParticipacion

                                      .toUpperCase() ==

                                  'COADYUVANTE',

                            )

                            .toList();

                    return Column(

                      crossAxisAlignment:

                          CrossAxisAlignment.start,

                      children: [

                        if (coordinadoras.isNotEmpty) ...[

                          _InstitutionGroupTitle(

                            accentColor: accentColor,

                            title: 'Coordinadoras',

                            icon:

                                Icons.star_outline_rounded,

                          ),

                          const SizedBox(height: 10),

                          for (var i = 0;

                              i < coordinadoras.length;

                              i++) ...[

                            _InstitutionItem(

                              accentColor: accentColor,

                              item: coordinadoras[i],

                            ),

                            if (i <

                                coordinadoras.length - 1)

                              const SizedBox(height: 10),

                          ],

                        ],

                        if (coordinadoras.isNotEmpty &&

                            coadyuvantes.isNotEmpty)

                          const SizedBox(height: 22),

                        if (coadyuvantes.isNotEmpty) ...[

                          _InstitutionGroupTitle(

                            accentColor: accentColor,

                            title: 'Coadyuvantes',

                            icon:

                                Icons.handshake_outlined,

                          ),

                          const SizedBox(height: 10),

                          for (var i = 0;

                              i < coadyuvantes.length;

                              i++) ...[

                            _InstitutionItem(

                              accentColor: accentColor,

                              item: coadyuvantes[i],

                            ),

                            if (i <

                                coadyuvantes.length - 1)

                              const SizedBox(height: 10),

                          ],

                        ],

                      ],

                    );

                  },

                ),

              ),

              const SizedBox(height: 16),

            ],

          ),

        ),

      ),

    );

  }

}

class _HitoItem extends ConsumerWidget {

  const _HitoItem({

    required this.hito,

    required this.accentColor,

  });

  final Hito hito;

  final Color accentColor;

  static const Color _text = Color(0xFF2E2E2E);

  static const Color _muted = Color(0xFF6B6B6B);

  @override

  Widget build(

    BuildContext context,

    WidgetRef ref,

  ) {

    final subhitosAsync =

        ref.watch(

          subhitosPorHitoProvider(hito.id),

        );

    final descripcion =

        hito.descripcion ??

        hito.nombre ??

        'Sin descripción disponible.';

    return Container(

      width: double.infinity,

      decoration: BoxDecoration(

        color: const Color(0xFFF8F7F4),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(

          color: accentColor.withValues(alpha: 0.10),

        ),

      ),

      child: ExpansionTile(

        tilePadding: const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 4,

        ),

        childrenPadding:

            const EdgeInsets.fromLTRB(

          16,

          0,

          16,

          16,

        ),

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(16),

        ),

        collapsedShape:

            RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(16),

        ),

        iconColor: accentColor,

        collapsedIconColor:

            Colors.black.withValues(alpha: 0.35),

        title: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(

              padding: const EdgeInsets.symmetric(

                horizontal: 10,

                vertical: 7,

              ),

              decoration: BoxDecoration(

                color: accentColor.withValues(alpha: 0.10),

                borderRadius: BorderRadius.circular(10),

              ),

              child: Text(

                hito.codigo,

                style: TextStyle(

                  color: accentColor,

                  fontSize: 13,

                  fontWeight: FontWeight.w800,

                ),

              ),

            ),

            const SizedBox(height: 10),

            SizedBox(

              width: double.infinity,

              child: Text(

                _corregirSiglas(descripcion),

                style: const TextStyle(

                  color: _text,

                  fontSize: 15.5,

                  height: 1.55,

                ),

              ),

            ),

          ],

        ),

        children: [

          subhitosAsync.when(

            loading: () => const Padding(

              padding: EdgeInsets.symmetric(

                vertical: 12,

              ),

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

                crossAxisAlignment:

                    CrossAxisAlignment.start,

                children: [

                  Padding(

                    padding: const EdgeInsets.only(

                      bottom: 10,

                    ),

                    child: Text(

                      'Subhitos',

                      style: TextStyle(

                        color: accentColor,

                        fontSize: 14,

                        fontWeight: FontWeight.w800,

                      ),

                    ),

                  ),

                  for (var i = 0;

                      i < subhitos.length;

                      i++) ...[

                    _SubhitoItem(

                      accentColor: accentColor,

                      codigo: subhitos[i].codigo,

                      descripcion:

                          subhitos[i].descripcion,

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

class _SubhitoItem extends StatelessWidget {

  const _SubhitoItem({

    required this.accentColor,

    required this.codigo,

    required this.descripcion,

  });

  final Color accentColor;

  final String? codigo;

  final String descripcion;

  static const Color _text = Color(0xFF2E2E2E);

  @override

  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(

          color: accentColor.withValues(alpha: 0.10),

        ),

      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          if (codigo != null && codigo!.trim().isNotEmpty) ...[

            Container(

              padding: const EdgeInsets.symmetric(

                horizontal: 10,

                vertical: 7,

              ),

              decoration: BoxDecoration(

                color: accentColor.withValues(alpha: 0.10),

                borderRadius: BorderRadius.circular(10),

              ),

              child: Text(

                codigo!,

                style: TextStyle(

                  color: accentColor,

                  fontSize: 13,

                  fontWeight: FontWeight.w800,

                ),

              ),

            ),

            const SizedBox(height: 10),

          ],

          SizedBox(

            width: double.infinity,

            child: Text(

              _corregirSiglas(descripcion),

              style: const TextStyle(

                color: _text,

                fontSize: 15,

                height: 1.5,

              ),

            ),

          ),

        ],

      ),

    );

  }

}

class _InstitutionGroupTitle

    extends StatelessWidget {

  const _InstitutionGroupTitle({

    required this.accentColor,

    required this.title,

    required this.icon,

  });

  final Color accentColor;

  final String title;

  final IconData icon;

  @override

  Widget build(BuildContext context) {

    return Row(

      children: [

        Icon(

          icon,

          size: 19,

          color: accentColor,

        ),

        const SizedBox(width: 8),

        Text(

          title,

          style: TextStyle(

            color: accentColor,

            fontSize: 14,

            fontWeight: FontWeight.w800,

            letterSpacing: 0.4,

          ),

        ),

      ],

    );

  }

}

class _InstitutionItem extends StatelessWidget {

  const _InstitutionItem({

    required this.accentColor,

    required this.item,

  });

  final Color accentColor;

  final InstitucionParticipante item;

    static const Color _text = Color(0xFF2E2E2E);

  static const Color _muted = Color(0xFF6B6B6B);

  @override

  Widget build(BuildContext context) {

    final institucion = item.institucion;

    final participacion = item.participacion;

    final nombreCorto =

        institucion.nombreCorto?.trim().toUpperCase();

    final descripcion =

        participacion.descripcion?.trim();

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: const Color(0xFFF8F7F4),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(

          color: accentColor.withValues(alpha: 0.08),

        ),

      ),

      child: Row(

        crossAxisAlignment:

            CrossAxisAlignment.start,

        children: [

          Container(

            width: 42,

            height: 42,

            decoration: BoxDecoration(

              color: accentColor.withValues(alpha: 0.10),

              borderRadius:

                  BorderRadius.circular(12),

            ),

            child: Icon(

              Icons.account_balance_outlined,

              color: accentColor,

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

                if (nombreCorto != null &&

                    nombreCorto.isNotEmpty) ...[

                  const SizedBox(height: 4),

                  Text(

                    nombreCorto,

                    style: TextStyle(

                      color: accentColor,

                      fontSize: 13,

                      fontWeight: FontWeight.w800,

                    ),

                  ),

                ],

                if (descripcion != null &&

                    descripcion.isNotEmpty) ...[

                  const SizedBox(height: 8),

                  Text(

                    descripcion,

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

        ],

      ),

    );

  }

}

class _SectionCard extends StatelessWidget {

  const _SectionCard({

    required this.accentColor,

    required this.title,

    required this.icon,

    required this.child,

  });

  final Color accentColor;

  final String title;

  final IconData icon;

  final Widget child;

  @override

  Widget build(BuildContext context) {

    return Card(

      elevation: 0,

      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(18),

      ),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:

              CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                Icon(

                  icon,

                  color: accentColor,

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

      ),

    );

  }

}

class _InfoRow extends StatelessWidget {

  const _InfoRow({

    required this.label,

    required this.value,

  });

  final String label;

  final String value;

  @override

  Widget build(BuildContext context) {

    return Row(

      crossAxisAlignment:

          CrossAxisAlignment.start,

      children: [

        SizedBox(

          width: 110,

          child: Text(

            label,

            style: const TextStyle(

              fontWeight: FontWeight.w700,

              color: Color(0xFF6B6B6B),

            ),

          ),

        ),

        Expanded(

          child: Text(

            value,

            style: const TextStyle(

              color: Color(0xFF2E2E2E),

              fontWeight: FontWeight.w600,

            ),

          ),

        ),

      ],

    );

  }

}

