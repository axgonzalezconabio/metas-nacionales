import 'package:go_router/go_router.dart';

import 'package:metas_nacionales/features/busqueda/busqueda_page.dart';
import 'package:metas_nacionales/features/ejes/eje_metas_page.dart';
import 'package:metas_nacionales/features/ejes/ejes_page.dart';
import 'package:metas_nacionales/features/home/home_page.dart';
import 'package:metas_nacionales/features/instituciones/instituciones_page.dart';
import 'package:metas_nacionales/features/instituciones/institucion_detail_page.dart';
import 'package:metas_nacionales/features/metas/meta_detail_page.dart';
import 'package:metas_nacionales/features/metas/metas_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const HomePage(),
    ),
    GoRoute(
      path: '/ejes',
      builder: (context, state) =>
          const EjesPage(),
    ),
    GoRoute(
      path: '/ejes/:ejeNombre',
      builder: (context, state) {
        final ejeNombre =
            state.pathParameters['ejeNombre']!;

        return EjeMetasPage(
          ejeNombre: ejeNombre,
        );
      },
    ),
    GoRoute(
      path: '/metas',
      builder: (context, state) =>
          const MetasPage(),
    ),
    GoRoute(
      path: '/metas/:codigo',
      builder: (context, state) {
        final codigo =
            state.pathParameters['codigo']!;

        return MetaDetailPage(
          codigo: codigo,
        );
      },
    ),
    GoRoute(
      path: '/instituciones',
      builder: (context, state) =>
          const InstitucionesPage(),
    ),
    GoRoute(
      path: '/instituciones/:id',
      builder: (context, state) {
        final id = int.parse(
          state.pathParameters['id']!,
        );

        return InstitucionDetailPage(
          id: id,
        );
      },
    ),
    GoRoute(
      path: '/buscar',
      builder: (context, state) =>
          const BusquedaPage(),
    ),
  ],
);