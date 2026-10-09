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

String _numeroMetaGlobalVisible(String codigo) {

  final numero = double.tryParse(codigo);

  if (numero == null) return codigo;

  if (numero == numero.truncateToDouble()) {

    return numero.toInt().toString();

  }

  return codigo;

}

class MetaGlobalDetailPage extends ConsumerWidget {

  const MetaGlobalDetailPage({

    super.key,

    required this.codigo,

  });

  final String codigo;

  static const Color _background = Color(0xFFF6F5F1);

  static const Color _text = Color(0xFF2E2E2E);

  @override

  Widget build(

    BuildContext context,

    WidgetRef ref,

  ) {

    final repositoryAsync =

        ref.watch(metasNacionalesRepositoryProvider);

    return repositoryAsync.when(

      loading: () => _buildScaffold(

        accentColor: const Color(0xFF641C34),

        body: const Center(

          child: CircularProgressIndicator(),

        ),

      ),

      error: (error, stack) => _buildScaffold(

        accentColor: const Color(0xFF641C34),

        body: const Center(

          child: Padding(

            padding: EdgeInsets.all(24),

            child: Text(

              'No fue posible cargar la información de la meta global.',

              textAlign: TextAlign.center,

              style: TextStyle(

                color: _text,

                fontSize: 16,

              ),

            ),

          ),

        ),

      ),

      data: (repository) {

        return FutureBuilder<MetaGlobalDetalle?>(

          future: repository.obtenerDetalleMetaGlobal(codigo),

          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {

              return _buildScaffold(

                accentColor: const Color(0xFF641C34),

                body: const Center(

                  child: CircularProgressIndicator(),

                ),

              );

            }

            if (snapshot.hasError) {

              return _buildScaffold(

                accentColor: const Color(0xFF641C34),

                body: const Center(

                  child: Padding(

                    padding: EdgeInsets.all(24),

                    child: Text(

                      'No fue posible cargar la meta global.',

                      textAlign: TextAlign.center,

                    ),

                  ),

                ),

              );

            }

            final detalle = snapshot.data;

            if (detalle == null) {

              return _buildScaffold(

                accentColor: const Color(0xFF641C34),

                body: const Center(

                  child: Padding(

                    padding: EdgeInsets.all(24),

                    child: Text(

                      'No se encontró la meta global.',

                      textAlign: TextAlign.center,

                    ),

                  ),

                ),

              );

            }

            final accentColor = _colorPorPilar(detalle.eje.nombre);

            final pageBackground =

                Color.lerp(_background, accentColor, 0.055)!;

            return Scaffold(

              backgroundColor: pageBackground,

              appBar: AppBar(

                backgroundColor: accentColor,

                foregroundColor: Colors.white,

                elevation: 0,

                title: const Text(

                  'Meta Global',

                  style: TextStyle(

                    fontWeight: FontWeight.w700,

                  ),

                ),

              ),

              body: _MetaGlobalContent(

                detalle: detalle,

                accentColor: accentColor,

              ),

            );

          },

        );

      },

    );

  }

  Widget _buildScaffold({

    required Color accentColor,

    required Widget body,

  }) {

    return Scaffold(

      backgroundColor: _background,

      appBar: AppBar(

        backgroundColor: accentColor,

        foregroundColor: Colors.white,

        elevation: 0,

        title: const Text(

          'Meta Global',

          style: TextStyle(

            fontWeight: FontWeight.w700,

          ),

        ),

      ),

      body: body,

    );

  }

}

class _MetaGlobalContent extends StatelessWidget {

  const _MetaGlobalContent({

    required this.detalle,

    required this.accentColor,

  });

  final MetaGlobalDetalle detalle;

  final Color accentColor;

  static const Color _text = Color(0xFF2E2E2E);

  static const Color _muted = Color(0xFF6B6B6B);

  @override

  Widget build(BuildContext context) {

    final global = detalle.metaGlobal;

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

                'META GLOBAL ${_numeroMetaGlobalVisible(global.codigo)}',

                style: TextStyle(

                  color: accentColor,

                  fontSize: 13,

                  fontWeight: FontWeight.w800,

                  letterSpacing: 0.8,

                ),

              ),

              const SizedBox(height: 8),

              Text(

                global.nombre,

                style: const TextStyle(

                  color: _text,

                  fontSize: 26,

                  fontWeight: FontWeight.w800,

                  height: 1.2,

                ),

              ),

              const SizedBox(height: 24),

              _SectionCard(

                accentColor: accentColor,

                title: 'Descripción',

                icon: Icons.description_outlined,

                child: Text(

                  global.descripcion ??

                      'Sin descripción disponible.',

                  style: const TextStyle(

                    color: _text,

                    fontSize: 16,

                    height: 1.55,

                  ),

                ),

              ),

              const SizedBox(height: 16),

              _SectionCard(

                accentColor: accentColor,

                title: 'Contexto',

                icon: Icons.account_tree_outlined,

                child: Column(

                  children: [

                    _InfoRow(

                      label: 'Número',

                      value: _numeroMetaGlobalVisible(global.codigo),

                    ),

                    const SizedBox(height: 12),

                    _InfoRow(

                      label: 'Pilar',

                      value: detalle.eje.nombre,

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 16),

              _SectionCard(

                accentColor: accentColor,

                title: 'Metas nacionales asociadas',

                icon: Icons.flag_outlined,

                child: detalle.metasNacionales.isEmpty

                    ? const Text(

                        'Esta meta global no tiene metas nacionales asociadas.',

                        style: TextStyle(

                          color: _muted,

                          fontSize: 15,

                          height: 1.5,

                        ),

                      )

                    : Column(

                        children: [

                          for (var i = 0;

                              i <

                                  detalle

                                      .metasNacionales

                                      .length;

                              i++) ...[

                            _MetaNacionalItem(

                              meta: detalle

                                  .metasNacionales[i],

                              accentColor: accentColor,

                            ),

                            if (i <

                                detalle

                                        .metasNacionales

                                        .length -

                                    1)

                              const SizedBox(height: 10),

                          ],

                        ],

                      ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}

class _MetaNacionalItem extends StatelessWidget {

  const _MetaNacionalItem({

    required this.meta,

    required this.accentColor,

  });

  final MetasNacionale meta;

  final Color accentColor;

  static const Color _text = Color(0xFF2E2E2E);

  static const Color _muted = Color(0xFF6B6B6B);

  @override

  Widget build(BuildContext context) {

    return Material(

      color: const Color(0xFFF8F7F4),

      borderRadius: BorderRadius.circular(14),

      child: InkWell(

        borderRadius: BorderRadius.circular(14),

        onTap: () {

          context.push('/metas/${meta.codigo}');

        },

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Row(

            crossAxisAlignment:

                CrossAxisAlignment.start,

            children: [

              Container(

                padding: const EdgeInsets.symmetric(

                  horizontal: 10,

                  vertical: 8,

                ),

                decoration: BoxDecoration(

                  color: accentColor.withValues(alpha: 0.10),

                  borderRadius:

                      BorderRadius.circular(10),

                ),

                child: Text(

                  meta.codigo,

                  style: TextStyle(

                    color: accentColor,

                    fontSize: 13,

                    fontWeight: FontWeight.w800,

                  ),

                ),

              ),

              const SizedBox(width: 12),

              Expanded(

                child: Column(

                  crossAxisAlignment:

                      CrossAxisAlignment.start,

                  children: [

                    Text(

                      meta.nombre,

                      style: const TextStyle(

                        color: _text,

                        fontSize: 15.5,

                        fontWeight: FontWeight.w700,

                        height: 1.35,

                      ),

                    ),

                    if (meta.descripcion != null &&

                        meta.descripcion!

                            .trim()

                            .isNotEmpty) ...[

                      const SizedBox(height: 6),

                      Text(

                        meta.descripcion!,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

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

                Icons.chevron_right,

                color: accentColor,

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

    required this.accentColor,

  });

  final String title;

  final IconData icon;

  final Widget child;

  final Color accentColor;

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
