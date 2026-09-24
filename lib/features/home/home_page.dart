import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color vino = Color(0xFF641C34);

  static const Color conservar = Color(0xFF94A65B);
  static const Color evitar = Color(0xFF7C1716);
  static const Color salvaguardar = Color(0xFF4A6E7D);
  static const Color actuar = Color(0xFFEA5E25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                vino: vino,
              ),
            ),

            // ---------------------------------------------------------
            // PRESENTACIÓN
            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Metas Nacionales de Biodiversidad',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF252525),
                            height: 1.1,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Marco Mundial de Biodiversidad '
                      'Kunming-Montreal en México',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            color: const Color(0xFF666666),
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Consulta las metas nacionales y la información '
                      'relacionada con su implementación.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: const Color(0xFF777777),
                            height: 1.45,
                          ),
                    ),
                    const SizedBox(height: 18),
                    const _SummaryRow(),
                  ],
                ),
              ),
            ),

            // ---------------------------------------------------------
            // BUSCADOR
            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                child: _SearchButton(
                  onTap: () => context.push('/buscar'),
                ),
              ),
            ),

            // ---------------------------------------------------------
            // EJES
            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: Text(
                  'Explora por eje',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF252525),
                      ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _AxisCard(
                      title: 'Conservar',
                      description:
                          'Conservación y restauración de la biodiversidad.',
                      color: conservar,
                      icon: Icons.eco_outlined,
                      onTap: () => context.push('/ejes/Conservar'),
                    ),
                    const SizedBox(height: 12),
                    _AxisCard(
                      title: 'Evitar',
                      description:
                          'Prevención y reducción de impactos sobre la biodiversidad.',
                      color: evitar,
                      icon: Icons.shield_outlined,
                      onTap: () => context.push('/ejes/Evitar'),
                    ),
                    const SizedBox(height: 12),
                    _AxisCard(
                      title: 'Salvaguardar',
                      description:
                          'Protección de la biodiversidad y sus beneficios.',
                      color: salvaguardar,
                      icon: Icons.water_drop_outlined,
                      onTap: () => context.push('/ejes/Salvaguardar'),
                    ),
                    const SizedBox(height: 12),
                    _AxisCard(
                      title: 'Actuar',
                      description:
                          'Acciones, capacidades y participación para la biodiversidad.',
                      color: actuar,
                      icon: Icons.auto_awesome_outlined,
                      onTap: () => context.push('/ejes/Actuar'),
                    ),
                  ],
                ),
              ),
            ),

            // ---------------------------------------------------------
            // ACCESOS SECUNDARIOS
            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Text(
                  'Consulta',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF252525),
                      ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: _SecondaryCard(
                        icon: Icons.flag_outlined,
                        title: 'Metas',
                        color: vino,
                        onTap: () => context.push('/metas'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SecondaryCard(
                        icon: Icons.account_balance_outlined,
                        title: 'Instituciones',
                        color: vino,
                        onTap: () => context.push('/instituciones'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------------------------------------------------------
            // PIE
            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Center(
                  child: Text(
                    'Metas Nacionales de Biodiversidad · México',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF999999),
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// RESUMEN
// =====================================================================

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _SummaryItem(
            value: '47',
            label: 'Metas nacionales',
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: _SummaryItem(
            value: '4',
            label: 'Ejes de acción',
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: _SummaryItem(
            value: '2030',
            label: 'Horizonte',
          ),
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE7E7E2),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF641C34),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF777777),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// HEADER
// =====================================================================

class _Header extends StatelessWidget {
  const _Header({
    required this.vino,
  });

  final Color vino;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      decoration: BoxDecoration(
        color: vino,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.eco,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biodiversidad',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Metas Nacionales · México',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
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

// =====================================================================
// BUSCADOR
// =====================================================================

class _SearchButton extends StatelessWidget {
  const _SearchButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE5E5E0),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xFF777777),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Buscar metas nacionales',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF777777),
                      ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Color(0xFF999999),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// TARJETA DE EJE
// =====================================================================

class _AxisCard extends StatelessWidget {
  const _AxisCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE7E7E2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF707070),
                            height: 1.35,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: color.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// TARJETAS SECUNDARIAS
// =====================================================================

class _SecondaryCard extends StatelessWidget {
  const _SecondaryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE7E7E2),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(height: 9),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF333333),
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}