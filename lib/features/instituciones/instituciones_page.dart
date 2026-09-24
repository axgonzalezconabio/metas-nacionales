import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

class InstitucionesPage extends ConsumerStatefulWidget {
  const InstitucionesPage({super.key});

  @override
  ConsumerState<InstitucionesPage> createState() =>
      _InstitucionesPageState();
}

class _InstitucionesPageState
    extends ConsumerState<InstitucionesPage> {
  static const Color _wine = Color(0xFF641C34);
  static const Color _background = Color(0xFFF6F5F1);

  final TextEditingController _searchController =
      TextEditingController();

  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchText =
            _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final institucionesAsync =
        ref.watch(institucionesProvider);

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _wine,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Instituciones',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: institucionesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => const _ErrorView(),
        data: (instituciones) {
          final filtradas = instituciones.where((item) {
            if (_searchText.isEmpty) {
              return true;
            }

            final institucion = item.institucion;

            final nombre =
                institucion.nombre.toLowerCase();

            final nombreCorto =
                (institucion.nombreCorto ?? '')
                    .toLowerCase();

            final tipo =
                (institucion.tipo ?? '').toLowerCase();

            final descripcion =
                (institucion.descripcion ?? '')
                    .toLowerCase();

            return nombre.contains(_searchText) ||
                nombreCorto.contains(_searchText) ||
                tipo.contains(_searchText) ||
                descripcion.contains(_searchText);
          }).toList();

          return Column(
            children: [
              _SearchHeader(
                controller: _searchController,
                total: instituciones.length,
                resultados: filtradas.length,
              ),
              Expanded(
                child: filtradas.isEmpty
                    ? const _EmptyView()
                    : _InstitucionesList(
                        instituciones: filtradas,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.controller,
    required this.total,
    required this.resultados,
  });

  final TextEditingController controller;
  final int total;
  final int resultados;

  static const Color _wine = Color(0xFF641C34);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final mostrandoResultados =
        controller.text.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        12,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText:
                      'Buscar institución...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon:
                      controller.text.trim().isNotEmpty
                          ? IconButton(
                              tooltip: 'Limpiar búsqueda',
                              onPressed: () {
                                controller.clear();
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                              ),
                            )
                          : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: _wine,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  mostrandoResultados
                      ? '$resultados resultados'
                      : '$total instituciones',
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstitucionesList extends StatelessWidget {
  const _InstitucionesList({
    required this.instituciones,
  });

  final List<InstitucionResumen> instituciones;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth;

        final columnas = ancho >= 1100
            ? 3
            : ancho >= 700
                ? 2
                : 1;

        if (columnas == 1) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              20,
              4,
              20,
              32,
            ),
            itemCount: instituciones.length,
            itemBuilder: (context, index) {
              return _InstitucionCard(
                resumen: instituciones[index],
              );
            },
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(
            20,
            4,
            20,
            32,
          ),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnas,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio:
                columnas == 2 ? 1.55 : 1.45,
          ),
          itemCount: instituciones.length,
          itemBuilder: (context, index) {
            return _InstitucionCard(
              resumen: instituciones[index],
            );
          },
        );
      },
    );
  }
}

class _InstitucionCard extends StatelessWidget {
  const _InstitucionCard({
    required this.resumen,
  });

  final InstitucionResumen resumen;

  static const Color _wine = Color(0xFF641C34);
  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final institucion = resumen.institucion;

    final nombreCorto =
        institucion.nombreCorto?.trim();

    final tieneNombreCorto =
        nombreCorto != null &&
        nombreCorto.isNotEmpty;

    final tipo = institucion.tipo?.trim();

    final tieneTipo =
        tipo != null && tipo.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.black.withValues(
            alpha: 0.05,
          ),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          context.push(
            '/instituciones/${institucion.id}',
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _wine.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: _wine,
                  size: 25,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    if (tieneNombreCorto)
                      Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Text(
                          nombreCorto,
                          style: const TextStyle(
                            color: _wine,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    Text(
                      institucion.nombre,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    if (tieneTipo) ...[
                      const SizedBox(height: 7),
                      Text(
                        tipo,
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.link_rounded,
                          size: 16,
                          color: _muted,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${resumen.totalParticipaciones} '
                          '${resumen.totalParticipaciones == 1 ? 'participación' : 'participaciones'}',
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: _muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  static const Color _wine = Color(0xFF641C34);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: _wine.withValues(
                  alpha: 0.08,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: _wine,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No se encontraron instituciones',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Prueba con otro nombre o sigla.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _muted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No fue posible cargar las instituciones.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}