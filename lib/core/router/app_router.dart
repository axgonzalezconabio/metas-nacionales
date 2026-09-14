import 'package:go_router/go_router.dart';
import 'package:metas_nacionales/features/busqueda/busqueda_page.dart';
import 'package:metas_nacionales/features/ejes/ejes_page.dart';
import 'package:metas_nacionales/features/home/home_page.dart';
import 'package:metas_nacionales/features/instituciones/instituciones_page.dart';
import 'package:metas_nacionales/features/metas/metas_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/ejes',
      builder: (context, state) => const EjesPage(),
    ),
    GoRoute(
      path: '/metas',
      builder: (context, state) => const MetasPage(),
    ),
    GoRoute(
      path: '/instituciones',
      builder: (context, state) => const InstitucionesPage(),
    ),
    GoRoute(
      path: '/buscar',
      builder: (context, state) => const BusquedaPage(),
    ),
  ],
);