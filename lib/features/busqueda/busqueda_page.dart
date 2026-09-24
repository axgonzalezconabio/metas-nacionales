import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

class BusquedaPage extends ConsumerStatefulWidget {
  const BusquedaPage({super.key});

  @override
  ConsumerState<BusquedaPage> createState() => _BusquedaPageState();
}

class _BusquedaPageState extends ConsumerState<BusquedaPage> {
  final TextEditingController _controller = TextEditingController();

  String _busqueda = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _actualizarBusqueda(String valor) {
    setState(() {
      _busqueda = valor.trim().toLowerCase();
    });
  }

  List<MetaNacionalConEje> _filtrarMetas(
    List<MetaNacionalConEje> metas,
  ) {
    if (_busqueda.isEmpty) {
      return metas;
    }

    return metas.where((item) {
      final meta = item.meta;
      final eje = item.eje;

      final texto = [
        meta.codigo,
        meta.nombre,
        meta.descripcion ?? '',
        eje.nombre,
      ].join(' ').toLowerCase();

      return texto.contains(_busqueda);
    }).toList();
  }

  Color _colorEje(String nombre) {
    switch (nombre.toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    final metasAsync = ref.watch(metasNacionalesConEjeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F5F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF641C34),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Buscar',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: metasAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF641C34),
          ),
        ),
        error: (error, stack) => _ErrorView(
          onRetry: () {
            ref.invalidate(metasNacionalesConEjeProvider);
          },
        ),
        data: (metas) {
          final resultados = _filtrarMetas(metas);

          return Column(
            children: [
              _SearchHeader(
                controller: _controller,
                onChanged: _actualizarBusqueda,
                onClear: () {
                  _controller.clear();
                  _actualizarBusqueda('');
                },
              ),
              Expanded(
                child: _SearchResults(
                  resultados: resultados,
                  busqueda: _busqueda,
                  colorEje: _colorEje,
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
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: const BoxDecoration(
        color: Color(0xFF641C34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Encuentra una meta nacional',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Busca por código, nombre, descripción o eje de acción.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Ej. 1.1, deforestación, conservar...',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF641C34),
              ),
              suffixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: onClear,
                      icon: const Icon(Icons.close_rounded),
                    ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    required this.resultados,
    required this.busqueda,
    required this.colorEje,
  });

  final List<MetaNacionalConEje> resultados;
  final String busqueda;
  final Color Function(String) colorEje;

  @override
  Widget build(BuildContext context) {
    if (resultados.isEmpty) {
      return _EmptySearch(
        busqueda: busqueda,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth;
        final esAmplio = ancho >= 800;

        if (esAmplio) {
          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 520,
              mainAxisExtent: 185,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: resultados.length,
            itemBuilder: (context, index) {
              return _MetaSearchCard(
                item: resultados[index],
                color: colorEje(resultados[index].eje.nombre),
              );
            },
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: resultados.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _MetaSearchCard(
              item: resultados[index],
              color: colorEje(resultados[index].eje.nombre),
            );
          },
        );
      },
    );
  }
}

class _MetaSearchCard extends StatelessWidget {
  const _MetaSearchCard({
    required this.item,
    required this.color,
  });

  final MetaNacionalConEje item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final meta = item.meta;
    final eje = item.eje;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          context.push('/metas/${meta.codigo}');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.06),
            ),
          ),
          padding: const EdgeInsets.all(17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.eco_rounded,
                  color: color,
                  size: 25,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            meta.codigo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          eje.nombre,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      meta.nombre,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF292929),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    if (meta.descripcion != null &&
                        meta.descripcion!.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        meta.descripcion!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch({
    required this.busqueda,
  });

  final String busqueda;

  @override
  Widget build(BuildContext context) {
    final tieneBusqueda = busqueda.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFF641C34).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 38,
                color: Color(0xFF641C34),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              tieneBusqueda
                  ? 'No encontramos resultados'
                  : 'Busca una meta nacional',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF292929),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tieneBusqueda
                  ? 'Prueba con otro código, nombre, palabra o eje de acción.'
                  : 'Escribe algo en el campo de búsqueda para comenzar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Color(0xFF641C34),
            ),
            const SizedBox(height: 12),
            const Text(
              'No se pudo cargar la búsqueda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF641C34),
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}