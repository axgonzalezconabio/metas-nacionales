import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';

class EjeMetasPage extends ConsumerWidget {
  const EjeMetasPage({
    super.key,
    required this.ejeNombre,
  });

  final String ejeNombre;

  static const _background = Color(0xFFF6F5F1);
  static const _text = Color(0xFF252525);
  static const _wine = Color(0xFF641C34);

  Color get _ejeColor {
    switch (ejeNombre.toLowerCase()) {
      case 'conservar':
        return const Color(0xFF94A65B);
      case 'evitar':
        return const Color(0xFF7C1716);
      case 'salvaguardar':
        return const Color(0xFF4A6E7D);
      case 'actuar':
        return const Color(0xFFEA5E25);
      default:
        return _wine;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _ejeColor;
    final metasAsync = ref.watch(metasPorEjeProvider(ejeNombre));

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          ejeNombre,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            Text(
              'Metas nacionales',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: _text,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Consulta las metas nacionales que forman parte del eje '
              '$ejeNombre.',
              style: TextStyle(
                fontSize: 15.5,
                height: 1.5,
                color: Colors.black.withValues(alpha: 0.62),
              ),
            ),
            const SizedBox(height: 26),
            
            metasAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'No fue posible cargar las metas.',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.60),
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (metas) {
                if (metas.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        'No hay metas registradas para este eje.',
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.60),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    for (final meta in metas)
                      _MetaCard(
                        codigo: meta.codigo,
                        nombre: meta.nombre,
                        color: color,
                        onTap: () {
                          context.push('/metas/${meta.codigo}');
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({
    required this.codigo,
    required this.nombre,
    required this.color,
    required this.onTap,
  });

  final String codigo;
  final String nombre;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    codigo,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meta Nacional $codigo',
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        nombre,
                        style: const TextStyle(
                          color:  Color(0xFF2E2E2E),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.black.withValues(alpha: 0.32),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}