import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EjesPage extends StatelessWidget {
  const EjesPage({super.key});

  static const _background = Color(0xFFF6F5F1);
  static const _text = Color(0xFF252525);
  static const _wine = Color(0xFF641C34);

  static const _ejes = [
    _EjeData(
      nombre: 'Conservar',
      descripcion:
          'Conservar y restaurar la biodiversidad, los ecosistemas y sus servicios.',
      color: Color(0xFF94A65B),
      icon: Icons.forest_rounded,
    ),
    _EjeData(
      nombre: 'Evitar',
      descripcion:
          'Reducir las presiones y amenazas que afectan a la biodiversidad.',
      color: Color(0xFF7C1716),
      icon: Icons.shield_outlined,
    ),
    _EjeData(
      nombre: 'Salvaguardar',
      descripcion:
          'Fortalecer las condiciones para proteger la biodiversidad y el bienestar.',
      color: Color(0xFF4A6E7D),
      icon: Icons.eco_rounded,
    ),
    _EjeData(
      nombre: 'Actuar',
      descripcion:
          'Impulsar acciones, capacidades y mecanismos para alcanzar las metas.',
      color: Color(0xFFEA5E25),
      icon: Icons.groups_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _wine,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Ejes de acción',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuatro ejes de acción',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: _text,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Las metas nacionales se organizan en cuatro ejes '
                        'que permiten consultar los compromisos de México '
                        'para la implementación del Marco Mundial de '
                        'Biodiversidad Kunming-Montreal.',
                        style: TextStyle(
                          fontSize: 15.5,
                          height: 1.5,
                          color: Colors.black.withValues(alpha: 0.62),
                        ),
                      ),
                      const SizedBox(height: 28),

                      if (isWide)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _ejes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            childAspectRatio: 1.65,
                          ),
                          itemBuilder: (context, index) {
                            return _EjeCard(
                              eje: _ejes[index],
                              onTap: () {
                                context.push('/ejes/${_ejes[index].nombre}');
                              },
                            );
                          },
                        )
                      else
                        Column(
                          children: _ejes.map((eje) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _EjeCard(
                                eje: eje,
                                onTap: () {
                                  context.push('/ejes/${eje.nombre}');
                                },
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EjeCard extends StatelessWidget {
  const _EjeCard({
    required this.eje,
    required this.onTap,
  });

  final _EjeData eje;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: eje.color.withValues(alpha: 0.16),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -35,
                top: -35,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: eje.color.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: eje.color.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Icon(
                        eje.icon,
                        color: eje.color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            eje.nombre,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: eje.color,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            eje.descripcion,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Colors.black.withValues(alpha: 0.62),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 17,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
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

class _EjeData {
  const _EjeData({
    required this.nombre,
    required this.descripcion,
    required this.color,
    required this.icon,
  });

  final String nombre;
  final String descripcion;
  final Color color;
  final IconData icon;
}