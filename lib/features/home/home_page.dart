import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:metas_nacionales/core/providers/metas_nacionales_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const Color vino = Color(0xFFF2F3F1);

  static const Color conservar = Color(0xFF94A65B);

  static const Color evitar = Color(0xFF7C1716);

  static const Color salvaguardar = Color(0xFF4A6E7D);

  static const Color actuar = Color(0xFFEA5E25);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalHitosAsync = ref.watch(totalHitosProvider);

    final totalHitos = totalHitosAsync.when(
      data: (total) => total.toString(),

      loading: () => '...',

      error: (error, stack) => '—',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header(vino: vino)),

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
                      'Consulta las metas nacionales y la información '
                      'relacionada con su implementación.',

                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF777777),

                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _SummaryRow(totalHitos: totalHitos),
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

                child: _SearchButton(onTap: () => context.push('/buscar')),
              ),
            ),

            // ---------------------------------------------------------

            // PILARES

            // ---------------------------------------------------------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),

                child: Text(
                  'Explora por pilar',

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
                delegate: SliverChildListDelegate([
                  _PillarCard(
                    title: 'Conservar',

                    description:
                        'Conservación y restauración de la biodiversidad.',

                    color: conservar,

                    imagePath: 'assets/pilares/CONSERVAR.png',

                    onTap: () => context.push('/ejes/Conservar'),
                  ),

                  const SizedBox(height: 12),

                  _PillarCard(
                    title: 'Evitar',

                    description: 'Prevención y reducción de impactos sobre la biodiversidad.',

                    color: evitar,

                    imagePath: 'assets/pilares/EVITAR.png',

                    onTap: () => context.push('/ejes/Evitar'),
                  ),

                  const SizedBox(height: 12),

                  _PillarCard(
                    title: 'Salvaguardar',

                    description:
                        'Protección de la biodiversidad y sus beneficios.',

                    color: salvaguardar,

                    imagePath: 'assets/pilares/SALVAGUARDAR.png',

                    onTap: () => context.push('/ejes/Salvaguardar'),
                  ),

                  const SizedBox(height: 12),

                  _PillarCard(
                    title: 'Actuar',

                    description: 'Acciones, capacidades y participación para la biodiversidad.',

                    color: actuar,

                    imagePath: 'assets/pilares/ACTUAR.png',

                    onTap: () => context.push('/ejes/Actuar'),
                  ),
                ]),
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

            //------------
            // descarga
            //------
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                child: const _PdfDocumentCard(),
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
                    'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad (CONABIO). 2026. Estrategia Nacional sobre Biodiversidad de México (ENBioMex 2.0).  CONABIO, SEMARNAT, PNUD, GIZ, NBSAP-AP. México. ',

                    textAlign: TextAlign.center,

                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: const Color(0xFF999999)),
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
  const _SummaryRow({required this.totalHitos});

  final String totalHitos;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          const Expanded(
            child: _SummaryItem(value: '4', label: 'Pilares de acción'),
          ),

          Container(width: 1, height: 42, color: Color(0xFFE2E2DD)),

          const Expanded(
            child: _SummaryItem(value: '47', label: 'Metas nacionales'),
          ),

          Container(width: 1, height: 42, color: Color(0xFFE2E2DD)),

          Expanded(
            child: _SummaryItem(value: totalHitos, label: 'Hitos'),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF641C34),
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

// =====================================================================

// HEADER

// =====================================================================

class _Header extends StatelessWidget {
  const _Header({required this.vino});

  final Color vino;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F4),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE5E5E1), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Logo
          SizedBox(
            height: 105,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.eco_outlined, color: vino, size: 48);
              },
            ),
          ),

          const SizedBox(height: 10),

          // Título
          const Text(
            'Metas Nacionales',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF641C34),
              fontSize: 23,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 12),

          // Línea institucional
          Container(
            width: 48,
            height: 3,
            decoration: BoxDecoration(
              color: Color(0xFF641C34),
              borderRadius: BorderRadius.circular(10),
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
  const _SearchButton({required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: const Color(0xFFE5E5E0)),
          ),

          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFF777777)),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  'Buscar metas nacionales',

                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: const Color(0xFF777777)),
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

// TARJETA DE PILAR

// =====================================================================

class _PillarCard extends StatelessWidget {
  const _PillarCard({
    required this.title,
    required this.description,
    required this.color,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String description;
  final Color color;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.35),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              // Imagen del pilar
              Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.eco_outlined, color: color, size: 38);
                  },
                ),
              ),

              const SizedBox(width: 16),

              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Indicador de navegación
              Icon(Icons.arrow_forward_ios, color: color, size: 16),
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: const Color(0xFFE7E7E2)),
          ),

          child: Column(
            children: [
              Icon(icon, color: color, size: 28),

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

class _PdfDocumentCard extends StatelessWidget {
  const _PdfDocumentCard();

  @override
  Widget build(BuildContext context) {
    const vino = Color(0xFF641C34);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const _PdfViewerPage()));
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E1DD), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: vino.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: vino,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Documento ENBIOMEX 2.0',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Metas Nacionales · Consultar documento',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, color: vino, size: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _PdfViewerPage extends StatelessWidget {
  const _PdfViewerPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF641C34),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Metas Nacionales',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SfPdfViewer.asset('assets/documentos/metas_nacionales.pdf'),
    );
  }
}
