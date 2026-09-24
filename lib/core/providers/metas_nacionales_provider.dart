import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:metas_nacionales/core/providers/database_provider.dart';
import 'package:metas_nacionales/data/database/app_database.dart';
import 'package:metas_nacionales/data/repositories/metas_nacionales_repository.dart';

final metasNacionalesRepositoryProvider =
    FutureProvider<MetasNacionalesRepository>((ref) async {
  final database = await ref.watch(
    databaseProvider.future,
  );

  return MetasNacionalesRepository(database);
});

final metasNacionalesProvider =
    FutureProvider((ref) async {
  final repository =
      await ref.watch(
        metasNacionalesRepositoryProvider.future,
      );

  return repository.obtenerMetasNacionales();
});

final metasNacionalesConEjeProvider =
    FutureProvider<List<MetaNacionalConEje>>(
  (ref) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerMetasNacionalesConEje();
  },
);

final metasPorEjeProvider =
    FutureProvider.family<List<MetasNacionale>, String>(
  (ref, ejeNombre) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerMetasPorEje(ejeNombre);
  },
);

final hitosPorMetaProvider =
    FutureProvider.family<List<Hito>, int>(
  (ref, metaNacionalId) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerHitosPorMetaNacional(
      metaNacionalId,
    );
  },
);

final subhitosPorHitoProvider =
    FutureProvider.family<List<Subhito>, int>(
  (ref, hitoId) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerSubhitosPorHito(
      hitoId,
    );
  },
);

final institucionesPorMetaProvider =
    FutureProvider.family<
        List<InstitucionParticipante>,
        int>(
  (ref, metaNacionalId) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository
        .obtenerInstitucionesPorMetaNacional(
      metaNacionalId,
    );
  },
);

final institucionesProvider =
    FutureProvider<List<InstitucionResumen>>(
  (ref) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerInstituciones();
  },
);

final institucionPorIdProvider =
    FutureProvider.family<Institucione?, int>(
  (ref, institucionId) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerInstitucionPorId(
      institucionId,
    );
  },
);

final metasPorInstitucionProvider =
    FutureProvider.family<
        List<InstitucionMetaParticipacion>,
        int>(
  (ref, institucionId) async {
    final repository =
        await ref.watch(
          metasNacionalesRepositoryProvider.future,
        );

    return repository.obtenerMetasPorInstitucion(
      institucionId,
    );
  },
);