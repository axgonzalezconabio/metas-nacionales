import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

class MetasPage extends ConsumerStatefulWidget {
  const MetasPage({super.key});

  @override
  ConsumerState<MetasPage> createState() =>
      _MetasPageState();
}

class _MetasPageState extends ConsumerState<MetasPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _busqueda = '';

  static const Color _wine = Color(0xFF641C34);
  static const Color _background = Color(0xFFF6F5F1);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metasAsync =
        ref.watch(metasNacionalesConEjeProvider);

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _wine,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Metas nacionales',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: metasAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const _MessageState(
          message:
              'No fue posible cargar las metas nacionales.',
        ),
        data: (metas) {
          if (metas.isEmpty) {
            return const _MessageState(
              message:
                  'No hay metas nacionales disponibles.',
            );
          }

          final texto =
              _busqueda.trim().toLowerCase();

          final metasFiltradas = metas.where((item) {
            if (texto.isEmpty) {
              return true;
            }

            final meta = item.meta;

            return meta.codigo
                    .toLowerCase()
                    .contains(texto) ||
                meta.nombre
                    .toLowerCase()
                    .contains(texto) ||
                item.eje.nombre
                    .toLowerCase()
                    .contains(texto) ||
                (meta.descripcion
                        ?.toLowerCase()
                        .contains(texto) ??
                    false);
          }).toList();

          return Column(
            children: [
              _SearchHeader(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _busqueda = value;
                  });
                },
                totalMetas: metas.length,
                resultados: metasFiltradas.length,
              ),
              Expanded(
                child: metasFiltradas.isEmpty
                    ? const _EmptySearchState()
                    : _MetasList(
                        metas: metasFiltradas,
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
    required this.onChanged,
    required this.totalMetas,
    required this.resultados,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int totalMetas;
  final int resultados;

  static const Color _wine = Color(0xFF641C34);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final buscando = controller.text.trim().isNotEmpty;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        16,
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
              TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText:
                      'Buscar por código, nombre o descripción...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon: buscando
                      ? IconButton(
                          tooltip: 'Limpiar búsqueda',
                          onPressed: () {
                            controller.clear();
                            onChanged('');
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor:
                      const Color(0xFFF6F5F1),
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
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.eco_outlined,
                    size: 18,
                    color: _wine,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    buscando
                        ? '$resultados de $totalMetas metas'
                        : '$totalMetas metas nacionales',
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetasList extends StatelessWidget {
  const _MetasList({
    required this.metas,
  });

  final List<MetaNacionalConEje> metas;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth;

        if (ancho >= 900) {
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              32,
            ),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 520,
              mainAxisExtent: 190,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: metas.length,
            itemBuilder: (context, index) {
              return _MetaCard(
                item: metas[index],
              );
            },
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            32,
          ),
          itemCount: metas.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _MetaCard(
              item: metas[index],
            );
          },
        );
      },
    );
  }
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({
    required this.item,
  });

  final MetaNacionalConEje item;

  static const Color _text = Color(0xFF2E2E2E);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    final meta = item.meta;
    final eje = item.eje;
    final ejeColor = _colorEje(eje.nombre);

    final descripcion = meta.descripcion?.trim();
    final tieneDescripcion =
        descripcion != null && descripcion.isNotEmpty;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          context.push('/metas/${meta.codigo}');
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
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
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ejeColor.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Text(
                  meta.codigo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ejeColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      eje.nombre,
                      style: TextStyle(
                        color: ejeColor,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      meta.nombre,
                      maxLines: 3,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    if (tieneDescripcion) ...[
                      const SizedBox(height: 7),
                      Text(
                        descripcion,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 12.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                color: _muted,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _colorEje(String nombre) {
    switch (nombre.trim().toUpperCase()) {
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

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  static const Color _wine = Color(0xFF641C34);
  static const Color _muted = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _wine.withValues(
                  alpha: 0.08,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: _wine,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No encontramos metas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Prueba con otro código, nombre o término.',
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