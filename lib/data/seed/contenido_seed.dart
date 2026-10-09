import 'package:drift/drift.dart';

import '../database/app_database.dart';

/// Carga el catálogo inicial de la Guía Rápida 2026.
///
/// Fuente única de contenido:
/// CONABIO, "Metas Nacionales para la implementación del Marco Mundial
/// de Biodiversidad Kunming-Montreal en México", primera edición, 2026.
///
/// Los textos descriptivos de metas, hitos y subhitos se transcriben de la
/// Guía oficial, respetando su redacción y terminología.
class ContenidoSeed {
  static const _documento =
      'Metas Nacionales para la implementación del Marco Mundial de Biodiversidad Kunming-Montreal en México';

  static Future<void> cargar(AppDatabase database) async {
    await database.transaction(() async {
      final publicacionId = await database
          .into(database.publicaciones)
          .insert(
            PublicacionesCompanion.insert(
              nombre: _documento,
              edicion: const Value('Primera edición'),
              anio: const Value(2026),
              descripcion: const Value(
                'Guía Rápida de las 47 Metas Nacionales de México para la implementación del Marco Mundial de Biodiversidad Kunming-Montreal.',
              ),
            ),
          );

      final ejeIds = <String, int>{};
      final metaGlobalIds = <String, int>{};
      final metaNacionalIds = <String, int>{};  

      Future<int> insertarEje({
        required String nombre,
        required int orden,
      }) async {
        final id = await database
            .into(database.ejes)
            .insert(
              EjesCompanion.insert(
                nombre: nombre,
                descripcion: Value(nombre),
                publicacionId: publicacionId,
                orden: orden,
              ),
            );
        ejeIds[nombre] = id;
        return id;
      }

      Future<int> insertarMetaGlobal({
        required String codigo,
        required String nombre,
        required String descripcion,
        required String eje,
        required int orden,
      }) async {
        final id = await database
            .into(database.metasGlobales)
            .insert(
              MetasGlobalesCompanion.insert(
                codigo: codigo,
                nombre: nombre,
                descripcion: Value(descripcion),
                ejeId: ejeIds[eje]!,
                orden: orden,
              ),
            );
        metaGlobalIds[codigo] = id;
        return id;
      }

      Future<int> insertarMetaNacional({
        required String codigo,
        required String nombre,
        required String eje,
        required String metaGlobal,
        required int orden,
        String? descripcion,
      }) async {
        final id = await database
            .into(database.metasNacionales)
            .insert(
              MetasNacionalesCompanion.insert(
                codigo: codigo,
                nombre: nombre,
                descripcion: Value(descripcion ?? nombre),
                ejeId: ejeIds[eje]!,
                metaGlobalId: metaGlobalIds[metaGlobal]!,
                publicacionId: publicacionId,
                referenciaOrigenId: const Value(null),
                orden: orden,
              ),
            );
        metaNacionalIds[codigo] = id;
        return id;
      }

      Future<int> insertarReferencia({
        required int pagina,
        required String seccion,
        String? observacion,
      }) {
        return database
            .into(database.referenciasOrigen)
            .insert(
              ReferenciasOrigenCompanion.insert(
                documento: _documento,
                edicion: const Value('Primera edición'),
                anio: const Value(2026),
                pagina: Value(pagina),
                seccion: Value(seccion),
                observacion: Value(observacion),
              ),
            );
      }

      Future<void> insertarHito({
        required String codigo,
        required String metaNacional,
        required String descripcion,
        required int orden,
        required int referenciaOrigenId,
        String? periodo,
      }) async {
        await database
            .into(database.hitos)
            .insert(
              HitosCompanion.insert(
                codigo: codigo,
                nombre: const Value(null),
                descripcion: Value(descripcion),
                metaNacionalId: metaNacionalIds[metaNacional]!,
                orden: orden,
                anio: const Value(null),
                periodo: Value(periodo),
                referenciaOrigenId: referenciaOrigenId,
              ),
            );
      }

      Future<void> insertarSubhito({
        required String codigo,
        required String hito,
        required String descripcion,
        required int orden,
        int? referenciaOrigenId,
      }) async {
        await database
            .into(database.subhitos)
            .insert(
              SubhitosCompanion.insert(
                codigo: Value(codigo),
                descripcion: descripcion,
                hitoId: (await (database.select(
                  database.hitos,
                )..where((tbl) => tbl.codigo.equals(hito))).getSingle()).id,
                orden: orden,
                referenciaOrigenId: Value(referenciaOrigenId),
              ),
            );
      }

      // -------------------------------------------------------------------
      // EJES
      // -------------------------------------------------------------------
      await insertarEje(nombre: 'Conservar', orden: 1);
      await insertarEje(nombre: 'Evitar', orden: 2);
      await insertarEje(nombre: 'Salvaguardar', orden: 3);
      await insertarEje(nombre: 'Actuar', orden: 4);

      // -------------------------------------------------------------------
      // 23 METAS GLOBALES
      //
      // Las descripciones corresponden al texto de las Metas Globales
      // presentado en la Guía oficial (primera edición, 2026).
      //
      // En la base de datos se normalizan los códigos como 1.0…23.0
      // para diferenciarlos de las Metas Nacionales (1.1, 1.2, etc.).
      // -------------------------------------------------------------------
      const metasGlobales = <String, Map<String, String>>{
        '1': {
          'nombre': 'Planificación espacial',
          'descripcion':
              'Garantizar que todas las zonas estén sujetas a planificación espacial participativa integrada que tenga en cuenta la biodiversidad y/o procesos de gestión eficaces que aborden el cambio en el uso de la tierra y los océanos, a fin de que la pérdida de zonas de suma importancia para la biodiversidad, incluidos los ecosistemas de gran integridad ecológica, se acerque a cero para 2030, respetando al mismo tiempo los derechos de los pueblos indígenas y las comunidades locales.',
          'eje': 'Conservar',
        },
        '2': {
          'nombre': 'Restauración de ecosistemas',
          'descripcion':
              'Garantizar que para 2030 al menos un 30 % de las zonas de ecosistemas terrestres, de aguas continentales y costeros y marinos degradados estén siendo objeto de una restauración efectiva, con el fin de mejorar la biodiversidad y las funciones y los servicios de los ecosistemas y la integridad y conectividad ecológicas.',
          'eje': 'Conservar',
        },
        '3': {
          'nombre': 'Conservación de áreas',
          'descripcion':
              'Garantizar y hacer posible que, para 2030, al menos un 30 % de las zonas terrestres y de aguas continentales y de las zonas marinas y costeras, especialmente las zonas de particular importancia para la biodiversidad y las funciones y los servicios de los ecosistemas, se conserven y gestionen eficazmente mediante sistemas de áreas protegidas ecológicamente representativos, bien conectados y gobernados equitativamente y otras medidas de conservación eficaces basadas en áreas, reconociendo, cuando proceda, los territorios indígenas y tradicionales, y que estén integradas a los paisajes terrestres, marinos y oceánicos más amplios, garantizando al mismo tiempo que toda utilización sostenible, cuando proceda en dichas zonas, sea plenamente coherente con la obtención de resultados de conservación, reconociendo y respetando los derechos de los pueblos indígenas y las comunidades locales, incluidos aquellos relativos a sus territorios tradicionales.',
          'eje': 'Conservar',
        },
        '4': {
          'nombre': 'Detener la extinción de especies',
          'descripcion':
              'Garantizar que se adopten con urgencia medidas de gestión para detener la extinción de especies amenazadas conocidas y para la recuperación y conservación de las especies, en particular, las especies amenazadas, a fin de reducir significativamente el riesgo de extinción, así como de mantener y restaurar la diversidad genética entre las poblaciones de especies autóctonas, silvestres y domesticadas y dentro de ellas a fin de preservar su potencial de adaptación, entre otras cosas, mediante prácticas sostenibles de gestión y conservación in situ y ex situ, y gestionar eficazmente las interacciones entre los seres humanos y la fauna y flora silvestres, con miras a reducir al mínimo los conflictos entre los seres humanos y las especies silvestres en favor de la coexistencia.',
          'eje': 'Conservar',
        },
        '5': {
          'nombre': 'Uso y comercio de especies',
          'descripcion':
              'Garantizar que el uso, la recolección y el comercio de especies silvestres sea sostenible, seguro y lícito, previniendo la sobreexplotación, minimizando los impactos sobre las especies no buscadas y los ecosistemas, y reduciendo el riesgo de propagación de patógenos, aplicando el enfoque por ecosistemas, al tiempo que se respeta y protege la utilización consuetudinaria sostenible por los pueblos indígenas y las comunidades locales.',
          'eje': 'Evitar',
        },
        '6': {
          'nombre': 'Reducción de especies exóticas invasoras (EEI)',
          'descripcion':
              'Eliminar, minimizar o reducir las especies exóticas invasoras o mitigar sus impactos en la biodiversidad y los servicios de los ecosistemas mediante la detección y la gestión de las vías de introducción de las especies exóticas, previniendo la introducción y el establecimiento de especies exóticas invasoras prioritarias, reduciendo las tasas de introducción y establecimiento de otras especies exóticas invasoras conocidas o potenciales en al menos un 50% para 2030, y erradicando o controlando las especies exóticas invasoras, en especial en lugares prioritarios, como las islas.',
          'eje': 'Evitar',
        },
        '7': {
          'nombre': 'Reducción de la contaminación',
          'descripcion':
              'Reducir para 2030 los riesgos de contaminación y el impacto negativo de la contaminación de todas las fuentes a niveles que no sean perjudiciales para la diversidad biológica y las funciones y los servicios de los ecosistemas, considerando los efectos acumulativos, entre otras cosas: a) reduciendo al menos a la mitad el exceso de nutrientes que se liberan al medio ambiente, como por ejemplo mediante un ciclo y un uso más eficientes de los nutrientes; b) reduciendo el riesgo general de los plaguicidas y las sustancias químicas altamente peligrosas al menos a la mitad, incluido mediante la gestión integrada de plagas, basándose en la ciencia, teniendo en cuenta la seguridad alimentaria y los medios de vida; y c) previniendo, reduciendo y procurando eliminar la contaminación por plástico.',
          'eje': 'Evitar',
        },
        '8': {
          'nombre': 'Reducción de los impactos del cambio climático',
          'descripcion':
              'Minimizar el impacto del cambio climático y la acidificación de los océanos en la biodiversidad, y aumentar su resiliencia mediante medidas de mitigación, adaptación y reducción del riesgo de desastres, entre otras cosas por medio de soluciones basadas en la naturaleza y/o enfoques basados en los ecosistemas, al tiempo que se minimizan los impactos negativos y se fomentan los impactos positivos de la acción por el clima en la biodiversidad.',
          'eje': 'Evitar',
        },
        '9': {
          'nombre': 'Gestión sustentable de especies silvestres',
          'descripcion':
              'Garantizar que la gestión y el uso de especies silvestres sean sostenibles, proporcionando así beneficios sociales, económicos y ambientales para las personas, en especial aquellas que se encuentran en situaciones de vulnerabilidad y aquellas que más dependen de la biodiversidad, entre otras cosas, mediante actividades, productos y servicios sostenibles basados en la biodiversidad que la fortalezcan, y mediante la protección y promoción de la utilización consuetudinaria sostenible por los pueblos indígenas y las comunidades locales.',
          'eje': 'Salvaguardar',
        },
        '10': {
          'nombre': 'Integración de la biodiversidad en los sectores productivos',
          'descripcion':
              'Garantizar que las superficies dedicadas a la agricultura, la acuicultura, la pesca y la silvicultura se gestionen de manera sostenible, en particular a través de la utilización sostenible de la diversidad biológica, entre otras cosas, mediante un aumento sustancial del empleo de prácticas favorables a la diversidad biológica, tales como enfoques de intensificación sostenible, enfoques agroecológicos y otros enfoques innovadores, contribuyendo a la resiliencia y a la eficiencia y productividad a largo plazo de estos sistemas de producción y a la seguridad alimentaria, conservando y restaurando la diversidad biológica y manteniendo las contribuciones de la naturaleza a las personas, entre ellas las funciones y los servicios de los ecosistemas.',
          'eje': 'Salvaguardar',
        },
        '11': {
          'nombre': 'Contribuciones de la naturaleza',
          'descripcion':
              'Restaurar, mantener y mejorar las contribuciones de la naturaleza a las personas, entre ellas las funciones y los servicios de los ecosistemas, tales como la regulación del aire, el agua y el clima, la salud de los suelos, la polinización y la reducción del riesgo de enfermedades, así como la protección frente a peligros y desastres naturales, mediante soluciones basadas en la naturaleza y/o enfoques basados en los ecosistemas en beneficio de todas las personas y la naturaleza.',
          'eje': 'Salvaguardar',
        },
        '12': {
          'nombre': 'Mejora de espacios verdes y azules en zonas urbanas',
          'descripcion':
              'Aumentar significativamente la superficie, la calidad y la conectividad de los espacios verdes y azules en las zonas urbanas y densamente pobladas, así como el acceso a ellos y los beneficios que se deriven de ellos, de manera sostenible, integrando la conservación y la utilización sostenible de la diversidad biológica, y garantizar una planificación urbana que tenga en cuenta la diversidad biológica, mejorando la diversidad biológica autóctona, la conectividad y la integridad ecológicas y mejorando la salud y el bienestar de los seres humanos y su conexión con la naturaleza, así como contribuyendo a una urbanización inclusiva y sostenible y a la prestación de funciones y servicios de los ecosistemas.',
          'eje': 'Salvaguardar',
        },
        '13': {
          'nombre': 'Beneficios de los recursos genéticos',
          'descripcion':
              'Tomar medidas jurídicas, de políticas, administrativas y de creación de capacidad a todos los niveles, según proceda, con miras a lograr la participación justa y equitativa en los beneficios que se deriven de la utilización de los recursos genéticos y de la información digital sobre secuencias de recursos genéticos, así como de los conocimientos tradicionales asociados a los recursos genéticos, y a lograr que para 2030 se haya propiciado un aumento significativo de los beneficios compartidos, de conformidad con los instrumentos internacionales de acceso y participación en los beneficios aplicables.',
          'eje': 'Salvaguardar',
        },
        '14': {
          'nombre': 'Integrar la biodiversidad en la toma de decisiones',
          'descripcion':
              'Garantizar la integración plena de la biodiversidad y sus múltiples valores en las políticas, los reglamentos, los procesos de planificación y de desarrollo, las estrategias de erradicación de la pobreza, las evaluaciones ambientales estratégicas y las evaluaciones de impacto ambiental y, cuando proceda, las cuentas nacionales, en todos los niveles de gobierno y todos los sectores, en particular aquellos que provocan impactos significativos en la biodiversidad, armonizando progresivamente todas las actividades públicas y privadas pertinentes y las corrientes financieras y fiscales con los objetivos y las metas del presente Marco.',
          'eje': 'Actuar',
        },
        '15': {
          'nombre': 'Responsabilidad empresarial y financiera en la biodiversidad',
          'descripcion':
              'Tomar medidas jurídicas, administrativas o de políticas para alentar y habilitar a las empresas para que, y en particular, en el caso de las empresas transnacionales y las instituciones financieras, garantizar que: a) Hagan periódicamente un seguimiento y una evaluación de sus riesgos, dependencias de la biodiversidad e impactos en ella, y los den a conocer de manera transparente, incluido, en el caso de las grandes empresas y las empresas transnacionales e instituciones financieras, mediante el establecimiento de requisitos a lo largo de sus operaciones, cadenas de suministro y de valor y carteras; b) Proporcionen la información necesaria a los consumidores a fin de promover modalidades de consumo sostenibles; c) Informen sobre el cumplimiento de los reglamentos y medidas de acceso y participación en los beneficios, según proceda; con el fin de reducir progresivamente los impactos negativos en la biodiversidad, aumentar los impactos positivos, reducir los riesgos relacionados con la biodiversidad para las empresas y las instituciones financieras, y promover acciones encaminadas a lograr modalidades de producción sostenibles.',
          'eje': 'Actuar',
        },
        '16': {
          'nombre': 'Consumo sustentable',
          'descripcion':
              'Garantizar que se aliente y apoye a las personas para que elijan opciones de consumo sostenible, entre otras cosas mediante el establecimiento de marcos de políticas, legislativos o normativos de apoyo, mejorando la enseñanza y el acceso a información pertinente y precisa y alternativas, y, para 2030, reducir la huella mundial del consumo de manera equitativa, entre otras cosas reduciendo a la mitad el desperdicio mundial de alimentos, reduciendo significativamente el consumo excesivo, y reduciendo sustancialmente la generación de desechos, a fin de que todas las personas puedan vivir bien en armonía con la Madre Tierra.',
          'eje': 'Actuar',
        },
        '17': {
          'nombre': 'Fortalecimiento de la bioseguridad',
          'descripcion':
              'En todos los países, establecer y aplicar medidas de seguridad de la biotecnología, y reforzar la capacidad al respecto, tal como se establece en el artículo 8 g) del Convenio sobre la Diversidad Biológica, y medidas para la gestión de la biotecnología y la distribución de sus beneficios, tal como se establece en el artículo 19 del Convenio.',
          'eje': 'Actuar',
        },
        '18': {
          'nombre': 'Incentivos y subsidios',
          'descripcion':
              'Identificar para 2025 y eliminar gradualmente o reformar los incentivos, entre ellos los subsidios, perjudiciales para la diversidad biológica, de manera proporcionada, justa, efectiva y equitativa, reduciéndolos sustancial y progresivamente en al menos 500 000 millones de dólares de los Estados Unidos al año para 2030, empezando por los incentivos más perjudiciales, y aumentar los incentivos positivos para la conservación y la utilización sostenible de la diversidad biológica.',
          'eje': 'Actuar',
        },
        '19': {
          'nombre': 'Financiamiento para la biodiversidad',
          'descripcion':
              'Aumentar sustancial y progresivamente, de manera eficaz, oportuna y de fácil acceso, el nivel de recursos financieros de todas las fuentes, entre ellos los recursos nacionales, internacionales, públicos y privados, de conformidad con el artículo 20 del Convenio, a fin de implementar las estrategias y planes de acción nacionales en materia de biodiversidad, movilizando al menos 200 000 millones de dólares de los Estados Unidos al año para 2030, entre otras cosas: a) Aumentando el total de recursos financieros internacionales relacionados con la biodiversidad procedentes de los países desarrollados, incluida la asistencia oficial para el desarrollo, y de los países que asuman voluntariamente las obligaciones de las Partes que son países desarrollados, para los países en desarrollo, en particular, los países menos adelantados y los pequeños Estados insulares en desarrollo, así como los países con economías en transición, al menos a 20 000 millones de dólares de los Estados Unidos al año para 2025 y al menos a 30 000 millones de dólares al año para 2030; b) Aumentando significativamente la movilización de recursos nacionales, facilitada mediante la preparación y aplicación de planes nacionales de financiación de la biodiversidad o instrumentos similares de acuerdo con las necesidades, prioridades y circunstancias nacionales; c) Apalancando la financiación privada, promoviendo la financiación combinada, aplicando estrategias de obtención de recursos nuevos y adicionales, y alentando al sector privado a invertir en la biodiversidad, entre otras cosas, mediante fondos de impacto y otros instrumentos; d) Estimulando planes innovadores, como pagos por los servicios de los ecosistemas, bonos verdes, compensaciones y créditos de biodiversidad y mecanismos de participación en los beneficios, con salvaguardias ambientales y sociales; e) Optimizando los beneficios secundarios y las sinergias de la financiación destinada a atender las crisis de la biodiversidad y del clima; f) Reforzando el papel de las acciones colectivas, entre ellas las de los pueblos indígenas y las comunidades locales, las acciones centradas en la Madre Tierra y los enfoques no relacionados con el mercado, incluida la gestión comunitaria de los recursos naturales y la cooperación y solidaridad de la sociedad civil dirigidas a la conservación de la diversidad biológica; g) Reforzando la eficacia, eficiencia y transparencia de la provisión y utilización de los recursos.',
          'eje': 'Actuar',
        },
        '20': {
          'nombre': 'Fortalecimiento de capacidades y cooperación',
          'descripcion':
              'Fortalecer la creación y el desarrollo de capacidad, así como el acceso a tecnología y transferencia de tecnología, y promover el desarrollo y el acceso a la innovación y la cooperación científica y técnica, incluido a través de la cooperación Sur-Sur, Norte-Sur y triangular, para satisfacer las necesidades de una implementación eficaz, en particular en los países en desarrollo, promoviendo el desarrollo conjunto de tecnología y programas conjuntos de investigación científica para la conservación y la utilización sostenible de la diversidad biológica y el fortalecimiento de las capacidades de investigación científica y de seguimiento, en forma acorde con el nivel de ambición de los objetivos y las metas del Marco.',
          'eje': 'Actuar',
        },
        '21': {
          'nombre': 'Acceso al conocimiento',
          'descripcion':
              'Lograr que los mejores datos, información y conocimientos estén disponibles a los encargados de la toma de decisiones, los profesionales y el público, para que guíen una gobernanza eficaz y equitativa, una gestión integrada y participativa de la diversidad biológica, y para mejorar la comunicación, la concienciación, la educación, la investigación y la gestión de los conocimientos, y también en el contexto de que solo se disponga de los conocimientos tradicionales, las innovaciones, las prácticas y las tecnologías de los pueblos indígenas y las comunidades locales con su consentimiento libre, previo e informado, de conformidad con la legislación nacional.',
          'eje': 'Actuar',
        },
        '22': {
          'nombre': 'Participación social en la toma de decisiones',
          'descripcion':
              'Garantizar la participación y representación plena, equitativa, inclusiva, efectiva y con perspectiva de género de los pueblos indígenas y las comunidades locales en la toma de decisiones, y su acceso a la justicia y a información en materia de biodiversidad, respetando sus culturas y sus derechos sobre las tierras, los territorios, los recursos y los conocimientos tradicionales, así como de las mujeres y las niñas, la infancia y la juventud y las personas con discapacidad, y garantizar la protección plena de los defensores y las defensoras de los derechos humanos relacionados con el medio ambiente.',
          'eje': 'Actuar',
        },
        '23': {
          'nombre': 'Igualdad de género al aplicar el Marco',
          'descripcion':
              'Garantizar la igualdad de género en la implementación del Marco mediante un enfoque con perspectiva de género en el cual todas las mujeres y las niñas tengan igualdad de oportunidades y capacidad para contribuir a los tres objetivos del Convenio, entre otras cosas reconociendo su igualdad en cuanto a los derechos y el acceso a las tierras y a los recursos naturales y su participación y liderazgo plenos, equitativos, significativos e informados en todos los niveles de acción, participación, formulación de políticas y toma de decisiones relacionados con la biodiversidad.',
          'eje': 'Actuar',
        },
      };

      for (var i = 1; i <= 23; i++) {
        final codigo = i.toString();
        final metaGlobal = metasGlobales[codigo]!;
        await insertarMetaGlobal(
          codigo: codigo,
          nombre: metaGlobal['nombre']!,
          descripcion: metaGlobal['descripcion']!,
          eje: metaGlobal['eje']!,
          orden: i,
        );
      }

      // -------------------------------------------------------------------
      // 47 METAS NACIONALES
      // Los códigos, denominaciones y descripciones se transcriben de la Guía oficial.
      // -------------------------------------------------------------------
      const metasNacionales = <String, Map<String, String>>{
        '1.1': {
          'nombre': "Ordenamientos ecológicos, territoriales, turísticos y de desarrollo urbano",
          'descripcion': "Para 2030, 80% de las entidades del país cuentan con instrumentos de planeación ecológica, territorial, de desarrollo urbano y turístico, los cuales son decretados mediante procesos de planeación espacial adaptativa, participativa, transparente y armonizada, considerando criterios de conservación, manejo sustentable de la biodiversidad, del patrimonio biocultural, bajo principios de igualdad y equidad.",
          'eje': 'Conservar',
          'global': '1',
        },
        '1.2': {
          'nombre': "Ordenamiento ecológico marino",
          'descripcion': "Al 2027, 100% de las zonas marinas mexicanas y sus zonas federales adyacentes cuentan con Programas de Ordenamiento Ecológico Marino en ejecución que se monitorean y evalúan para su actualización y mejora.",
          'eje': 'Conservar',
          'global': '1',
        },
        '1.3': {
          'nombre': "Gestión sustentable de mares y costas",
          'descripcion': "Al 2030, México implementa el manejo integrado del territorio marítimo mexicano mediante la ejecución de la Política Nacional para el Manejo Sustentable de Mares y Costas de México (PNMSMCM) actualizada.",
          'eje': 'Conservar',
          'global': '1',
        },
        '1.4': {
          'nombre': "Tasa de cero deforestación neta",
          'descripcion':
              "Para 2030, en México se logra una tasa de 0% deforestación neta.",
          'eje': 'Conservar',
          'global': '1',
        },
        '2.1': {
          'nombre': "Restauración de ecosistemas terrestres degradados",
          'descripcion': "Al 2030, la restauración ambiental se ha convertido en una política pública prioritaria.",
          'eje': 'Conservar',
          'global': '2',
        },
        '2.2': {
          'nombre':
              "Restauración de ecosistemas acuáticos continentales degradados",
          'descripcion': "Para 2030, se mejora la integridad ecológica del 30% de los cuerpos de agua continentales.",
          'eje': 'Conservar',
          'global': '2',
        },
        '2.3': {
          'nombre': "Restauración de ecosistemas marinos y costeros degradados",
          'descripcion': "Al 2030, al menos 30% de la superficie de los ecosistemas marinos y costeros degradados, se encuentran en proceso de restauración efectiva y de uso sostenible, tomando en cuenta escenarios de cambio climático.",
          'eje': 'Conservar',
          'global': '2',
        },
        '3.1': {
          'nombre': "Incremento de la superficie de áreas naturales protegidas",
          'descripcion': "Para 2030, México incrementa 30% la superficie terrestre protegida y 30% la superficie marina, de manera efectiva a través de los sistemas de áreas naturales protegidas (ANP) federales, estatales y municipales.",
          'eje': 'Conservar',
          'global': '3',
        },
        '3.2': {
          'nombre': "Establecimiento del sistema nacional de otras medidas efectivas de conservación basadas en áreas",
          'descripcion': "Para 2030, se implementa el sistema nacional de reconocimiento, registro, monitoreo, evaluación y reporte de otras medidas efectivas de conservación basadas en áreas (OMEC).",
          'eje': 'Conservar',
          'global': '3',
        },
        '4.0': {
          'nombre': "Reducción del riesgo para especies en peligro de extinción y amenazadas",
          'descripcion': "Para 2030, México adopta y fortalece medidas de gestión para la recuperación y conservación de las especies silvestres en peligro de extinción y amenazadas según la NOM-059-SEMARNAT-2010, incluidas las poblaciones que se encuentran bajo manejo, y establece e implementa acciones de conservación y monitoreo de la diversidad genética asociada a especies importantes para la agrobiodiversidad.",
          'eje': 'Conservar',
          'global': '4',
        },
        '5.0': {
          'nombre': "Uso y comercio sustentables de especies silvestres",
          'descripcion':
              "Al 2030 se cuenta con los mecanismos robustos y armonizados para conducir la sustentabilidad, legalidad, trazabilidad y seguridad de las actividades extractivas y de comercio de la vida silvestre.",
          'eje': 'Evitar',
          'global': '5',
        },
        '6.1': {
          'nombre': "Prevención y reducción de la introducción de especies exóticas invasoras",
          'descripcion': "Al 2030, México cuenta con programas, herramientas e instrumentos para prevenir y reducir la introducción de especies exóticas invasoras (EEI) en las principales rutas de introducción asociadas a las actividades humanas.",
          'eje': 'Evitar',
          'global': '6',
        },
        '6.2': {
          'nombre': "Gestión de especies exóticas invasoras en áreas naturales protegidas insulares",
          'descripcion': "Para 2030, México implementa acciones para la prevención, manejo, control y erradicación de poblaciones de especies exóticas invasoras (EEI) que amenazan la integridad de los ecosistemas en las áreas naturales protegidas (ANP) insulares.",
          'eje': 'Evitar',
          'global': '6',
        },
        '6.3': {
          'nombre': "Gestión de especies exóticas invasoras en áreas naturales protegidas continentales",
          'descripcion': "Para 2030, México implementa acciones de prevención, manejo, control y erradicación de especies exóticas invasoras (EEI) en áreas naturales protegidas (ANP) continentales.",
          'eje': 'Evitar',
          'global': '6',
        },
        '7.1': {
          'nombre': "Reducción de la contaminación de agua",
          'descripcion': "Para 2030, se mejora la calidad de cuerpos de agua epicontinentales bajo estrategias efectivas de monitoreo, prevención, control y reducción de contaminantes, incluidos tres ríos de interés: Tula, Lerma-Santiago y Atoyac.",
          'eje': 'Evitar',
          'global': '7',
        },
        '7.2': {
          'nombre': "Reducción de la contaminación del suelo",
          'descripcion': "Para 2030, México optimiza la gestión del uso de Plaguicidas Altamente Peligrosos (PAP) para contribuir a reducir la contaminación del suelo.",
          'eje': 'Evitar',
          'global': '7',
        },
        '7.3': {
          'nombre': "Reducción de la contaminación del aire mediante la disminución del consumo de HFC",
          'descripcion': "Reducir el consumo de hidrofluorocarbonos (HFC) en un 10% para 2030, a través de la implementación del Plan de reducción gradual del consumo nacional de HFC, a fin de disminuir los efectos del cambio climático y contribuir a protección de la biosfera, la biodiversidad, los ecosistemas y los ciclos globales, en el marco de la implementación del Protocolo de Montreal en México.",
          'eje': 'Evitar',
          'global': '7',
        },
        '7.4': {
          'nombre': "Reducción de la contaminación del aire mediante la eliminación del consumo de HCFC",
          'descripcion': "Para 2030, se elimina 100% del consumo de hidroclorofluorocarbonos (HCFC), bajo los siguientes consumos máximos permitidos para estas sustancias, por año en toneladas PAO (tPAO): 209.20 en 2025 y 2026, 190.90 en 2027, 135.70 en 2028, 123.40 en 2029 y 0 en 2030.",
          'eje': 'Evitar',
          'global': '7',
        },
        '7.5': {
          'nombre': "Reducción de la contaminación marina y costera",
          'descripcion': "Para 2030, se refuerzan las políticas, programas y medidas para el monitoreo, vigilancia, prevención, control y mitigación de la contaminación de ambientes marino-costeros de México.",
          'eje': 'Evitar',
          'global': '7',
        },
        '8.1': {
          'nombre': "Adaptación al cambio climático",
          'descripcion': "Para 2030, se adoptan iniciativas y medidas sectoriales e intersectoriales encaminadas a reducir la vulnerabilidad o el riesgo sobre la biodiversidad y los socioecosistemas ante los efectos del cambio climático, mediante acciones coordinadas y transversales adoptando enfoques como: Soluciones basadas en la Naturaleza (SbN), Adaptación basada en Ecosistemas (AbE), complementados con Adaptación basada en Comunidades (AbC) y Adaptación basada en la Reducción del Riesgo de Desastres (AbRRD).",
          'eje': 'Evitar',
          'global': '8',
        },
        '8.2': {
          'nombre': "Mitigación de gases y compuestos de efecto invernadero",
          'descripcion': "Para 2030, se refuerzan los programas, mecanismos y acciones que contribuyen a la mitigación de gases y compuestos de efecto invernadero y/o su monitoreo, incluyendo acciones que fomentan la reducción o evitación del cambio de uso del suelo -principalmente, la deforestación- y la protección e incremento de los reservorios de carbono.",
          'eje': 'Evitar',
          'global': '8',
        },
        '9.0': {
          'nombre': "Impulso a cadenas de valor sustentables basadas en especies silvestres nativas",
          'descripcion': "Se identifican y fortalecen al menos 10 redes o cadenas de valor sustentables de especies silvestres nativas, incrementando los beneficios de los productores rurales con prioridad en uno o más de los siguientes criterios: los pueblos indígenas, comunidades locales y afromexicanas (PICLA), con alto nivel de marginación o con perspectiva de género e intergeneracional.",
          'eje': 'Salvaguardar',
          'global': '9',
        },
        '10.1': {
          'nombre': "Fomento de la agricultura sustentable",
          'descripcion': "Para 2030, se incrementan las unidades de producción que implementan prácticas agrícolas sustentables para la biodiversidad.",
          'eje': 'Salvaguardar',
          'global': '10',
        },
        '10.2': {
          'nombre': "Fomento de la ganadería sustentable",
          'descripcion': "Para 2030, se incrementan las Unidades de Producción Pecuaria (UPP) que implementan prácticas ganaderas sustentables para la biodiversidad.",
          'eje': 'Salvaguardar',
          'global': '10',
        },
        '10.3': {
          'nombre': "Fomento de la acuacultura sustentable",
          'descripcion': "Para 2030, se incrementa el número de cuerpos de agua en los que se realizan actividades acuícolas que cuentan con los instrumentos para ser manejados sustentablemente.",
          'eje': 'Salvaguardar',
          'global': '10',
        },
        '10.4': {
          'nombre': "Fomento de la pesca sustentable",
          'descripcion': "Para 2030, México cuenta con instrumentos y herramientas de manejo sólidas que promueven la sustentabilidad de las pesquerías en todas las regiones del territorio nacional.",
          'eje': 'Salvaguardar',
          'global': '10',
        },
        '10.5': {
          'nombre': "Incremento de la superficie de manejo sustentable de silvicultura",
          'descripcion': "Para 2030, se incrementará 30% de la superficie al manejo forestal sustentable (maderable y no maderable).",
          'eje': 'Salvaguardar',
          'global': '10',
        },
        '11.0': {
          'nombre': "Mantenimiento y mejora de los servicios ecosistémicos",
          'descripcion': "Para 2030, en México se desarrollan y fortalecen los mecanismos de generación de información y los instrumentos de política pública dirigidos a la conservación, uso sustentable y recuperación de los ecosistemas, de tal manera que se mantiene su cobertura, calidad y función, así como los servicios que proveen.",
          'eje': 'Salvaguardar',
          'global': '11',
        },
        '12.0': {
          'nombre': "Implementación de criterios y lineamientos para espacios verdes y azules en zonas urbanas",
          'descripcion': "Al 2030, se implementan criterios y lineamientos para la gestión armonizada del territorio bajo un enfoque socioecosistémico, que incrementan la calidad y la superficie de los espacios verdes y azules en zonas urbanas y densamente pobladas, y propician la conectividad ecológica y la conservación de la biodiversidad nativa.",
          'eje': 'Salvaguardar',
          'global': '12',
        },
        '13.0': {
          'nombre':
              "Distribución de beneficios asociados a los recursos genéticos",
          'descripcion': "Al 2030, México cuenta con medidas normativas, administrativas, de política y de creación de capacidades que promueven la participación justa y equitativa en los beneficios que se deriven de la utilización de los recursos genéticos, sus derivados, los conocimientos tradicionales asociados y la información digital sobre secuencias de recursos genéticos, contribuyendo a la conservación de la diversidad biológica y el uso sustentable de sus componentes.",
          'eje': 'Salvaguardar',
          'global': '13',
        },
        '14.1': {
          'nombre': "Integración de la biodiversidad en otros sectores",
          'descripcion': "Para 2030, los sectores gubernamentales responsables de las políticas públicas que impactan directa o indirectamente a la biodiversidad diseñan, ejecutan y dan seguimiento a estrategias de integración de la biodiversidad.",
          'eje': 'Actuar',
          'global': '14',
        },
        '14.2': {
          'nombre': "Integración de la biodiversidad en el turismo",
          'descripcion':
              "Para 2030, el sector turístico en México ha incorporado consideraciones de conservación y uso sustentable de la biodiversidad en el marco normativo, planes, programas, estrategias, actividades y negocios.",
          'eje': 'Actuar',
          'global': '14',
        },
        '15.0': {
          'nombre': "Integración de la biodiversidad en los sectores empresarial y financiero",
          'descripcion': "Para 2030, México ha avanzado en la implementación de una hoja de ruta para el establecimiento de un marco jurídico e institucional (regulaciones, lineamientos, políticas públicas, incentivos, métricas e indicadores) para que los sectores empresarial y financiero identifiquen, analicen, evalúen y difundan con transparencia y regularidad sus impactos, dependencias, riesgos y oportunidades en la diversidad biológica.",
          'eje': 'Actuar',
          'global': '15',
        },
        '16.0': {
          'nombre': "Consumo sustentable de alimentos",
          'descripcion': "Para 2030, en México se promueve el consumo sustentable de alimentos a través de la implementación de la Ley General de la Alimentación Adecuada y Sostenible (LGAAS), mediante una alimentación regional basada en las Guías Alimentarias Saludables y Sostenibles para Población Mexicana; se reduce la huella de carbono [y la generación de residuos asociados a la alimentación].",
          'eje': 'Actuar',
          'global': '16',
        },
        '17.1': {
          'nombre': "Fortalecimiento de la bioseguridad asociada a los organismos genéticamente modificados",
          'descripcion': "Para 2030, México fortalece los procesos de análisis (evaluación, gestión y comunicación) de los riesgos asociados a las actividades con los organismos genéticamente modificados (OGM), mediante propuestas de mejora del marco normativo en la materia, que consideren información relativa a los paquetes tecnológicos asociados, las consideraciones socioeconómicas, la observancia del principio precautorio, los derechos humanos, incluyendo los derechos de los pueblos indígenas y comunidades locales y afromexicanas.",
          'eje': 'Evitar',
          'global': '17',
        },
        '17.2': {
          'nombre': "Trazabilidad de los organismos genéticamente modificados",
          'descripcion': "Para 2030, México cuenta con una propuesta de política pública de trazabilidad de maíz genéticamente modificado (GM), bajo un enfoque amplio de bioseguridad de organismos genéticamente modificados (OGM), en concordancia con las obligaciones constitucionales, en materia de derechos humanos y de observancia del principio precautorio.",
          'eje': 'Evitar',
          'global': '17',
        },
        '18.0': {
          'nombre': "Eliminación de incentivos y subsidios perjudiciales para la biodiversidad y fortalecimiento de los positivos",
          'descripcion': "Para 2030, los incentivos, incluidos los subsidios, de los sectores público y privado fomentan el desarrollo sustentable, la internalización de las externalidades y minimizan los riesgos e impactos sobre los ecosistemas y los sistemas agroalimentarios bajo un enfoque de competitividad, desarrollo social y productividad.",
          'eje': 'Actuar',
          'global': '18',
        },
        '19.1': {
          'nombre': "Financiamiento internacional",
          'descripcion': "Al 2030 se hace más eficiente el uso del financiamiento internacional, mediante mecanismos financieros para la implementación de proyectos de conservación, uso sustentable y restauración de la biodiversidad, diseñados con base en los principios de la efectividad y fomentando mecanismos de acceso directo, especialmente para pueblos indígenas y comunidades afromexicanas y atendiendo vacíos y omisiones geográficos y de integridad ecosistémica.",
          'eje': 'Actuar',
          'global': '19',
        },
        '19.2': {
          'nombre': "Movilización de recursos internos",
          'descripcion': "Al 2030, México ha reducido significativamente la brecha de financiamiento para la implementación de la Estrategia Nacional sobre Biodiversidad de México (ENBioMex) y las metas nacionales, y cuenta con herramientas para analizar, mejorar la eficiencia e incrementar la inversión pública en conservación, uso sustentable y restauración de la biodiversidad.",
          'eje': 'Actuar',
          'global': '19',
        },
        '19.3': {
          'nombre': "Financiamiento privado",
          'descripcion':
              "Para 2030, México instrumenta planes innovadores de financiamiento para la biodiversidad que habilitan, crean o implementan instrumentos económicos que incentivan la participación y movilización de recursos del sector empresarial y financiero privado, considerando, entre otros, los indicados en la Ley General del Equilibrio Ecológico y Protección al Ambiente (LGEEPA) en la materia.",
          'eje': 'Actuar',
          'global': '19',
        },
        '19.4': {
          'nombre': "Monitoreo del financiamiento",
          'descripcion': "Para 2030, se implementa un mecanismo federal para la recopilación de información y el reporte sobre la provisión, utilización y brechas de financiamiento recibido y destinado a la biodiversidad, que abarque recursos nacionales e internacionales, bilaterales, regionales, multilaterales, cooperaciones técnicas, así como de fuentes privadas y filantrópicas.",
          'eje': 'Actuar',
          'global': '19',
        },
        '20.1': {
          'nombre': "Fortalecimiento de capacidades nacionales",
          'descripcion': "Para 2030, México incrementa y fortalece de manera progresiva las capacidades nacionales, así como el acceso a la tecnología y su transferencia en materia de biodiversidad a través de la generación de alianzas nacionales e internacionales.",
          'eje': 'Actuar',
          'global': '20',
        },
        '20.2': {
          'nombre': "Fortalecimiento de capacidades a través de la cooperación regional y global",
          'descripcion':
              "Para 2030, México contribuye al fortalecimiento de capacidades regionales y globales en materia de biodiversidad mediante la cooperación Sur-Sur y triangular.",
          'eje': 'Actuar',
          'global': '20',
        },
        '21.1': {
          'nombre': "Fortalecimiento del conocimiento para la biodiversidad",
          'descripcion': "Para 2030, México habrá consolidado el acceso a datos, información, conocimiento y herramientas sobre la biodiversidad, facilitando la toma de decisiones participativa y promoviendo una cultura de conservación y uso sustentable de la biodiversidad.",
          'eje': 'Actuar',
          'global': '21',
        },
        '21.2': {
          'nombre': "Integración del conocimiento tradicional en la toma de decisiones",
          'descripcion':
              "Para 2030, México logra que sus políticas públicas relativas al manejo, aprovechamiento y conservación sustentable de la biodiversidad integren la información disponible, reconociendo e incluyendo conocimientos tradicionales que hayan sido compartidos por pueblos y comunidades indígenas y afromexicanas, a través de un proceso de consulta libre, previa e informada, según corresponda.",
          'eje': 'Actuar',
          'global': '21',
        },
        '22.0': {
          'nombre': "Participación de los pueblos indígenas, comunidades locales y afromexicanas",
          'descripcion': "Al 2030 se logran instrumentar los mecanismos para la participación, el acceso a la información y el acceso a la justicia de los pueblos indígenas, comunidades locales y afromexicanas, defensores ambientales y otros grupos en situación de vulnerabilidad conforme a la normatividad internacional en materia de derechos humanos, en particular el Acuerdo de Escazú y el Convenio 169 de la Organización Internacional del Trabajo (oit).",
          'eje': 'Actuar',
          'global': '22',
        },
        '23.0': {
          'nombre': "Integración de la igualdad de género",
          'descripcion':
              "México promueve y fortalece la participación plena y efectiva de las mujeres en toda su diversidad en la toma de decisiones relacionadas con el acceso y control a los beneficios de la conservación, restauración y aprovechamiento sustentable de los recursos naturales a través de la implementación de los programas, políticas, proyectos y acciones de la administración pública federal que involucren temas sobre la diversidad biológica, incluyendo la Estrategia Nacional sobre Biodiversidad de México (ENBioMex).",
          'eje': 'Actuar',
          'global': '23',
        },
      };

      var ordenMetaNacional = 1;
      for (final entry in metasNacionales.entries) {
        final meta = entry.value;
        await insertarMetaNacional(
          codigo: entry.key,
          nombre: meta['nombre']!,
          descripcion: meta['descripcion'],
          eje: meta['eje']!,
          metaGlobal: meta['global']!,
          orden: ordenMetaNacional++,
        );
      }

      // -------------------------------------------------------------------
      // REFERENCIAS Y HITOS VERIFICADOS DE LAS METAS 1.1–1.4.
      // -------------------------------------------------------------------
      final ref14 = await insertarReferencia(
        pagina: 14,
        seccion: 'Meta Nacional 1.1 — Hitos',
        observacion: 'Hitos 1.1.1 a 1.1.10.',
      );
      final ref15 = await insertarReferencia(
        pagina: 15,
        seccion: 'Meta Nacional 1.1 — Hitos',
        observacion: 'Hitos 1.1.11 a 1.1.17.',
      );
      final ref16 = await insertarReferencia(
        pagina: 16,
        seccion: 'Meta Nacional 1.2 — Hitos',
      );
      final ref17 = await insertarReferencia(
        pagina: 17,
        seccion: 'Meta Nacional 1.3 — Hitos',
      );
      final ref18 = await insertarReferencia(
        pagina: 18,
        seccion: 'Meta Nacional 1.4 — Hitos',
        observacion: 'Hitos 1.4.1 a 1.4.8.',
      );
      final ref19 = await insertarReferencia(
        pagina: 19,
        seccion: 'Meta Nacional 1.4 — Hitos',
        observacion: 'Hitos 1.4.9 a 1.4.13.',
      );

      const hitos11 = <Map<String, String>>[
        {
          'codigo': '1.1.1',
          'periodo': '2024',
          'descripcion': "Para 2024, 50% del territorio nacional cuenta con ordenamientos ecológicos regionales, estales o locales.",
        },
        {
          'codigo': '1.1.2',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, se incorporan o actualizan 500 mil hectáreas al año a los ordenamientos territoriales comunitarios.",
        },
        {
          'codigo': '1.1.3',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se fortalecen las capacidades de gobiernos estatales y municipales para la aplicación de la nom-003-sedatu-2023, que establece los lineamientos para el fortalecimiento del sistema territorial para resistir, adaptarse y recuperarse ante amenazas de origen natural y del cambio climático a través del ordenamiento territorial.",
        },
        {
          'codigo': '1.1.4',
          'periodo': '2026',
          'descripcion': "Para 2026, los estados y municipios incorporan los lineamientos de la nom-003-sedatu-2023 a sus programas y planes de ordenamiento territorial y de desarrollo urbano, que promueven la conservación y uso sustentable de la biodiversidad, así como la conectividad ecológica y la calidad de las áreas verdes y azules.",
        },
        {
          'codigo': '1.1.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se coordinan esfuerzos para armonizar o vincular las metodologías de ordenamientos ecológicos locales/comunitarios (semarnat) y ordenamientos territoriales comunitarios (manejo forestal y territorios de uso común; conafor).",
        },
        {
          'codigo': '1.1.6',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se publica en el Diario Oficial de la Federación la actualización del Programa de Ordenamiento Turístico General del Territorio y se cuenta con los acuerdos metodológicos para su aplicación.",
        },
        {
          'codigo': '1.1.7',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se cuenta con tres ordenamientos turísticos comunitarios en los estados de Baja California Sur, Oaxaca y Quintana Roo, integrando criterios y salvaguardas de sustentabilidad y conservación de la biodiversidad, así como manejo integral y sustentable del agua.",
        },
        {
          'codigo': '1.1.8',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se decretan tres zonas de desarrollo turístico sustentable, integrando políticas y criterios de regulación ecológica, en Baja California Sur, Oaxaca, y Quintana Roo.",
        },
        {
          'codigo': '1.1.9',
          'periodo': '2026',
          'descripcion': "Para 2026, se incorporan las figuras de ordenamientos turísticos municipales y comunitarios integrando criterios y salvaguardas de sustentabilidad y conservación de la biodiversidad, así como manejo integral y sustentable del agua, en la Ley General de Turismo y su Reglamento.",
        },
        {
          'codigo': '1.1.10',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se elaboran los ordenamientos turísticos locales/estatales de Baja California Sur, Oaxaca y Quintana Roo.",
        },
        {
          'codigo': '1.1.11',
          'periodo': '2027',
          'descripcion': "Al 2027, los estados y municipios inician la armonización de su normatividad local, conforme a los lineamientos establecidos por la nom-003-sedatu-2023.",
        },
        {
          'codigo': '1.1.12',
          'periodo': '2027',
          'descripcion': "Para 2027, se promueve el reconocimiento de los ordenamientos territoriales comunitarios como instrumentos formales de planeación ecológica del territorio.",
        },
        {
          'codigo': '1.1.13',
          'periodo': '2028',
          'descripcion': "Para 2028, Guerrero, San Luis Potosí y Zacatecas realizan sus ordenamientos ecológicos regionales/estatales.",
        },
        {
          'codigo': '1.1.14',
          'periodo': '2028',
          'descripcion': "Para 2028, 70% de las entidades han elaborado ordenamientos ecológicos regionales para todo su territorio.",
        },
        {
          'codigo': '1.1.15',
          'periodo': '2028',
          'descripcion': "Para 2028, se promueve la armonización legal y administrativa de los instrumentos de planeación territorial en cuanto al aspecto urbano y ambiental.",
        },
        {
          'codigo': '1.1.16',
          'periodo': '2030',
          'descripcion': "Para 2030, 25% de las entidades del país actualizan sus ordenamientos ecológicos armonizados con el ordenamiento territorial y urbano.",
        },
        {
          'codigo': '1.1.17',
          'periodo': '2030',
          'descripcion': "Para 2030, 20% de los municipios del territorio nacional cuentan con ordenamientos ecológicos y territoriales armonizados.",
        },
      ];

      for (var i = 0; i < hitos11.length; i++) {
        final hito = hitos11[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '1.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 10 ? ref14 : ref15,
        );
      }

      const hitos12 = <Map<String, String>>[
        {
          'codigo': '1.2.1',
          'descripcion': "Se reactiva, instala y opera el Comité de Ordenamiento Ecológico del Pacífico Centro-Sur.",
        },
        {
          'codigo': '1.2.2',
          'descripcion': "Se compila, revisa y actualiza la información para la integración de una línea base de la región marina y zonas federales adyacentes del Pacífico Centro-Sur.",
        },
        {
          'codigo': '1.2.3',
          'descripcion': "Se actualizan los análisis de aptitud y de conflictos del Pacífico Centro-Sur.",
        },
        {
          'codigo': '1.2.4',
          'descripcion': "Se delimitan técnicamente las áreas de preservación, conservación, protección y restauración, así como aquellas que requieran el establecimiento de medidas de mitigación y adaptación al cambio climático.",
        },
        {
          'codigo': '1.2.5',
          'descripcion': "Se desarrolla el diagnóstico del Programa de Ordenamiento Ecológico Marino y Regional del Pacífico Centro-Sur.",
        },
        {
          'codigo': '1.2.6',
          'descripcion': "Se integra una propuesta de Programa de Ordenamiento Ecológico Marino (poem) de la región Pacífico Centro-Sur, basado en un proceso participativo a nivel local/ regional.",
        },
        {
          'codigo': '1.2.7',
          'descripcion': "Se aprueba por parte del Comité el poem Pacífico Centro-Sur, y se publica en el Diario Oficial de la Federación.",
        },
        {
          'codigo': '1.2.8',
          'descripcion': "Se identifican recomendaciones para actualizar los poem y fortalecer la efectividad en su implementación.",
        },
      ];

      for (var i = 0; i < hitos12.length; i++) {
        final hito = hitos12[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '1.2',
          descripcion: hito['descripcion']!,
          orden: i + 1,
          referenciaOrigenId: ref16,
        );
      }

      const hitos13 = <Map<String, String>>[
        {
          'codigo': '1.3.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con la actualización de la PNMSMCM publicada en el Diario Oficial de la Federación.",
        },
        {
          'codigo': '1.3.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se identifican las necesidades y se promueve la armonización del marco legal para la implementación efectiva de la PNMSMCM (en coordinación con los Ordenamientos Ecológicos Marinos señalados en la meta nacional 1.2).",
        },
        {
          'codigo': '1.3.3',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, se identifican y atienden las necesidades de información y se fortalecen las capacidades institucionales para la implementación efectiva de la PNMSMCM.",
        },
        {
          'codigo': '1.3.4',
          'periodo': '2027 en adelante',
          'descripcion': "Para 2027 y en adelante, se inicia la implementación de las líneas de acción de la PNMSMCM.",
        },
        {
          'codigo': '1.3.5',
          'periodo': '2030',
          'descripcion': "Para 2030, se cuenta con un avance significativo de la implementación de la PNMSMCM a nivel nacional.",
        },
      ];

      for (var i = 0; i < hitos13.length; i++) {
        final hito = hitos13[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '1.3',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref17,
        );
      }

      const hitos14 = <Map<String, String>>[
        {
          'codigo': '1.4.1',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025, la Estrategia Nacional para la Reducción de Emisiones por Deforestación y Degradación Forestal 2017-2030 (ENAREDD+) se implementa de manera eficiente, bajo un enfoque de manejo integrado del territorio y con una coordinación interinstitucional efectiva (intersectorial y multinivel).",
        },
        {
          'codigo': '1.4.2',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025 y en adelante, se realiza bienalmente el monitoreo de la cobertura forestal, con la finalidad de contar con información sobre el estado de la deforestación a nivel nacional.",
        },
        {
          'codigo': '1.4.3',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025, se fortalece el seguimiento continuo a la implementación de la ENAREDD+, a través del Grupo de Trabajo redd+ (GT-REDD+) de la Comisión Intersecretarial de Cambio Climático (CICC), que sesiona de manera periódica y sistemática bajo la coordinación de la Dirección General de Políticas para la Acción Climática (DGPAC) de la Secretaría del Medio Ambiente y Recursos Naturales (semarnat) y con el apoyo de la Unidad de Asuntos Internacionales y Fomento Financiero (UAIFF) de la Comisión Nacional Forestal (CONAFOR).",
        },
        {
          'codigo': '1.4.4',
          'periodo': '2025',
          'descripcion': "Para 2025, se incluye la meta de frenar la pérdida y degradación de los ecosistemas naturales, abordando y eliminando sus causas principales, en el Plan Nacional de Desarrollo, así como acciones puntuales en los programas sectoriales y especiales para su cumplimiento, como parte de una política de desarrollo rural y forestal sustentable en México.",
        },
        {
          'codigo': '1.4.5',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, las instituciones del sector ambiental y productivo identifican, acuerdan e implementan acciones prioritarias para coadyuvar al cumplimiento de la meta de tasa de cero deforestación neta, y atender las causas que provocan la deforestación en el marco de la ENAREDD+ y el Acuerdo Nacional por los Bosques, Selvas y Manglares.",
        },
        {
          'codigo': '1.4.6',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se realizan, a través de los instrumentos necesarios, arreglos institucionales sólidos entre instancias de los tres órdenes de gobierno para articular políticas y programas que promuevan el desarrollo turístico, inmobiliario, rural y forestal sustentable, buscando ordenar y lograr complementariedad en la gestión territorial para el cumplimiento de la meta.",
        },
        {
          'codigo': '1.4.7',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se incrementan y se fortalecen las acciones de inspección, vigilancia, prevención y autorregulación dirigidas al combate de la deforestación, para coadyuvar en el cumplimiento de la meta.",
        },
        {
          'codigo': '1.4.8',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se continúa con el fomento de la incorporación de ecosistemas forestales al manejo sustentable como medida para frenar la deforestación, a través de la focalización hacia las zonas de mayor riesgo.",
        },
        {
          'codigo': '1.4.9',
          'periodo': '2026 en adelante',
          'descripcion': "A partir de 2026 y en adelante, el GT-REDD+ realiza actividades para fortalecer la gobernanza local, con la finalidad de impulsar una participación social efectiva bajo igualdad de oportunidades para mujeres y hombres en la implementación de la ENAREDD+, con respecto a la planeación y toma de decisiones de las acciones colaborativas a desarrollar.",
        },
        {
          'codigo': '1.4.10',
          'periodo': '2026 en adelante',
          'descripcion': "A partir de 2026, la semarnat, en colaboración con la Secretaría de Agricultura y Desarrollo Rural (agricultura) y la conafor diseñan e implementan un sistema de información para identificar terrenos forestales o agropecuarios, y con ellos promover la producción libre de deforestación.",
        },
        {
          'codigo': '1.4.11',
          'periodo': '2026',
          'descripcion': "Para 2026, se realizan acciones efectivas que favorecen la conectividad ecológica y la captura de carbono, mediante el manejo forestal, la conservación, restauración y protección forestal, el manejo de zonas costeras, humedales y manglares.",
        },
        {
          'codigo': '1.4.12',
          'periodo': '2026',
          'descripcion': "Para 2026, se formulan y presentan los reportes sobre el abordaje y respecto de las salvaguardas sociales y ambientales en el marco de la implementación de las acciones redd+ en México, las cuales son reportadas de manera periódica a la Convención Marco de las Naciones Unidas sobre el Cambio Climático (CMNUCC).",
        },
        {
          'codigo': '1.4.13',
          'periodo': '2028',
          'descripcion': "Para 2028, se formulan y presentan los reportes sobre el abordaje y respecto de las salvaguardas sociales y ambientales en el marco de la implementación de las acciones redd+ en México, incluyendo los indicadores de cumplimiento de las salvaguardas.",
        },
      ];

      for (var i = 0; i < hitos14.length; i++) {
        final hito = hitos14[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '1.4',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 8 ? ref18 : ref19,
        );
      }

      // -------------------------------------------------------------------
      // HITOS VERIFICADOS: METAS 4.0–6.3
      // Fuente: Guía Rápida 2026.
      // -------------------------------------------------------------------

      final ref32 = await insertarReferencia(
        pagina: 32,
        seccion: 'Meta Nacional 4.0 — Hitos',
      );
      final ref33 = await insertarReferencia(
        pagina: 33,
        seccion: 'Meta Nacional 4.0 — Hitos',
      );

      const hitos40 = <Map<String, String>>[
        {
          'codigo': '4.0.1',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, se fortalecen, elaboran y/o ponen en marcha, los programas de recuperación de especies (pace-Programas de Acción para la Conservación de Especies, pmt-Planes de Manejo Tipo-, planes de manejo pesquero, planes de acción nacional, entre otros), con base en la priorización de aquellas que requieren con mayor urgencia acciones de conservación.",
        },
        {
          'codigo': '4.0.2',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se realiza al menos un taller al año de capacitación a técnicos responsables y oficiales gubernamentales que elaboran y revisan los planes y programas de manejo e informes anuales de unidades de maejo para la conservación de la vida silvestre (UMA), predios e instalaciones que manejan vida silvestre (PIMVS) y predios forestales.",
        },
        {
          'codigo': '4.0.3',
          'periodo': '2025',
          'descripcion': "Para 2025, se publica la actualización de la NOM-059-SEMARNAT-2010, tomando en cuenta las evaluaciones de riesgo (MER); los datos son incorporados al Sistema Nacional de Información sobre Biodiversidad (SNIB).",
        },
        {
          'codigo': '4.0.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se deslinda la Lista de Especies en Riesgo de la NOM-059-SEMARNAT-2010, con la finalidad de facilitar el proceso de actualización y publicación cada tres años, como lo marca la ley.",
        },
        {
          'codigo': '4.0.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se fortalece la elaboración y revisión de los planes y programas de manejo e informes anuales de UMA, PIMVS y predios forestales mediante la capacitación de los técnicos responsables y oficiales de las dependencias y sus órganos.",
        },
        {
          'codigo': '4.0.6',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con financiamiento para el establecimiento y desarrollo de los programas de recuperación de las especies que se identificaron como prioritarias.",
        },
        {
          'codigo': '4.0.7',
          'periodo': '2027',
          'descripcion': "Para 2027, se establece un mecanismo de coordinación que permita a las instituciones de la administración pública federal la implementación coordinada de medidas de gestión, recuperación y conservación de especies en peligro de extinción y amenazadas según la NOM-059-SEMARNAT-2010, silvestres o las que se encuentran bajo manejo.",
        },
        {
          'codigo': '4.0.8',
          'periodo': '2027',
          'descripcion': "Para 2027, se inicia un mecanismo de monitoreo de la diversidad genética de especies de la agrobiodiversidad.",
        },
        {
          'codigo': '4.0.9',
          'periodo': '2028',
          'descripcion': "Para 2028, se inicia la implementación de medidas de conservación de la diversidad genética de especies de la agrobiodiversidad con base en el indicador de diversidad genética.",
        },
      ];
      for (var i = 0; i < hitos40.length; i++) {
        final hito = hitos40[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '4.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 1 ? ref32 : ref33,
        );
      }

      const subhitos401 = <Map<String, String>>[
        {
          'codigo': '4.0.1.1',
          'descripcion': "Para 2024 y en adelante, se fortalece la implementación de los programas de recuperación de los ecosistemas a través de la acuacultura restaurativa, que implica la elaboración y publicación de al menos dos fichas al año de las especies con algún estatus de protección en la Carta Nacional Acuícola; así como la generación de biotecnología para reproducir organismos que permitan la repoblación in situ bajo protocolos adecuados, entre otras actividades que favorezcan la conservación de la biodiversidad y el mejoramiento del medio ambiente.",
        },
        {
          'codigo': '4.0.1.2',
          'descripcion': "Para 2025, se publica la actualización del Plan de Acción Nacional para el Manejo y Conservación de Tiburones, Rayas y Especies Afines en México (panmct, segunda edición).",
        },
        {
          'codigo': '4.0.1.3',
          'descripcion': "Al 2025, se mantiene y fortalece la focalización de los incentivos denominados Pago por Servicios Ambientales (PSA) en los sitios de atención prioritaria para la conservación de la biodiversidad terrestre considerando los insumos que proporciona la conabio.",
        },
        {
          'codigo': '4.0.1.4',
          'descripcion': "Para 2025 y en adelante, se establecen anualmente al menos dos nuevas zonas de refugio pesquero, que contribuyan a la protección y conservación de especies de importancia ecológica, incluyendo especies que se encuentran en alguna categoría de riesgo dentro de la NOM-059-SEMARNAT-2010.",
        },
        {
          'codigo': '4.0.1.5',
          'descripcion': "Para 2025 y en adelante, se desarrollan seis pmt para especies en la categoría de amenazadas y dos para especies en la categoría en peligro de extinción.",
        },
        {
          'codigo': '4.0.1.6',
          'descripcion': "Para 2026, se realiza un diagnóstico de la implementación de los PACE y se identifican acciones puntuales para su fortalecimiento.",
        },
        {
          'codigo': '4.0.1.7',
          'descripcion': "Al 2030, se promueven y fortalecen los mecanismos y procesos normativos para la identificación y operación de hábitats críticos para la conservación de la vida silvestre y áreas de refugio.",
        },
      ];

      for (var i = 0; i < subhitos401.length; i++) {
        final subhito = subhitos401[i];
        await insertarSubhito(
          codigo: subhito['codigo']!,
          hito: '4.0.1',
          descripcion: subhito['descripcion']!,
          orden: i + 1,
          referenciaOrigenId: ref32,
        );
      }

      final ref36 = await insertarReferencia(
        pagina: 36,
        seccion: 'Meta Nacional 5.0 — Hitos',
      );
      final ref37 = await insertarReferencia(
        pagina: 37,
        seccion: 'Meta Nacional 5.0 — Hitos',
      );
      const hitos50 = <Map<String, String>>[
        {
          'codigo': '5.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se establece un grupo de contacto de especialistas de las dependencias que tienen atribuciones en materia de vida silvestre, forestal, pesquera, fito y zoosanitaria, para sistematizar la información sobre medidas, esfuerzos, actividades, bases de datos y sistemas de trazabilidad, considerando mecanismos de coordinación interinstitucional para fortalecer la sustentabilidad.",
        },
        {
          'codigo': '5.0.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con un diagnóstico que incluye un mapeo sobre las herramientas de seguimiento y trazabilidad (sistemas de trazabilidad, bases de datos y otros), así como las diferentes dependencias que tienen atribuciones en materia de vida silvestre, forestal, pesquera, fito y zoosanitaria; así como el plan de trabajo para implementar la interoperabilidad de los sistemas. • Realizar reuniones de coordinación entre distintas autoridades. • Determinar qué información se manejará, qué información es considerada sensible, cómo se rastrea, documentación equivalente, fotografías, información genética, etc. • Definir qué estadísticas generan los sistemas que manejan las dependencias y qué es lo que se espera del sistema vinculado para la toma de decisiones (priorización de especies, criterios, entre otros). • Realizar un análisis de ciclo de vida de la información.",
        },
        {
          'codigo': '5.0.3',
          'periodo': '2027',
          'descripcion': "Para 2027, se realiza la vinculación y se programa la interfase de interoperación, se realizan las pruebas piloto pertinentes.",
        },
        {
          'codigo': '5.0.4',
          'periodo': '2030',
          'descripcion': "Para 2030, México cuenta con un sistema de trazabilidad de ejemplares, productos y subproductos que se generan del aprovechamiento de especies silvestres interoperando, desde su origen, hasta su destino final.",
        },
        {
          'codigo': '5.0.5',
          'periodo': '2030',
          'descripcion': "Para 2030, la información estadística derivada del sistema apoya la toma la toma de decisiones para fortalecer la transparencia y accesibilidad del sistema de trazabilidad.",
        },
      ];
      for (var i = 0; i < hitos50.length; i++) {
        final hito = hitos50[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '5.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 4 ? ref36 : ref37,
        );
      }

      final ref40 = await insertarReferencia(
        pagina: 40,
        seccion: 'Meta Nacional 6.1 — Hitos',
      );
      const hitos61 = <Map<String, String>>[
        {
          'codigo': '6.1.1',
          'periodo': '2026',
          'descripcion': "Para 2026, se evalúan los avances y cumplimiento de la Estrategia Nacional de Especies Exóticas Invasoras (eneei), y se identifican las acciones prioritarias a seguir.",
        },
        {
          'codigo': '6.1.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se actualiza la lista de EEI de México, incluyendo las plagas de importancia cuarentenaria detectadas en embalajes de madera utilizados en el comercio internacional de mercancías y bienes, y se publica en el Diario Oficial de la Federación, incluyendo todos los grupos taxonómicos.",
        },
        {
          'codigo': '6.1.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se fortalecen los mecanismos de intercambio de información, vinculación y comunicación entre las instancias que regulan y participan en la detección temprana y atención a casos de introducción de EEI entre instituciones nacionales e internacionales.",
        },
        {
          'codigo': '6.1.4',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se actualizan los materiales (guías, listados, trípticos, catálogos, etc.) y se refuerzan los mecanismos de divulgación sobre las EEI, los cuales se distribuyen en los principales puertos, aeropuertos y fronteras y son de acceso público.",
        },
        {
          'codigo': '6.1.5',
          'periodo': '2026',
          'descripcion': "Al 2026, se cuenta con lineamientos generales para el control y manejo de las bioincrustaciones en embarcaciones, así como de las aguas de lastre consistentes con los lineamientos internacionales Organización Marítima Internacional (omi) para controlar y minimizar la transferencia de EEI por esta ruta de introducción.",
        },
        {
          'codigo': '6.1.6',
          'periodo': '2030',
          'descripcion': "Para 2030, se actualiza el marco normativo con base en la actualización de la lista de EEI.",
        },
        {
          'codigo': '6.1.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se fortalece la coordinación institucional para implementar procedimientos orientados a la prevención y reducción de la introducción de EEI en los aeropuertos, puertos y fronteras de México, considerando las principales rutas de introducción.",
        },
      ];
      for (var i = 0; i < hitos61.length; i++) {
        final hito = hitos61[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '6.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref40,
        );
      }

      final ref42 = await insertarReferencia(
        pagina: 42,
        seccion: 'Meta Nacional 6.2 — Hitos',
      );
      const hitos62 = <Map<String, String>>[
        {
          'codigo': '6.2.1',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con una línea base actualizada del impacto de las EEI en las islas donde se identifican prioridades para desarrollar la estrategia de control y erradicación.",
        },
        {
          'codigo': '6.2.2',
          'periodo': '2026',
          'descripcion': "En 2026, se cuenta con un Protocolo Nacional de Bioseguridad Insular, elaborado y consensuado por los actores involucrados en la prevención, manejo, control y erradicación de EEI en ANP insulares.",
        },
        {
          'codigo': '6.2.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se realiza un diagnóstico de capacidades institucionales de la Comisión Nacional de Áreas Naturales Protegidas (CONANP) y con ello se desarrolla un plan de fortalecimiento de capacidades en la prevención, manejo, control y erradicación de EEI en ANP insulares.",
        },
        {
          'codigo': '6.2.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con acuerdos de coordinación y cooperación intersecretarial e interinstitucional sobre manejo de EEI y la aplicación del Protocolo Nacional de Bioseguridad Insular.",
        },
        {
          'codigo': '6.2.5',
          'periodo': '2026',
          'descripcion': "En 2026, se actualiza el Programa para la Atención y Manejo de Especies Exóticas Invasoras y Ferales en ANP de competencia federal.",
        },
        {
          'codigo': '6.2.6',
          'periodo': '2027',
          'descripcion': "En 2027, se evalúa la Estrategia Nacional para la Conservación y el Desarrollo Sustentable del Territorio Insular Mexicano y se elabora una ruta crítica para su actualización.",
        },
        {
          'codigo': '6.2.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se fortalece el marco jurídico en materia de control y erradicación de EEI que considere las acciones establecidas en el Programa para la Atención y Manejo de Especies Exóticas Invasoras y Ferales en ANP como medidas prioritarias de restauración ecológica y conservación de la diversidad biológica.",
        },
      ];
      for (var i = 0; i < hitos62.length; i++) {
        final hito = hitos62[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '6.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref42,
        );
      }

      final ref43 = await insertarReferencia(
        pagina: 43,
        seccion: 'Meta Nacional 6.3 — Hitos',
      );
      const hitos63 = <Map<String, String>>[
        {
          'codigo': '6.3.1',
          'periodo': '2026',
          'descripcion': "Al 2026, se cuenta con una línea base actualizada del impacto de las EEI en ANP continentales de competencia federal, que permite identificar prioridades para la implementación de proyectos piloto de control y erradicación.",
        },
        {
          'codigo': '6.3.2',
          'periodo': '2027',
          'descripcion': "Para 2027, se desarrolla un diagnóstico de capacidades institucionales de la Comisión Nacional de Áreas Naturales Protegidas (CONANP) y con ello se desarrolla un plan de fortalecimiento de capacidades para la prevención, manejo, control y erradicación de EEI en ANP continentales de carácter federal.",
        },
        {
          'codigo': '6.3.3',
          'periodo': '2027',
          'descripcion': "En 2027, se actualiza el Programa para la Atención y Manejo de Especies Exóticas Invasoras y Ferales en ANP de competencia federal.",
        },
        {
          'codigo': '6.3.4',
          'periodo': '2027',
          'descripcion': "Al 2027, se evalúa y actualiza la Estrategia Nacional sobre Especies Invasoras en México, para conocer el avance y fortalecer el control y erradicación de las EEI.",
        },
        {
          'codigo': '6.3.5',
          'periodo': '2027',
          'descripcion': "Al 2027, se cuenta con acuerdos de coordinación y cooperación intersecretarial e interinstitucional para la implementación del Programa para la Atención y Manejo de Especies Exóticas Invasoras y Ferales en ANP de competencia federal.",
        },
        {
          'codigo': '6.3.6',
          'periodo': '2028',
          'descripcion': "Al 2028, se implementan las acciones prioritarias para prevenir, manejar, controlar y erradicar las EEI en ANP continentales de carácter federal con base en la Estrategia Nacional sobre Especies Invasoras en México actualizada y el Programa para la Atención y Manejo de Especies Exóticas Invasoras y Ferales en ANP de competencia federal.",
        },
        {
          'codigo': '6.3.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se fortalece el marco jurídico en materia de control y erradicación de EEI que considere estas acciones como medidas prioritarias de restauración ecológica y conservación de la diversidad biológica.",
        },
        {
          'codigo': '6.3.8',
          'periodo': '2025–2030',
          'descripcion': "Entre 2025 y 2030, se implementan campañas de difusión y divulgación en ANP continentales de carácter federal sobre las invasiones biológicas dirigido a prestadores de servicios, visitantes, comunidades, productores e instituciones, entre otros.",
        },
      ];
      for (var i = 0; i < hitos63.length; i++) {
        final hito = hitos63[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '6.3',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref43,
        );
      }

      // -------------------------------------------------------------------
      // HITOS VERIFICADOS: METAS 2.1–3.2
      // Fuente: Guía Rápida 2026, pp. 22–29.
      // -------------------------------------------------------------------

      final ref22 = await insertarReferencia(
        pagina: 22,
        seccion: 'Meta Nacional 2.1 — Hitos',
      );
      const hitos21 = <Map<String, String>>[
        {
          'codigo': '2.1.1',
          'periodo': '2024',
          'descripcion': "Para 2024, se crea un espacio interinstitucional para coordinar los trabajos de restauración.",
        },
        {
          'codigo': '2.1.2',
          'periodo': '2026',
          'descripcion': "Al 2026, México establece una línea base en materia de superficies (ecosistemas, socioecosistemas) en proceso de restauración.",
        },
        {
          'codigo': '2.1.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se consolida un marco normativo adecuado y armónico, y se incrementan los esfuerzos para la formación de cuadros técnicos y científicos con una visión integral e interdisciplinaria que influyan en la formulación de nuevas políticas públicas en los tres órdenes de gobierno para la restauración efectiva.",
        },
        {
          'codigo': '2.1.4',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un Programa Nacional de Restauración Ambiental (PNRA), que incluye el paisaje rural.",
        },
        {
          'codigo': '2.1.5',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un sistema de evaluación y seguimiento que permite priorizar periódicamente las superficies elegibles de restauración.",
        },
        {
          'codigo': '2.1.6',
          'periodo': '2028',
          'descripcion': "Para 2028, se implementan acciones del PNRA en las superficies identificadas como prioritarias (zonas de restauración, áreas naturales protegidas, áreas destinadas voluntaria a la conservación, corredores biológicos, rutas migratorias, entre otros).",
        },
      ];
      for (var i = 0; i < hitos21.length; i++) {
        final hito = hitos21[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '2.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref22,
        );
      }

      final ref23 = await insertarReferencia(
        pagina: 23,
        seccion: 'Meta Nacional 2.2 — Hitos',
      );
      const hitos22 = <Map<String, String>>[
        {
          'codigo': '2.2.1',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se incrementa la cobertura de tratamiento de aguas residuales con respecto a las aguas municipales generadas.",
        },
        {
          'codigo': '2.2.2',
          'periodo': '2025–2030',
          'descripcion': "De 2025 a 2030, se fortalece la red de monitoreo de calidad del agua a nivel nacional, priorizando el monitoreo de los ríos Tula, Lerma-Santiago y Atoyac.",
        },
        {
          'codigo': '2.2.3',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 en adelante, se incrementa la capacitación a los productores en buenas prácticas (personas campesinas y productoras agropecuarias y acuícolas) en el uso de agroquímicos y medicamentos.",
        },
        {
          'codigo': '2.2.4',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se incrementa la captación de agua de lluvia urbana para reducir la presión sobre los ríos, haciendo énfasis en centros urbanos-agrícolas y que se derive a otras actividades que no requieran de uso humano directo.",
        },
        {
          'codigo': '2.2.5',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 en adelante, se promueven campañas de limpieza de ríos y otros cuerpos de agua, con la participación de las comunidades y la ciudadanía.",
        },
        {
          'codigo': '2.2.6',
          'periodo': '2030',
          'descripcion': "Para 2030, se realizan acciones de conservación y restauración en zonas de humedal, así como el repoblamiento con especies nativas en cuerpos de agua en áreas naturales protegidas (ANP) y sitios prioritarios.",
        },
        {
          'codigo': '2.2.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se actualiza el inventario de presas y represas, con la finalidad de establecer su seguridad estructural y funcional.",
        },
        {
          'codigo': '2.2.8',
          'periodo': '2030',
          'descripcion': "Para 2030, se actualiza la información referente a la cantidad y calidad del agua de los ríos seleccionados.",
        },
        {
          'codigo': '2.2.9',
          'periodo': '2030',
          'descripcion': "Para 2030, se incrementa la cantidad de sitios de monitoreo para evaluar la integridad ecológica mediante acciones de biomonitoreo.",
        },
        {
          'codigo': '2.2.10',
          'periodo': '2030',
          'descripcion': "Se mejoran las capacidades municipales para la captación de agua de lluvia.",
        },
        {
          'codigo': '2.2.11',
          'periodo': '2030',
          'descripcion': "Para 2030, se realiza el diagnóstico de presas para garantizar su funcionamiento óptimo; de ser necesario, se establecen programas de desazolve para la rehabilitación de dichos cuerpos de agua.",
        },
        {
          'codigo': '2.2.12',
          'periodo': '2030',
          'descripcion': "Para 2030, se realiza la biorremediación de cuerpos de agua en ANP y sitios prioritarios, considerando diversas técnicas, el tipo de contaminante, el medio afectado y el nivel de daño.",
        },
        {
          'codigo': '2.2.13',
          'periodo': '2030',
          'descripcion': "Para 2030, se incluyen en las medidas de seguimiento a las acciones de restauración/rehabilitación de ríos contaminados la evaluación de la respuesta biológica mediante valoración de calidad del hábitat y biomonitoreo.",
        },
        {
          'codigo': '2.2.14',
          'periodo': '2030',
          'descripcion': "Para 2030, se brinda acompañamiento técnico y especializado a las acciones de rehabilitación de riberas a los organismos responsables de los programas de restauración a nivel nacional.",
        },
        {
          'codigo': '2.2.15',
          'periodo': '2030',
          'descripcion': "Para 2030 se brinda acompañamiento técnico y especializado para la delimitación de zona federal en las acciones de intervención de programas de restauración.",
        },
      ];
      for (var i = 0; i < hitos22.length; i++) {
        final hito = hitos22[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '2.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref23,
        );
      }

      final ref25 = await insertarReferencia(
        pagina: 25,
        seccion: 'Meta Nacional 2.3 — Hitos',
      );
      final ref26 = await insertarReferencia(
        pagina: 26,
        seccion: 'Meta Nacional 2.3 — Hitos',
      );
      const hitos23 = <Map<String, String>>[
        {
          'codigo': '2.3.1',
          'periodo': '2025–2030',
          'descripcion': "Para 2025, se implementan acciones de restauración efectivas y monitoreo en 5% de los ecosistemas marinos y costeros degradados (considerando la línea base de 2024) y se aumenta progresivamente la superficie en procesos de restauración hasta alcanzar 50% en el 2030, involucrando a las comunidades locales en todas las etapas.",
        },
        {
          'codigo': '2.3.2',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se contará con fichas técnicas descriptivas de los sitios prioritarios para la restauración de ecosistemas marino-costeros e insulares, de acuerdo con el PNRA; que incorporen información básica sobre criterios ecológicos, amenazas y presiones, como base para orientar diagnósticos más integrales en etapas posteriores, así como respecto de ecosistemas de referencia para la restauración ecológica.",
        },
        {
          'codigo': '2.3.3',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con una priorización de los sitios y ecosistemas marino-costeros a restaurar, considerando a información recabada en las fichas técnicas descriptivas del hito 2.3.2, de acuerdo con el PNRA.",
        },
        {
          'codigo': '2.3.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se impulsan acciones de fortalecimiento de capacidades dirigidas a técnicos, científicos y personas involucradas en la gestión de programas y proyectos de restauración y el uso de herramientas, en colaboración con aliados estratégicos del ámbito académico, social, comunitario y de cooperación internacional.",
        },
        {
          'codigo': '2.3.5',
          'periodo': '2026–2027',
          'descripcion': "Para el periodo 2026-2027, se habrá avanzado en el fortalecimiento del marco jurídico e institucional necesario para facilitar la coordinación e implementación de acciones de restauración. Este proceso se articulará con los avances del PNRA como instrumento programático rector.",
        },
        {
          'codigo': '2.3.6',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con una metodología validada para la generación de arrecifes artificiales (con residuos de la ostricultura), como una solución basada en la naturaleza para la restauración de estos ecosistemas y el incremento de los reservorios de CO₂.",
        },
        {
          'codigo': '2.3.7',
          'periodo': '2027',
          'descripcion': "Para 2027, se comienzan proyectos piloto para la generación de arrecifes artificiales.",
        },
        {
          'codigo': '2.3.8',
          'periodo': '2028–2030',
          'descripcion': "Para 2028-2030, se cuenta con estrategias y herramientas de monitoreo y/o seguimiento, evaluación y adaptación continuos para los proyectos de restauración.",
        },
        {
          'codigo': '2.3.9',
          'periodo': '2030',
          'descripcion': "Para 2030, se encuentran en ejecución procesos de restauración en cinco sitios deteriorados del Golfo de California y cinco sitios en el Golfo de México.",
        },
        {
          'codigo': '2.3.10',
          'periodo': '2030',
          'descripcion': "Para 2030, se amplía la superficie de Zonas de Refugio Pesquero (ZRP) en 175 mil hectáreas mediante la publicación de al menos 15 Nuevos Acuerdos Regulatorios de ZRP y se implementan acciones de restauración.",
        },
      ];
      for (var i = 0; i < hitos23.length; i++) {
        final hito = hitos23[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '2.3',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 5 ? ref25 : ref26,
        );
      }
      await insertarSubhito(
        codigo: '2.3.1.1',
        hito: '2.3.1',
        descripcion: "Para 2030, en el marco del Programa Nacional de Restauración Ambiental (PNRA), se restauran 15 mil hectáreas de manglares, equivalentes a 30% de los manglares con procesos de degradación en México, contribuyendo a la recuperación de su cobertura y sus servicios ecosistémicos.",
        orden: 1,
        referenciaOrigenId: ref25,
      );

      final ref28 = await insertarReferencia(
        pagina: 28,
        seccion: 'Meta Nacional 3.1 — Hitos',
      );
      const hitos31 = <Map<String, String>>[
        {
          'codigo': '3.1.1',
          'periodo': '2025',
          'descripcion': "En 2025, los gobiernos municipales, estatales y federal conocen el objetivo de la meta nacional 3.1 y se coordinan con los actores sociales que apoyan al cumplimiento de ésta.",
        },
        {
          'codigo': '3.1.2',
          'periodo': '2025',
          'descripcion': "En 2025, se cuenta con una Hoja de ruta para el cumplimiento de la meta global 3, elaborada y consensuada por todos los actores vinculados a las ANP en sus distintos niveles.",
        },
        {
          'codigo': '3.1.3',
          'periodo': '2027',
          'descripcion': "Para 2027, se ha compilado la información geoespacial actualizada de todos los sistemas de áreas protegidas (federales, estatales y municipales).",
        },
        {
          'codigo': '3.1.4',
          'periodo': '2027',
          'descripcion': "En 2027, existe coordinación entre los sistemas de ANP federales, estatales y municipales.",
        },
        {
          'codigo': '3.1.5',
          'periodo': '2028',
          'descripcion': "En 2028 se conoce la superficie o número de áreas potenciales en buen estado de conservación, que contribuirán al cumplimiento de la meta nacional.",
        },
        {
          'codigo': '3.1.6',
          'periodo': '2029',
          'descripcion': "En 2029, los gobiernos estatales cuentan con un sistema para evaluar la efectividad del manejo de sus ANP.",
        },
        {
          'codigo': '3.1.7',
          'periodo': '2029',
          'descripcion': "En 2029, se realiza un conteo preliminar de la superficie de las ANP federales, estatales y municipales, que apoyarán al cumplimiento de la meta nacional.",
        },
        {
          'codigo': '3.1.8',
          'periodo': '2030',
          'descripcion':
              "En 2030, el gobierno federal ha incrementado la superficie marina protegida.",
        },
        {
          'codigo': '3.1.9',
          'periodo': '2030',
          'descripcion': "En 2030, el gobierno federal ha incrementado la superficie terrestre protegida.",
        },
      ];
      for (var i = 0; i < hitos31.length; i++) {
        final hito = hitos31[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '3.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref28,
        );
      }

      final ref29 = await insertarReferencia(
        pagina: 29,
        seccion: 'Meta Nacional 3.2 — Hitos',
      );
      const hitos32 = <Map<String, String>>[
        {
          'codigo': '3.2.1',
          'periodo': '2025',
          'descripcion': "Para 2025, el gobierno federal emite un Convenio de Colaboración Interinstitucional por el que se establecen los mecanismos de colaboración entre la Secretaría de Agricultura y Desarrollo Rural (agricultura) y la Secretaría de Medio Ambiente y Recursos Naturales (semarnat), que permita implementar estrategias y acciones interinstitucionales para impulsar y promover, en el ámbito de sus respectivas competencias, acciones que contribuyan a reconocer, registrar y dar seguimiento a las OMEC en México.",
        },
        {
          'codigo': '3.2.2',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025, en México se comienza un proceso de difusión y divulgación sobre el concepto oficial de OMEC, su importancia para el cumplimiento de la meta global 3 del Marco Mundial de Biodiversidad Kunming- Montreal.",
        },
        {
          'codigo': '3.2.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se establece un mecanismo para el Registro Nacional de OMEC en México (RENOM) y se crea el Comité Técnico de OMEC.",
        },
        {
          'codigo': '3.2.4',
          'periodo': '2026',
          'descripcion': "En 2026, se realiza el mapeo a nivel nacional de potenciales OMEC y se seleccionan las candidatas para su ingreso en la fase piloto del RENOM.",
        },
        {
          'codigo': '3.2.5',
          'periodo': '2027',
          'descripcion': "En 2027, se inicia el registro de OMEC en el RENOM y se reconocen áreas de interés para la conservación.",
        },
        {
          'codigo': '3.2.6',
          'periodo': '2028',
          'descripcion': "En 2028, se promueve la creación de un esquema de incentivos para OMEC, que estimula y beneficia su establecimiento y manejo apropiado.",
        },
        {
          'codigo': '3.2.7',
          'periodo': '2028',
          'descripcion': "En 2028, se realiza el conteo preliminar de las OMEC registradas en el RENOM.",
        },
        {
          'codigo': '3.2.8',
          'periodo': '2029',
          'descripcion': "En 2029, se realiza el primer reporte de OMEC en la Base de Datos Mundial de OMEC (WDOECM, por sus siglas en inglés).",
        },
      ];
      for (var i = 0; i < hitos32.length; i++) {
        final hito = hitos32[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '3.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref29,
        );
      }

      // -------------------------------------------------------------------
      // HITOS VERIFICADOS: METAS 7.1–8.2
      // Fuente: Guía Rápida 2026, pp. 46–56.
      // -------------------------------------------------------------------

      final ref46 = await insertarReferencia(
        pagina: 46,
        seccion: 'Meta Nacional 7.1 — Hitos',
      );
      const hitos71 = <Map<String, String>>[
        {
          'codigo': '7.1.1',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 en adelante, a través del proagua, se brinda asistencia técnica a solicitud de las entidades federativas o municipios para el establecimiento de sistemas de tratamiento de aguas residuales municipales.",
        },
        {
          'codigo': '7.1.2',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, se actualiza el inventario de infraestructura de tratamiento de aguas residuales municipales e industriales a nivel nacional.",
        },
        {
          'codigo': '7.1.3',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante se informan anualmente los resultados globales en la disminución de la contaminación generada por particulares y empresas cuya actividad preponderante sea servicios de alojamiento temporal y de preparación de alimentos y bebidas (clave scian 72) ubicadas en municipios al interior de la República.",
        },
        {
          'codigo': '7.1.4',
          'periodo': '2025',
          'descripcion': "Para 2025, se fortalece la red de monitoreo de calidad del agua a nivel nacional, priorizando el monitoreo de los ríos Tula, Lerma-Santiago y Atoyac.",
        },
        {
          'codigo': '7.1.5',
          'periodo': '2025',
          'descripcion':
              "Para 2025, se fortalecen las capacidades de inspección y vigilancia.",
        },
        {
          'codigo': '7.1.6',
          'periodo': '2026',
          'descripcion': "Para 2026, se formulan estrategias de prevención ambiental en cuatro cuencas prioritarias: Lerma-Santiago, Tula, Atoyac y Sonora.",
        },
        {
          'codigo': '7.1.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se fortalecen las capacidades de productores acuícolas en materia de sanidad acuícola, uso de antibióticos y otros medicamentos, prácticas de alimentación, entre otros.",
        },
        {
          'codigo': '7.1.8',
          'periodo': '2030',
          'descripcion': "Para 2030, se incluye información sobre integridad ecológica a partir de acciones de biomonitoreo y valoración de la calidad del hábitat como complemento a la valoración fisicoquímica en puntos de monitoreo a nivel nacional.",
        },
      ];
      for (var i = 0; i < hitos71.length; i++) {
        final hito = hitos71[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '7.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref46,
        );
      }

      final ref47 = await insertarReferencia(
        pagina: 47,
        seccion: 'Meta Nacional 7.2 — Hitos',
      );
      final ref48 = await insertarReferencia(
        pagina: 48,
        seccion: 'Meta Nacional 7.2 — Hitos',
      );
      const hitos72 = <Map<String, String>>[
        {
          'codigo': '7.2.1',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante se revisan y se cancelan, según proceda, los registros de ingredientes activos de plaguicidas registrados en México.",
        },
        {
          'codigo': '7.2.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se incorpora en el marco regulatorio la definición de Plaguicida Altamente Peligroso y disposiciones correspondientes para su identificación.",
        },
        {
          'codigo': '7.2.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se incorpora en el Reglamento plafest un esquema de renovación específico tomando en consideración la peligrosidad de los plaguicidas y tipo de vigencia para su nueva evaluación, para aquellos registros vigentes:",
        },
        {
          'codigo': '7.2.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se incorpora en el Reglamento plafest la evaluación de riesgo ecológico y a la salud humana como requisitos obligatorios para para otorgar o negar la autorización de los registros de plaguicidas altamente peligrosos.",
        },
        {
          'codigo': '7.2.5',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se cuenta con la actualización de las nom-232-ssa1-2009 (requisitos del envase, embalaje y etiquetado de plaguicidas); NOM-052-FITO-1995 (aplicación aérea de plaguicidas agrícolas), nom-034-fito-1995 (fabricación, formulación e importación de plaguicidas agrícolas), la nom-033-fito-2016 (especificaciones, criterios y procedimientos fitosanitarios para las personas físicas o morales que presten servicios de tratamientos fitosanitarios) y la nom-032-ssa2-2014 (para la vigilancia epidemiológica, promoción, prevención y control de las enfermedades transmitidas por vector).",
        },
        {
          'codigo': '7.2.6',
          'periodo': '2026',
          'descripcion': "Para 2026 habrá iniciado el proceso de mapeo de los PAP más comercializados en el país.",
        },
        {
          'codigo': '7.2.7',
          'periodo': '2026',
          'descripcion': "Para 2026, México cuenta con una estrategia de reducción y uso adecuado de plaguicidas para la agricultura.",
        },
        {
          'codigo': '7.2.8',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un sistema electrónico que implique información desde la importación, producción, formulación y hasta la comercialización de los PAP.",
        },
        {
          'codigo': '7.2.9',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un instrumento de gestión que permita la trazabilidad de los envases vacíos de plaguicidas a nivel nacional.",
        },
        {
          'codigo': '7.2.10',
          'periodo': '2027',
          'descripcion': "Para 2027, se impulsa la sustitución gradual de PAP por aquellas alternativas de plaguicida que demuestren la eficacia del producto y que no suponen un riesgo inaceptable para la salud humana o animal",
        },
        {
          'codigo': '7.2.11',
          'periodo': '2027',
          'descripcion': "Para 2027, se publica un estudio sobre los factores relacionados con las muertes masivas de abejas, cuantificando plaguicidas presentes en suelos.",
        },
        {
          'codigo': '7.2.12',
          'periodo': '2028',
          'descripcion': "Para 2028, se actualiza el Acuerdo por el que se da a conocer la lista de plaguicidas bioquímicos, microbianos, botánicos y misceláneos de riesgo reducido.",
        },
        {
          'codigo': '7.2.13',
          'periodo': '2028',
          'descripcion': "Para 2028, se cuenta con elementos de diseño de un plan de monitoreo ambiental de la presencia y concentración de PAP prioritarios.",
        },
      ];
      for (var i = 0; i < hitos72.length; i++) {
        final hito = hitos72[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '7.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 10 ? ref47 : ref48,
        );
      }

      final ref49 = await insertarReferencia(
        pagina: 49,
        seccion: 'Meta Nacional 7.3 — Hitos',
      );
      const hitos73 = <Map<String, String>>[
        {
          'codigo': '7.3.1',
          'periodo': '2024',
          'descripcion': "Para 2024, se regulan las importaciones de HFC en México, a través del trámite semarnat-2020-071-002-A.",
        },
        {
          'codigo': '7.3.2',
          'periodo': '2024–2025',
          'descripcion': "Para 2024-2025, inicia la implementación del Proyecto de reconversión de la manufacturera de equipos de refrigeración autocontenida de R-134a a hidrocarburo.",
        },
        {
          'codigo': '7.3.3',
          'periodo': '2024–2028',
          'descripcion': "Para 2024-2028, se fortalecen las capacidades de técnicas y técnicos en el sector de la refrigeración y aire acondicionado (rac), y se promueven acciones de evaluación y certificación conforme a estándares de competencias oficiales.",
        },
        {
          'codigo': '7.3.4',
          'periodo': '2024–2028',
          'descripcion': "Para 2024-2028, se coordinan y capacitan a las aduanas para prevenir el tráfico ilícito de HFC y se fortalece con equipamiento.",
        },
        {
          'codigo': '7.3.5',
          'periodo': '2024–2028',
          'descripcion': "Para 2024-2028, se realizan proyectos demostrativos en el sector comercial de refrigeración y aire acondicionado (instalación local y ensamble).",
        },
        {
          'codigo': '7.3.6',
          'periodo': '2026–2028',
          'descripcion': "Para 2026-2028, se realiza el proyecto de reconversión del sector espumas de poliuretano.",
        },
        {
          'codigo': '7.3.7',
          'periodo': '2026–2028',
          'descripcion': "Para 2026-2028, se fortalece el marco regulatorio y acciones de género.",
        },
        {
          'codigo': '7.3.8',
          'periodo': '2026–2028',
          'descripcion': "Para 2026-2028, se fortalece la red de centros de recuperación, reciclaje y regeneración de refrigerantes para el manejo de refrigerantes.",
        },
        {
          'codigo': '7.3.9',
          'periodo': '2030',
          'descripcion': "Para 2030, México habrá reducido 10% del consumo nacional de HFC, que equivale a reducir 7 698 266 de tCO₂e, a través del “Plan de reducción gradual del consumo nacional de HFC”.",
        },
      ];
      for (var i = 0; i < hitos73.length; i++) {
        final hito = hitos73[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '7.3',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref49,
        );
      }

      final ref50 = await insertarReferencia(
        pagina: 50,
        seccion: 'Meta Nacional 7.4 — Hitos',
      );
      const hitos74 = <Map<String, String>>[
        {
          'codigo': '7.4.1',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025, se desarrolla el Plan de eliminación del consumo nacional de HCFC, para eliminar 100% de su consumo al 1 de enero de 2030, en el marco de la implementación del Protocolo de Montreal para contribuir a reducir el efecto de las sustancias que dañan la capa de ozono².",
        },
        {
          'codigo': '7.4.2',
          'periodo': '2030',
          'descripcion': "Al 2030, se contribuye a la protección de la salud humana y a los ecosistemas de los efectos dañinos de los rayos ultravioleta del Sol.",
        },
      ];
      for (var i = 0; i < hitos74.length; i++) {
        final hito = hitos74[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '7.4',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref50,
        );
      }

      final ref51 = await insertarReferencia(
        pagina: 51,
        seccion: 'Meta Nacional 7.5 — Hitos',
      );
      final ref52 = await insertarReferencia(
        pagina: 52,
        seccion: 'Meta Nacional 7.5 — Hitos',
      );
      const hitos75 = <Map<String, String>>[
        {
          'codigo': '7.5.1',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante se informan anualmente los resultados globales en la disminución de la contaminación de las empresas ubicadas en municipios costeros cuya actividad preponderante sea servicios de alojamiento temporal y de preparación de alimentos y bebidas (clave sican 72).",
        },
        {
          'codigo': '7.5.2',
          'periodo': '2025',
          'descripcion': "Para 2025, México se adhiere al proyecto procaribe para aumentar la colaboración con la región.",
        },
        {
          'codigo': '7.5.3',
          'periodo': '2025–2026',
          'descripcion': "Para 2025 y 2026, se determina y evalúa la calidad del agua en al menos cuatro desembocaduras que vierten al Golfo de México.",
        },
        {
          'codigo': '7.5.4',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, a través del SIMAR se fortalecen y actualizan diversos índices de calidad del agua en ambientes marino-costeros (marea roja, sargazo) mediante herramientas satelitales.",
        },
        {
          'codigo': '7.5.5',
          'periodo': '2025 en adelante',
          'descripcion': "De 2025 y en adelante, se coordinan acciones para fortalecer el monitoreo de las zonas marino-costeras contaminadas, incluida la red de monitoreo de calidad del agua a nivel nacional.",
        },
        {
          'codigo': '7.5.6',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, a través del geopesca y otras herramientas o acciones, se fortalecen y actualizan diversos índices de calidad del agua en ambientes marino-costeros in situ de México.",
        },
        {
          'codigo': '7.5.7',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se identifican a las empresas que cuentan con título de concesión y se sitúan en estados costeros; se verifica que cumplan con los lineamientos a los que estén sujetos.",
        },
        {
          'codigo': '7.5.8',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se implementan el plan nacional y los planes locales o regionales para la atención de contingencias por derrames petroleros, y se fortalecen y mejoran con base en las lecciones aprendidas.",
        },
        {
          'codigo': '7.5.9',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se reciben y atienden las denuncias por irregularidades en el uso del agua, que se ubiquen en cuencas de estados costeros, a través del podan.",
        },
        {
          'codigo': '7.5.10',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se continúa el proyecto de reciclado de artes de pesca y se inicia el proyecto de remoción de artes de pesca fantasma, en particular en el Alto Golfo de California.",
        },
        {
          'codigo': '7.5.11',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se implementan campañas de manejo de residuos en áreas naturales protegidas (ANP) marino-costeras.",
        },
        {
          'codigo': '7.5.12',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, en cumplimiento de los tratados internacionales, se llevan a cabo inspecciones para la prevención de la contaminación por aguas de lastre y descargas de aguas residuales provenientes de embarcaciones.",
        },
        {
          'codigo': '7.5.13',
          'periodo': '2025–2030',
          'descripcion': "Para 2025 y progresivamente hacia 2030, se implementa y se da continuidad al programa de limpieza y conservación de playas, se realizan campañas de sensibilización sobre el manejo de residuos que afectan a zonas marino-costeras.",
        },
        {
          'codigo': '7.5.14',
          'periodo': '2026 en adelante',
          'descripcion': "A partir de 2026, se implementan las estrategias identificadas para revertir y controlar la contaminación en ambientes marino costeros identificados en la Política Nacional para el Manejo Sustentable de Mares y Costas de México, en línea con la meta nacional 1.3.",
        },
        {
          'codigo': '7.5.15',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se realizan visitas de inspección a desarrollos inmobiliarios que están localizados en los 17 estados con litoral costero, con el objeto de verificar el tratamiento de sus aguas residuales y su disposición final.",
        },
        {
          'codigo': '7.5.16',
          'periodo': '2030',
          'descripcion': "Para 2030, se da seguimiento y supervisión a programas para el cumplimiento de la nom-001-semarnat 2021 y los permisos de descarga, de manera que los sujetos regulados que se encuentran ubicados en estados costeros cumplan con el marco normativo de calidad de sus descargas; de acuerdo con los recursos humanos, financieros y materiales con que cuente la conagua.",
        },
        {
          'codigo': '7.5.17',
          'periodo': '2030',
          'descripcion': "Para 2030, se refuerzan los mecanismos e instrumentos para la conservación de los ambientes marino-costeros, mediante el otorgamiento de superficies de Zona Federal Marítimo Terrestre y Ambientes Costeros, a través de la planificación territorial y el otorgamiento de Destinos y Concesiones para el uso de protección.",
        },
        {
          'codigo': '7.5.18',
          'periodo': '2030',
          'descripcion': "Para 2030, se mejora la calidad de agua de la desembocadura del Lerma-Santiago, disminuyendo el aporte de contaminantes a los ecosistemas marinos y costeros, en línea con la meta nacional 7.1.",
        },
        {
          'codigo': '7.5.19',
          'periodo': '2030',
          'descripcion': "Para 2030, se cuenta con un proyecto de elaboración de nmx para el monitoreo y análisis de microplásticos en ambientes acuáticos, incluyendo marinos.",
        },
        {
          'codigo': '7.5.20',
          'periodo': '2030',
          'descripcion': "Para 2030 se consolidará un Polo de Economía Circular para el Sargazo en Quintana Roo, que integre la recolección oceánica y su aprovechamiento productivo bajo un esquema de atención integral y sustentable.",
        },
      ];
      for (var i = 0; i < hitos75.length; i++) {
        final hito = hitos75[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '7.5',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 6 ? ref51 : ref52,
        );
      }

      final ref54 = await insertarReferencia(
        pagina: 54,
        seccion: 'Meta Nacional 8.1 — Hitos',
      );
      final ref55 = await insertarReferencia(
        pagina: 55,
        seccion: 'Meta Nacional 8.1 — Hitos',
      );
      const hitos81 = <Map<String, String>>[
        {
          'codigo': '8.1.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se publica el Programa Nacional Hídrico con un eje particular sobre adaptación al cambio climático.",
        },
        {
          'codigo': '8.1.2',
          'periodo': '2025',
          'descripcion': "Para 2025, se presenta la actualización de la tercera contribución determinada a nivel nacional (ndc 3.0) con los compromisos de adaptación al cc, asumidos por México (ante la CMNUCC) que considera los temas de conservación, restauración, uso sostenible de la biodiversidad y los servicios ecosistémicos, sistemas productivos resilientes y seguridad alimentaria y gestión de los recursos hídricos; temas que están integrados en los ejes C, B y D.",
        },
        {
          'codigo': '8.1.3',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se promueven SbN y AbE mediante la instrumentación el Programa Nacional de Restauración Ambiental 2025-2030.",
        },
        {
          'codigo': '8.1.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se presenta la actualización del Programa Especial de Cambio Climático (pecc), con la integración de objetivos, estrategias, acciones y metas para la adaptación al cambio climático, integrando el enfoque de género y abarcando medidas de conservación, restauración y aprovechamiento sustentable de la biodiversidad, los ecosistemas y los servicios que proveen.",
        },
        {
          'codigo': '8.1.5',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se integran las SbN en los instrumentos de ordenamiento territorial y ecológico, poniendo al centro a los ecosistemas en la planificación de los asentamientos humanos, considerando diversos escenarios de cambio climático (en línea con la C 6.1 de la ndc 3.0).",
        },
        {
          'codigo': '8.1.6',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, en colaboración con otras instituciones, se integran y analizan datos para evaluar la exposición climática futura de grupos de especies relevantes para la conservación y restauración, identificando su vulnerabilidad frente al cambio climático.",
        },
        {
          'codigo': '8.1.7',
          'periodo': '2027',
          'descripcion': "Para 2027, el Atlas Nacional de Vulnerabilidad ante el Cambio Climático se actualiza hacia una Plataforma Nacional de Riesgos y Adaptación ante el Cambio Climático, orientada a integrar y sistematizar información actualizada sobre escenarios de cambio climático, riesgos, impactos observados y proyectados, así como medidas de adaptación.",
        },
        {
          'codigo': '8.1.8',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un instrumento de política pública en adaptación al cambio climático (nap, por sus siglas en inglés), que articula actores, sectores y opera medidas de adaptación, considerando los temas de gestión de los recursos hídricos, conservación, restauración y uso sustentable de la biodiversidad y los servicios ecosistémicos, sistemas productivos resilientes y seguridad alimentaria; con enfoque de SbN.",
        },
        {
          'codigo': '8.1.9',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con una actualización de la dinámica de la línea de costa asociada a manglares.",
        },
        {
          'codigo': '8.1.10',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un diagnóstico de vulnerabilidad del sector acuícola ante el cc.",
        },
        {
          'codigo': '8.1.11',
          'periodo': '2027',
          'descripcion': "Para 2027, Se actualiza el Atlas de vulnerabilidad hídrica en México ante el cc.",
        },
        {
          'codigo': '8.1.12',
          'periodo': '2030',
          'descripcion': "Al 2030 se implementan, medidas de adaptación en áreas naturales protegidas (ANP) federales y sus zonas de influencia con alto riesgo ante el cambio climático a nivel nacional.",
        },
        {
          'codigo': '8.1.13',
          'periodo': '2030',
          'descripcion': "Para 2030, se promueven medidas de adaptación SbN y AbE mediante la implementación del Programa Nacional de Auditoría Ambiental, la Estrategia Nacional de Prevención Ambiental y otras medidas de autorregulación.",
        },
      ];
      for (var i = 0; i < hitos81.length; i++) {
        final hito = hitos81[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '8.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 7 ? ref54 : ref55,
        );
      }
      const subhitos812 = <Map<String, String>>[
      ];
      for (var i = 0; i < subhitos812.length; i++) {
        final subhito = subhitos812[i];
        await insertarSubhito(
          codigo: subhito['codigo']!,
          hito: '8.1.12',
          descripcion: subhito['descripcion']!,
          orden: i + 1,
          referenciaOrigenId: ref55,
        );
      }

      final ref56 = await insertarReferencia(
        pagina: 56,
        seccion: 'Meta Nacional 8.2 — Hitos',
      );
      const hitos82 = <Map<String, String>>[
        {
          'codigo': '8.2.1',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se promueve esquemas de conservación y manejo sustentable de los ecosistemas forestales, en la línea con la línea de acción del C.1 (líneas C. 1.1. a la C.1.6 de la ndc 3.0).",
        },
        {
          'codigo': '8.2.2',
          'periodo': '2025–2030',
          'descripcion': "Para 2025 y al 2030, se promueve la producción y uso de bienes duraderos derivados de la madera, impulsando cadenas de valor sustentables y el desarrollo de economías locales (en línea con la acción 7.5.1. de la ndc y la meta nacional 9.0).",
        },
        {
          'codigo': '8.2.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se actualiza el mapa de distribución de manglares en México, incorporando las tendencias de verdor de la vegetación, para el monitoreo de los acervos de carbono azul (en línea con el hito 21.1.11 de la meta nacional 21.1).",
        },
        {
          'codigo': '8.2.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se publica la Guía de Monitoreo de Áreas de Restauración de Manglar: un enfoque espaciotemporal.",
        },
        {
          'codigo': '8.2.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se publica el Programa Especial de Cambio Climático (pecc) con líneas de acción específicas para reducir emisiones a través de soluciones basadas en la naturaleza (SbN).",
        },
        {
          'codigo': '8.2.6',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con una propuesta metodológica para el monitoreo de manglares, incluyendo su cobertura geográfica y principales atributos dasométricos con el propósito de determinar acervos de carbono.",
        },
        {
          'codigo': '8.2.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se diseñan mecanismos de compensación y neutralización de emisiones de los sectores productivos que contribuyan a la implementación del Programa Nacional de Restauración Ambiental (en línea con la C. 7.4.1de la ndc 3.0).",
        },
        {
          'codigo': '8.2.8',
          'periodo': '2030',
          'descripcion': "Para 2030, se cuenta con la Estrategia Nacional de Carbono Azul, en línea con la estrategia 4.4. de la Política Nacional para el Manejo Sustentable de Mares y Costas de México (PNMSMCM), así como con la C.4.3. del eje C del componente de adaptación de la ndc 3.0.",
        },
        {
          'codigo': '8.2.9',
          'periodo': '2030',
          'descripcion': "Para 2030, se encuentra publicada la información de sitios de humedales costeros con datos publicados sobre carbono orgánico, a través del Sistema de Monitoreo de Humedales en México (simoh-mx), en línea con el subhito 21.1.1.10 de la meta nacional 21.1 y con la línea C.2.4. del componente de Adaptación de la ndc 3.0.",
        },
      ];
      for (var i = 0; i < hitos82.length; i++) {
        final hito = hitos82[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '8.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref56,
        );
      }

      final ref60 = await insertarReferencia(
        pagina: 60,
        seccion: 'Meta Nacional 9.0 — Hitos',
      );
      const hitos90 = <Map<String, String>>[
        {
          'codigo': '9.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se crea un grupo para la coordinación y seguimiento de la meta, integrado con los enlaces que se designe por cada una de las dependencias identificadas como participantes en esta meta, en el marco de sus atribuciones y especies de atención.",
        },
        {
          'codigo': '9.0.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se identifican criterios para seleccionar las especies o grupos de especies silvestres nativas cuyas cadenas de valor requieren ser fortalecidas.",
        },
        {
          'codigo': '9.0.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se identifican las necesidades de fortalecimiento y se elaboran los planes de trabajo para fortalecer las cadenas de valor, incluidas las estrategias de difusión, considerando las plataformas con las que cuentan las dependencias como conafor, agricultura, entre otras (semarnat-dgvs, semarnat-dggfsoe, conabio-ac cites, conabio-carb, conafor, conapesca e imipas).",
        },
        {
          'codigo': '9.0.4',
          'periodo': '2027',
          'descripcion': "Para 2027, se implementan los planes de trabajo para el fortalecimiento de las cadenas de valor.",
        },
        {
          'codigo': '9.0.5',
          'periodo': '2027',
          'descripcion': "Para 2027, se incentivan los centros de producción sustentable como las unidades de manejo para la conservación de la vida silvestre (UMA), los predios o instalaciones que manejan vida silvestre (PIMVS), los predios bajo manejo forestal, los centros de almacenamiento y transformación de materias primas forestales (cat), upas, entre otros.",
        },
        {
          'codigo': '9.0.6',
          'periodo': '2027',
          'descripcion': "Para 2027, se realiza el seguimiento y evaluación a los planes de fortalecimiento de las cadenas de valor, con periodicidad bianual.",
        },
        {
          'codigo': '9.0.7',
          'periodo': '2027 en adelante',
          'descripcion': "Para 2027 y en adelante, se difunden los avances, lecciones aprendidas y casos de éxito de las 10 cadenas de valor consideradas en esta meta.",
        },
      ];
      for (var i = 0; i < hitos90.length; i++) {
        final hito = hitos90[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '9.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref60,
        );
      }

      final ref62 = await insertarReferencia(
        pagina: 62,
        seccion: 'Meta Nacional 10.1 — Hitos',
      );
      const hitos101 = <Map<String, String>>[
        {
          'codigo': '10.1.1',
          'periodo': '2025',
          'descripcion':
              "Para 2025, se impulsa la producción sustentable en Unidades de Producción.",
        },
        {
          'codigo': '10.1.2',
          'periodo': '2025',
          'descripcion': "Para 2025, se promueve la conservación y el manejo sustentable de los suelos.",
        },
        {
          'codigo': '10.1.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se cuenta con una estrategia nacional para impulsar la transición agroecológica a través de las escuelas de campo (eca).",
        },
        {
          'codigo': '10.1.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se incrementarán el número de productores en las eca que implementan prácticas agroecológicas.",
        },
        {
          'codigo': '10.1.5',
          'periodo': '2027',
          'descripcion': "Para 2027, se implementarán en las uni-dades de producción agrícolas alternativas al uso del fuego y reporte de incendios.",
        },
      ];
      for (var i = 0; i < hitos101.length; i++) {
        final hito = hitos101[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '10.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref62,
        );
      }

      final ref63 = await insertarReferencia(
        pagina: 63,
        seccion: 'Meta Nacional 10.2 — Hitos',
      );
      const hitos102 = <Map<String, String>>[
        {
          'codigo': '10.2.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se establece una estimación de una línea base sobre las UPP que lleven a cabo alguna práctica sustentable.",
        },
        {
          'codigo': '10.2.2',
          'periodo': '2025',
          'descripcion': "Para 2025, se fortalece la colaboración entre la Secretaría de Agricultura y Desarrollo Rural (agricultura) y la Comisión Nacional Forestal (CONAFOR) con la finalidad de impulsar sistemas silvopastoriles sustentables en México, promoviendo esquemas de cooperación técnica y prácticas libres de deforestación.",
        },
        {
          'codigo': '10.2.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se definen criterios y prácticas que permitan considerar a las Unidades de Producción Pecuarias (UPP) como sustentables con la biodiversidad, incorporando alternativas productivas al uso del fuego para prevenir incendios en actividades agropecuarias.",
        },
        {
          'codigo': '10.2.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se fortalece el sistema de monitoreo y vigilancia (trazabilidad) de la ganadería bovina para la producción libre de deforestación.",
        },
        {
          'codigo': '10.2.5',
          'periodo': '2027',
          'descripcion': "Para 2027, se incrementan las UPP con prácticas pecuarias sustentables.",
        },
        {
          'codigo': '10.2.6',
          'periodo': '2028',
          'descripcion': "Para el 2028, se contará con un Inventario Nacional de la Biodiversidad de las tierras de uso ganadero para la planeación y toma de decisiones que promuevan la conservación de la biodiversidad.",
        },
      ];
      for (var i = 0; i < hitos102.length; i++) {
        final hito = hitos102[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '10.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref63,
        );
      }

      final ref64 = await insertarReferencia(
        pagina: 64,
        seccion: 'Meta Nacional 10.3 — Hitos',
      );
      const hitos103 = <Map<String, String>>[
        {
          'codigo': '10.3.1',
          'periodo': '2024–2030',
          'descripcion': "Entre 2024 y 2030, se realizan Censos de Unidades Acuícolas en al menos diez cuerpos de agua con cultivos acuícolas.",
        },
        {
          'codigo': '10.3.2',
          'periodo': '2024–2030',
          'descripcion': "Entre 2024 y 2030, se realizan al menos diez estudios de capacidad de carga acuícola en embalses con pesquerías acuaculturales y/o cultivos acuícolas, y/o cuerpos de agua con unidades de producción acuícola (sujeto a disponibilidad presupuestal).",
        },
        {
          'codigo': '10.3.3',
          'periodo': '2025–2030',
          'descripcion': "A partir de 2025, se otorga apoyo a productores acuícolas mediante capacitación, a través del Programa de Asistencia Técnica Autogestiva, promoviendo la adopción de prácticas sustentables (en total, 640 productores como mínimo al 2030).",
        },
        {
          'codigo': '10.3.4',
          'periodo': '2030',
          'descripcion': "Para 2030, se promueven al menos cuatro planes de manejo acuícola sustentable.",
        },
        {
          'codigo': '10.3.5',
          'periodo': '2030',
          'descripcion': "Para 2030, se regularizarán al menos el 50% de las unidades acuícolas que se censaron sin título acuícola, en al menos diez cuerpos de agua con cultivo acuícola.",
        },
        {
          'codigo': '10.3.6',
          'periodo': '2030',
          'descripcion': "Para 2030, se han publicado 120 nuevas fichas o actualizaciones de fichas existentes de especies, artes de cultivo y estudios de capacidad de carga, en la Carta Nacional Acuícola.",
        },
        {
          'codigo': '10.3.7',
          'periodo': '2030',
          'descripcion': "Para 2030, se han emitido al menos un nuevo instrumento normativo (por ejemplo, Normas Oficiales Mexicanas -nom-) sobre el monitoreo y seguimiento (trazabilidad) y mejora de la sustentabilidad en acuacultura.",
        },
        {
          'codigo': '10.3.8',
          'periodo': '2030',
          'descripcion': "Para 2030, se han impartido capacitaciones en temas de buenas prácticas acuícolas a 24 productores de por lo menos 24 unidades de producción acuícola (upa).",
        },
        {
          'codigo': '10.3.9',
          'periodo': '2030',
          'descripcion': "Para 2030, se han realizado transferencias tecnológicas para la producción acuícola a por lo menos 24 upa.",
        },
        {
          'codigo': '10.3.10',
          'periodo': '2030',
          'descripcion': "Para 2030, se han realizado al menos 12 proyectos de investigación sobre especies nativas en acuacultura sustentable y/o regenerativa.",
        },
        {
          'codigo': '10.3.11',
          'periodo': '2030',
          'descripcion': "Para 2030, se incrementa, a través de las Escuelas de Campo Acuícola, las unidades de producción que llevan a cabo mejores prácticas acuícolas sustentables.",
        },
      ];
      for (var i = 0; i < hitos103.length; i++) {
        final hito = hitos103[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '10.3',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref64,
        );
      }

      final ref65 = await insertarReferencia(
        pagina: 65,
        seccion: 'Meta Nacional 10.4 — Hitos',
      );
      const hitos104 = <Map<String, String>>[
        {
          'codigo': '10.4.1',
          'periodo': '2025 en adelante',
          'descripcion': "A partir del 2025, se promueve el fortalecimiento de proyectos de mejora pesquera (fip, por sus siglas en inglés), mediante alianzas estratégicas entre diferentes actores, con la finalidad de mejorar la explotación y manejo de especies marinas, de tal forma que se pueda encaminar hacia la sustentabilidad.",
        },
        {
          'codigo': '10.4.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se promueve la actualización de las fichas técnicas de la Carta Nacional Pesquera, que así lo requieran, así como la adición de nuevas fichas de recursos específicos, para fortalecerla como un instrumento que contenga el diagnóstico y evaluación integral de la actividad pesquera, así como de los indicadores sobre la disponibilidad y conservación de los recursos pesqueros, en aguas de jurisdicción federal.",
        },
        {
          'codigo': '10.4.3',
          'periodo': '2027',
          'descripcion': "Para 2027, se han actualizado o publicado nuevos acuerdos regulatorios de vedas, cuotas de captura o de temas específicos, para cumplir con el marco regulatorio pesquero internacional.",
        },
        {
          'codigo': '10.4.4',
          'periodo': '2029',
          'descripcion': "Para 2029, se han actualizado las Normas Oficiales Mexicanas (nom) y se han publicado al menos tres nuevas nom para regular el aprovechamiento sustentable de recursos pesqueros de México.",
        },
        {
          'codigo': '10.4.5',
          'periodo': '2030',
          'descripcion': "Para 2030, México cuenta con al menos 15 nuevos acuerdos de Zonas de Refugio Pesquero (ZRP) decretadas en el territorio nacional, en al menos tres estados diferentes a los ya vigentes, mismos que promueven la recuperación de los recursos acuáticos de interés comercial, la restauración de ecosistemas, el fortalecimiento de la gobernanza y la mitigación del cambio climático.",
        },
        {
          'codigo': '10.4.6',
          'periodo': '2030',
          'descripcion': "Al 2030, se publican o actualizan nuevos Planes de Manejo Pesquero (pmp) que promuevan las acciones encaminadas al desarrollo de la actividad pesquera de forma equilibrada, integral y sustentable, basadas en el conocimiento actualizado de los aspectos biológicos, ecológicos, pesqueros, ambientales, económicos, culturales y sociales.",
        },
      ];
      for (var i = 0; i < hitos104.length; i++) {
        final hito = hitos104[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '10.4',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref65,
        );
      }

      final ref66 = await insertarReferencia(
        pagina: 66,
        seccion: 'Meta Nacional 10.5 — Hitos',
      );
      const hitos105 = <Map<String, String>>[
        {
          'codigo': '10.5.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se ha identificado la superficie susceptible a incorporarse o reincorporarse al manejo forestal sustentable y se comienza a realizar una actualización periódica en los siguientes años.",
        },
        {
          'codigo': '10.5.2',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, la Secretaría del Medio Ambiente y Recursos Naturales (semarnat) simplifica los trámites en materia de manejo forestal sustentable para el incremento de la superficie autorizada, a fin de que los resolutivos se otorguen de manera oportuna.",
        },
        {
          'codigo': '10.5.3',
          'periodo': '2025',
          'descripcion': "Para 2025, se fortalece el mecanismo de coordinación que facilita la comunicación interinstitucional para agilizar la autorización de programas de manejo para el seguimiento a la política del manejo forestal sustentable.",
        },
        {
          'codigo': '10.5.4',
          'periodo': '2025 en adelante',
          'descripcion': "Para 2025 y en adelante, se fortalece la gobernanza de las personas dueñas y poseedoras de predios bajo manejo forestal.",
        },
        {
          'codigo': '10.5.5',
          'periodo': '2025',
          'descripcion': "Para 2025, se fortalecen los sistemas informáticos que permiten brindar una transparencia proactiva en materia de superficie bajo manejo y producción forestal. Lo anterior para el monitoreo y toma de decisiones en materia de política forestal.",
        },
        {
          'codigo': '10.5.6',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se incrementa la participación efectiva de las mujeres en la gestión sustentable de la silvicultura y de los recursos naturales en general.",
        },
        {
          'codigo': '10.5.7',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 y en adelante, se fortalecen e incrementan las estrategias para fomentar y mejorar los mercados de materias primas y productos forestales maderables y no maderables, con la finalidad de fomentar el consumo de productos forestales provenientes de predios bajo manejo sustentable.",
        },
        {
          'codigo': '10.5.8',
          'periodo': '2028',
          'descripcion': "Para 2028, se cuenta con un Sistema Nacional de Gestión Forestal actualizado y eficiente para la captura, sistematización, georreferenciación y generación de información sobre la superficie, volumen y autorizaciones de aprovechamiento forestal.",
        },
      ];
      for (var i = 0; i < hitos105.length; i++) {
        final hito = hitos105[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '10.5',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref66,
        );
      }

      final ref68 = await insertarReferencia(
        pagina: 68,
        seccion: 'Meta Nacional 11.0 — Hitos',
      );
      const hitos110 = <Map<String, String>>[
        {
          'codigo': '11.0.1',
          'periodo': '2025–2026 en adelante',
          'descripcion': "Para 2025–2026 y en adelante, se fortalece la inspección y vigilancia ambiental con enfoque de justicia ambiental en sectores y territorios prioritarios (forestal, minero y costero), y se implementa una metodología para valorar integralmente la biodiversidad y establecer compensaciones socioambientalmente justas.",
        },
        {
          'codigo': '11.0.2',
          'periodo': '2030',
          'descripcion': "Para 2030, México cuenta con al menos 15 nuevos acuerdos de Zonas de Refugio Pesquero (ZRP) establecidos en al menos tres estados diferentes a los ya vigentes, mismos que promueven la protección y conservación de los recursos acuáticos de interés comercial, la restauración de los ecosistemas, el fortalecimiento de la gobernanza y la mitigación del cambio climático.",
        },
        {
          'codigo': '11.0.3',
          'periodo': '2030',
          'descripcion': "Para 2030, México incrementa al 30% la superficie terrestre protegida y al 30% la superficie marina, de manera efectiva a través de los sistemas de áreas naturales protegidas (ANP) federales, estatales y municipales.",
        },
        {
          'codigo': '11.0.4',
          'periodo': '2030',
          'descripcion': "Para 2030, se implementa el sistema nacional de reconocimiento, registro, monitoreo, evaluación y reporte de otras medidas efectivas de conservación basadas en áreas (OMEC).",
        },
        {
          'codigo': '11.0.5',
          'periodo': '2030',
          'descripcion': "Para 2030, se incorporan 1.2 millones de hectáreas al programa de pago por servicios ambientales (PSA) a cargo de la Comisión Nacional Forestal (CONAFOR).",
        },
        {
          'codigo': '11.0.6',
          'periodo': '2026 en adelante',
          'descripcion': "Para 2026 en adelante, se fortalecen e incrementan las estrategias de mercado de materias primas y productos forestales maderables y no maderables, con la finalidad de fomentar el consumo de productos forestales bajo manejo sustentable.",
        },
        {
          'codigo': '11.0.7',
          'periodo': '2025 y bienalmente',
          'descripcion': "Para 2025, y de manera bienal, se actualizan y mejoran las cuentas de los ecosistemas de México para la evaluación, fortalecimiento e integración de criterios de conservación y uso sustentable de la biodiversidad en las políticas de uso territorial de todos los sectores.",
        },
        {
          'codigo': '11.0.8',
          'periodo': '2030',
          'descripcion': "Al 2030, la restauración ambiental se ha convertido en una política pública prioritaria (meta nacional 2.1).",
        },
      ];
      for (var i = 0; i < hitos110.length; i++) {
        final hito = hitos110[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '11.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref68,
        );
      }

      final ref70 = await insertarReferencia(
        pagina: 70,
        seccion: 'Meta Nacional 12.0 — Hitos',
      );
      const hitos120 = <Map<String, String>>[
        {
          'codigo': '12.0.1',
          'periodo': '2024',
          'descripcion': "Al 2024, se publica la Norma Oficial Mexicana nom-003-sedatu-2023 Que establece los lineamientos para el fortalecimiento del sistema territorial para resistir, adaptarse y recuperarse, ante amenazas de origen natural y del cambio climático a través del ordenamiento territorial, visualizando al territorio como un solo sistema interconectado que promueve la conservación de la biodiversidad.",
        },
        {
          'codigo': '12.0.2',
          'periodo': '2025',
          'descripcion': "Al 2025, se implementa una estrategia de comunicación y capacitación en los estados y municipios para el cumplimiento de la nom-003-sedatu-2023.",
        },
        {
          'codigo': '12.0.3',
          'periodo': '2026',
          'descripcion': "Al 2026, los estados y municipios incorporan los lineamientos de la nom-003-sedatu-2023 a sus programas y planes de ordenamiento territorial, ecológico y de desarrollo urbano, así como en los planes de acción climática, entre otras políticas; promoviendo la conservación y uso sustentable de la biodiversidad, el manejo integral del agua, la conectividad ecológica y la calidad de las áreas verdes y azules.",
        },
        {
          'codigo': '12.0.4',
          'periodo': '2027',
          'descripcion': "Al 2027, los estados y municipios inician la armonización de su normatividad local, conforme a los lineamientos establecidos por la nom-003-sedatu-2023.",
        },
        {
          'codigo': '12.0.5',
          'periodo': '2028',
          'descripcion': "Al 2028, se implementa un método de evaluación de los avances de integración de criterios ambientales y de biodiversidad en las políticas, conforme lo establecido en la nom-003-sedatu-2023 y como refuerzo del proceso para dar cumplimiento a la Norma.",
        },
        {
          'codigo': '12.0.6',
          'periodo': '2029 en adelante',
          'descripcion': "Al 2029 y en adelante, se desarrollan acciones de fortalecimiento de capacidades para continuar sumando a gobiernos estatales y municipales al cumplimiento de la nom-003-sedatu-2023, considerando los resultados de la evaluación de avances realizada previamente y, de esta manera, aumentar la superficie y la calidad de áreas verdes y azules. ",
        },
      ];
      for (var i = 0; i < hitos120.length; i++) {
        final hito = hitos120[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '12.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref70,
        );
      }

      final ref72 = await insertarReferencia(
        pagina: 72,
        seccion: 'Meta Nacional 13.0 — Hitos',
      );
      final ref73 = await insertarReferencia(
        pagina: 73,
        seccion: 'Meta Nacional 13.0 — Hitos',
      );
      const hitos130 = <Map<String, String>>[
        {
          'codigo': '13.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se reactiva el punto focal nacional (pfn) y se establece el procedimiento transitorio Proceso de Implementación del Protocolo de Nagoya en México: Un Enfoque en la Investigación Científica para la Conservación publicado en el Centro de Intercambio de Información sobre Acceso y Participación en los Beneficios (apb).",
        },
        {
          'codigo': '13.0.2',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con la propuesta de modificación al artículo 87 Bis de la Ley General del Equilibrio Ecológico y la Protección al Ambiente (LGEEPA) con el cual se posibilita la elaboración de un reglamento sobre acceso a los recursos genéticos y distribución justa y equitativa en los beneficios que se deriven de su utilización.",
        },
        {
          'codigo': '13.0.3',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con un borrador del Reglamento de la LGEEPA sobre acceso a los recursos genéticos y distribución justa y equitativa en los beneficios que se deriven de su utilización.",
        },
        {
          'codigo': '13.0.4',
          'periodo': '2025',
          'descripcion': "Para el 2025, se inicia la consultoría “Generación, recopilación y análisis de información para la generación de elementos y recomendaciones para la elaboración del Primer Informe Nacional sobre la implementación del Protocolo de Nagoya en México y su regulación a nivel nacional” como parte del proyecto GEF 11908 - Apoyo a la preparación del primer informe nacional sobre la aplicación del Protocolo de Nagoya sobre el acceso a los recursos genéticos y la distribución justa y equitativa de los beneficios derivados de su utilización.",
        },
        {
          'codigo': '13.0.5',
          'periodo': '2026',
          'descripcion': "Para el 2026, se cuenta con la reactivación del Grupo Intersecretarial coordinado por el pfn.",
        },
        {
          'codigo': '13.0.6',
          'periodo': '2026',
          'descripcion': "Para el 2026, se cuenta con principios de política pública y elementos de coordinación sobre recursos genéticos y distribución de los beneficios derivados que delinean el papel de las dependencias involucradas en la implementación del Protocolo de Nagoya.",
        },
        {
          'codigo': '13.0.7',
          'periodo': '2026',
          'descripcion': "Para 2026, se publica en el Diario Oficial de la Federación el Reglamento de la LGEEPA sobre acceso a los recursos genéticos y distribución justa y equitativa en los beneficios que se deriven de su utilización.",
        },
        {
          'codigo': '13.0.8',
          'periodo': '2026',
          'descripcion': "Para 2026, se desarrollará, habilitará y pondrá en operación el Registro Nacional de Acceso a los Recursos Genéticos.",
        },
        {
          'codigo': '13.0.9',
          'periodo': '2026',
          'descripcion': "Para 2026, se hace difusión a usuarios y proveedores sobre los alcances de la aplicación del Protocolo de Nagoya en cuanto a la utilización, el acceso y la distribución de beneficios resultantes de la utilización de los recursos genéticos, sus derivados, conocimientos tradicionales asociados.",
        },
        {
          'codigo': '13.0.10',
          'periodo': '2027',
          'descripcion': "Para 2027, desarrollo y publicación de la legislación secundaria asociada al Reglamento.",
        },
        {
          'codigo': '13.0.11',
          'periodo': '2027',
          'descripcion': "Para el 2027, se cuenta con un plan de capacitación para los diferentes sectores regulados (administración pública federal, usuarios y proveedores) de manera que se promueva el cumplimiento de las disposiciones jurídicas de la materia.",
        },
        {
          'codigo': '13.0.12',
          'periodo': '2028',
          'descripcion': "Para 2028, se cuenta con lineamientos para la aplicación del Consentimiento Fundamentado Previo (cfp) y las Condiciones Mutuamente Acordadas (cma) considerando la participación de todos los actores involucrados.",
        },
        {
          'codigo': '13.0.13',
          'periodo': '2028',
          'descripcion': "Para 2028, se cuenta con un sistema nacional de monitoreo y vigilancia de la utilización de los recursos genéticos en las diferentes etapas de investigación y desarrollo, entre ellas innovación, precomercialización, comercialización, así como para el cumplimiento de las cma y la distribución de beneficios.",
        },
        {
          'codigo': '13.0.14',
          'periodo': '2029',
          'descripcion': "Para 2029, se cuenta con autoridades nacionales competentes capacitadas, al igual que usuarios y proveedores capacitados, según las competencias establecidas en el plan de capacitación.",
        },
        {
          'codigo': '13.0.15',
          'periodo': '2029',
          'descripcion': "Para 2029, se tendrán definidos los lineamientos y criterios para la canalización de los beneficios derivados de la utilización de los recursos genéticos hacia la conservación de la biodiversidad y uso sustentable de sus componentes.",
        },
        {
          'codigo': '13.0.16',
          'periodo': '2030',
          'descripcion': "Para 2030, el acceso a los recursos genéticos y el conocimiento tradicional asociado se realiza bajo un marco normativo, administrativo y de política y los beneficios derivados se distribuyen de manera justa y equitativa contribuyendo a la conservación y uso sustentable de la diversidad biológica.",
        },
      ];
      for (var i = 0; i < hitos130.length; i++) {
        final hito = hitos130[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '13.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 4 ? ref72 : ref73,
        );
      }

      final ref76 = await insertarReferencia(
        pagina: 76,
        seccion: 'Meta Nacional 14.1 — Hitos',
      );
      const hitos141 = <Map<String, String>>[
        {
          'codigo': '14.1.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se establece un mecanismo intersectorial para dar seguimiento y coordinar las acciones de integración de la biodiversidad.",
        },
        {
          'codigo': '14.1.2',
          'periodo': '2024-2026',
          'descripcion': "Para 2024-2026, el Plan Nacional de Desarrollo y los programas derivados de este, conforme a lo dispuesto en la Ley de Planeación, incluyen una visión estratégica y transversal sobre la valoración, conservación, uso sustentable y restauración de la biodiversidad, para el cumplimiento del Marco Mundial de Biodiversidad Kunming-Montreal.",
        },
        {
          'codigo': '14.1.3',
          'periodo': '2025',
          'descripcion': "Para 2025, la Secretaría de Medio Ambiente y Recursos Naturales (semarnat), en colaboración con la Comisión para el Conocimiento y Uso de la Biodiversidad (conabio), promueven y coadyuvan en el desarrollo de estrategias de integración de la biodiversidad en los sectores gubernamentales.",
        },
        {
          'codigo': '14.1.4',
          'periodo': '2025',
          'descripcion': "Para 2025, México revisa y actualiza las actividades en materia de soluciones basadas en la naturaleza y la conservación de la biodiversidad en el sistema financiero (AT.2), dentro de la Estrategia de Movilización de Financiamiento Sostenible (emfs).",
        },
        {
          'codigo': '14.1.5',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, se identifican instrumentos financieros para reducir impactos negativos en la biodiversidad, así como de aquellos que permitan la conservación, en línea con lo establecido en la meta nacional 18.0.",
        },
      ];
      for (var i = 0; i < hitos141.length; i++) {
        final hito = hitos141[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '14.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref76,
        );
      }
      await insertarSubhito(
        codigo: '14.1.3.1',
        hito: '14.1.3',
        descripcion: "Para 2025, todos los sectores gubernamentales que formulan e implementan políticas públicas que impactan directa o indirectamente a la diversidad biológica han realizado sus diagnósticos para identificar riesgos, impactos, dependencias y oportunidades en la conservación y uso sustentable de la biodiversidad.",
        orden: 1,
        referenciaOrigenId: ref76,
      );
      await insertarSubhito(
        codigo: '14.1.3.2',
        hito: '14.1.3',
        descripcion: "Para 2027, todos los sectores gubernamentales que formulan e implementan políticas públicas que impactan directa o indirectamente a la biodiversidad han integrado en sus herramientas de planeación, políticas y programas, consideraciones de conservación y uso sustentable de la biodiversidad.",
        orden: 2,
        referenciaOrigenId: ref76,
      );

      final ref77 = await insertarReferencia(
        pagina: 77,
        seccion: 'Meta Nacional 14.2 — Hitos',
      );
      const hitos142 = <Map<String, String>>[
        {
          'codigo': '14.2.1',
          'periodo': '2024 en adelante',
          'descripcion': "Del 2024 en adelante, se impulsan mecanismos de planeación integral y foros capaces de dar respuesta a los nuevos retos que incluye la sustentabilidad turística, tales como programas de manejo de zonas de desarrollo turístico sustentable, estrategias de conservación de la biodiversidad en el sector turístico, planes de negocios para empresas con criterios de conservación de la biodiversidad, estrategias de turismo comunitario, y la Estrategia de Actividades Turísticas Sostenibles Basadas en el Océano en México 2023-2030.",
        },
        {
          'codigo': '14.2.2',
          'periodo': '2024 en adelante',
          'descripcion': "A partir de 2024, se fortalecen mecanismos de coordinación interinstitucional con la finalidad de articular estrategias, programas y acciones en el territorio encaminadas al aceleramiento de la sustentabilidad turística.",
        },
        {
          'codigo': '14.2.3',
          'periodo': '2024 en adelante',
          'descripcion': "A partir de 2024, se impulsan mejores prácticas en materia de sustentabilidad turística.",
        },
        {
          'codigo': '14.2.4',
          'periodo': '2025 en adelante',
          'descripcion': "A partir de 2025, se impulsan políticas de turismo comunitario con criterios de conservación de la biodiversidad, con enfoque de género, con pertinencia cultural y respeto a los derechos colectivos de los pueblos indígenas y afromexicano.",
        },
        {
          'codigo': '14.2.5',
          'periodo': '2025',
          'descripcion': "Para 2025, se desarrollan estrategias de financiamiento para impulsar el turismo sustentable.",
        },
        {
          'codigo': '14.2.6',
          'periodo': '2025 en adelante',
          'descripcion': "A partir del 2025, se consolidan programas de capacitación enfocadas al turismo sustentable y comunitario, dirigido a los sectores público, privado y social.",
        },
        {
          'codigo': '14.2.7',
          'periodo': '2025 en adelante',
          'descripcion': "A partir del 2025, se implementa iniciativas de turismo comunitario que incluye la conservación para la biodiversidad.",
        },
        {
          'codigo': '14.2.8',
          'periodo': '2025 en adelante',
          'descripcion': "A partir del 2025 en adelante, se identifican sitios turísticos donde se impulsan actividades de restauración, manejo, recuperación y rehabilitación de playas y ecosistemas costeros en colaboración con los tres órdenes de gobierno.",
        },
        {
          'codigo': '14.2.9',
          'periodo': '2025',
          'descripcion': "Para el 2025, el Programa Sectorial de Turismo 2026-2030 (prosectur) contempla una visión del sector turístico para hacer de la sustentabilidad un eje rector del turismo en México como una responsabilidad ineludible frente a los desafíos del cambio climático, la pérdida de biodiversidad y la creciente demanda de experiencias éticas por parte de los viajeros; que contribuya al desarrollo justo, inclusivo y resiliente de nuestros territorios, asegurando que las futuras generaciones puedan también disfrutar y beneficiarse de la riqueza natural y cultural.",
        },
      ];
      for (var i = 0; i < hitos142.length; i++) {
        final hito = hitos142[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '14.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref77,
        );
      }

      final ref80 = await insertarReferencia(
        pagina: 80,
        seccion: 'Meta Nacional 15.0 — Hitos',
      );
      const hitos150 = <Map<String, String>>[
        {
          'codigo': '15.0.1',
          'periodo': '2026',
          'descripcion': "Para 2026, México cuenta con una hoja de ruta para el sector privado financiero y no financiero, que proponga métricas, metodologías e indicadores relevantes para evaluar los impactos, dependencias, riesgos de pérdida de biodiversidad.",
        },
        {
          'codigo': '15.0.2',
          'periodo': '2026',
          'descripcion': "Para 2026, México integra el objetivo de biodiversidad en la Taxonomía Sostenible de México para orientar la movilización de capitales del sector privado financiero y no financiero hacia actividades con impactos positivos en la conservación y uso sustentable de la biodiversidad.",
        },
        {
          'codigo': '15.0.3',
          'periodo': '2028',
          'descripcion': "Para 2028, México ha desarrollado un programa piloto para la adopción de la Taxonomía Sostenible incluyendo el objetivo de biodiversidad y los instrumentos necesarios para su implementación, y se han realizado los ajustes necesarios para su institucionalización.",
        },
        {
          'codigo': '15.0.4',
          'periodo': '2028',
          'descripcion': "Para 2028, México cuenta con una hoja de ruta para generar instrumentos que regulen la revelación de información proveniente del sector privado financiero y no financiero sobre sus impactos, dependencias, riesgos y oportunidades.",
        },
        {
          'codigo': '15.0.5',
          'periodo': '2029',
          'descripcion': "Para el año 2029, México cuenta con una evaluación clara de estrategias de mitigación de riesgos asociados a la biodiversidad por parte del sector privado financiero y no financiero.",
        },
        {
          'codigo': '15.0.6',
          'periodo': '2030',
          'descripcion': "Para el año 2030, México implementa una regulación para que el sector privado financiero y no financiero identifiquen, evalúen, y revelen información relacionada con los impactos, dependencias, riesgos y oportunidades relacionados con la biodiversidad.",
        },
      ];
      for (var i = 0; i < hitos150.length; i++) {
        final hito = hitos150[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '15.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref80,
        );
      }

      final ref82 = await insertarReferencia(
        pagina: 82,
        seccion: 'Meta Nacional 16.0 — Hitos',
      );
      final ref83 = await insertarReferencia(
        pagina: 83,
        seccion: 'Meta Nacional 16.0 — Hitos',
      );
      const hitos160 = <Map<String, String>>[
        {
          'codigo': '16.0.1',
          'periodo': '2024',
          'descripcion': "Al 2024, se aprueba la Ley General de la Alimentación Adecuada y Sostenible, reglamentaria del derecho constitucional a la alimentación nutritiva, suficiente y de calidad.",
        },
        {
          'codigo': '16.0.2',
          'periodo': '2024',
          'descripcion': "Al 2024, publican los lineamientos generales a que deberán sujetarse la preparación, la distribución y el expendio de los alimentos y bebidas preparados, procesados y a granel, así como el fomento de los estilos de vida saludables en alimentación dentro de toda escuela del Sistema Educativo Nacional, con enfoque para promover en la comunidad educativa el consumo de una alimentación regional adecuada y sustentable.",
        },
        {
          'codigo': '16.0.3',
          'periodo': '2025',
          'descripcion': "Al 2025, se consolida e implementa una estrategia nacional de capacitación dirigida a la población interesada sobre alimentación regional adecuada y sustentable, basada en las Guías Alimentarias, mediante una carta descriptiva replicable creada en 2024 para realizar los talleres de capacitación, en coordinación con las unidades responsables de programas presupuestarios relacionados con el derecho a la alimentación.",
        },
        {
          'codigo': '16.0.4',
          'periodo': '2025',
          'descripcion': "Al 2025, se publica el curso de capacitación para la población en general sobre las recomendaciones de las Guías Alimentarias.",
        },
        {
          'codigo': '16.0.5',
          'periodo': '2025',
          'descripcion': "Al 2025, se capacitan a promotores de salud en una alimentación regional adecuada y sustentable basada en las guías alimentarias.",
        },
        {
          'codigo': '16.0.6',
          'periodo': '2025',
          'descripcion': "Al 2025, se realizan actividades de difusión de una alimentación regional adecuada y sustentable basada en las Guías Alimentarias, con los gobiernos estatales y municipales, en el contexto de conformación de los Consejos Intersectoriales Estatales y Municipales, según lo establecido en la LGAAS.",
        },
        {
          'codigo': '16.0.7',
          'periodo': '2025',
          'descripcion': "Al 2025, se realizan intervenciones de promoción de la salud a través de la implementación de estrategias educativas para fomentar estilos de vida saludables en la población mexicana, con énfasis en información sobre la adopción de una alimentación regional adecuada y sustentable basada en las Guías Alimentarias.",
        },
        {
          'codigo': '16.0.8',
          'periodo': '2025',
          'descripcion': "Al 2025, se certifican entornos laborales como saludables en los cuales se da énfasis a fomentar una alimentación regional saludable y sustentable entre la población trabajadora, basada en las recomendaciones de las Guías Alimentarias.",
        },
        {
          'codigo': '16.0.9',
          'periodo': '2025',
          'descripcion': "Al 2025, se implementan campañas sobre la alimentación regional adecuada y sustentable dirigida a los diferentes grupos de población, basada en las Guías Alimentarias y con participación de los servicios estatales de salud.",
        },
        {
          'codigo': '16.0.10',
          'periodo': '2025',
          'descripcion': "Al 2025, se actualizan y generan materiales educativos dirigidos a diferentes grupos de la población con enfoque de alimentación regional adecuada y sustentable, basados en las recomendaciones de las Guías Alimentarias.",
        },
        {
          'codigo': '16.0.11',
          'periodo': '2025',
          'descripcion': "Al 2025, se implementa en las escuelas los Lineamientos generales a que deberán sujetarse la preparación, la distribución y el expendio de los alimentos y bebidas preparados, procesados y a granel, así como el fomento de los estilos de vida saludables en alimentación dentro de toda escuela del Sistema Educativo Nacional, con enfoque para promover en la comunidad educativa el consumo de una alimentación regional adecuada y sustentable.",
        },
        {
          'codigo': '16.0.12',
          'periodo': '2026',
          'descripcion': "Al 2026, se realiza la vinculación con programas presupuestarios de la administración pública federal para impulsar la implementación de acciones que promuevan la alimentación saludable y sustentable entre la población mexicana.",
        },
      ];
      for (var i = 0; i < hitos160.length; i++) {
        final hito = hitos160[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '16.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 4 ? ref82 : ref83,
        );
      }

      final ref86 = await insertarReferencia(
        pagina: 86,
        seccion: 'Meta Nacional 17.1 — Hitos',
      );
      const hitos171 = <Map<String, String>>[
        {
          'codigo': '17.1.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se identifican los instrumentos jurídicos aplicables al tema de análisis y evaluación de riesgos asociados a las actividades con OGM.",
        },
        {
          'codigo': '17.1.2',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, se publica en el Diario Oficial de la Federación la actualización del Acuerdo por el que se determinan Centros de Origen y Centros de Diversidad Genética del Maíz, y el Acuerdo por el que se determinan Centros de Origen y Centros de Diversidad Genética de Algodón.",
        },
        {
          'codigo': '17.1.3',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, México cuenta con el análisis del marco jurídico identificado y vigente, en materia de análisis y evaluación de riesgos asociados a las actividades con los OGM.",
        },
        {
          'codigo': '17.1.4',
          'periodo': '2028-2029',
          'descripcion': "Para 2028-2029, se integra al menos un grupo de trabajo para la mejora del marco jurídico identificado, en materia de análisis y evaluación de riesgos asociados a las actividades con OGM.",
        },
        {
          'codigo': '17.1.5',
          'periodo': '2030',
          'descripcion': "Para 2030, México cuenta con propuestas de mejora del marco jurídico identificado en materia de análisis y evaluación de riesgos asociados a las actividades con los OGM.",
        },
      ];
      for (var i = 0; i < hitos171.length; i++) {
        final hito = hitos171[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '17.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref86,
        );
      }

      final ref87 = await insertarReferencia(
        pagina: 87,
        seccion: 'Meta Nacional 17.2 — Hitos',
      );
      const hitos172 = <Map<String, String>>[
        {
          'codigo': '17.2.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se identifican los instrumentos jurídicos aplicables al tema de trazabilidad de los OGM.",
        },
        {
          'codigo': '17.2.2',
          'periodo': '2025-2026',
          'descripcion': "Para 2025-2026, México cuenta con un análisis del marco jurídico identificado y vigente relativo al tema de trazabilidad de maíz GM.",
        },
        {
          'codigo': '17.2.3',
          'periodo': '2027-2028',
          'descripcion': "Para 2027-2028, se integra al menos un grupo de trabajo para proponer las bases del proyecto de política pública para la trazabilidad del maíz GM.",
        },
        {
          'codigo': '17.2.4',
          'periodo': '2029-2030',
          'descripcion': "Para 2029-2030, se cuenta con un proyecto de política pública para la trazabilidad de maíz GM.",
        },
      ];
      for (var i = 0; i < hitos172.length; i++) {
        final hito = hitos172[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '17.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref87,
        );
      }

      final ref90 = await insertarReferencia(
        pagina: 90,
        seccion: 'Meta Nacional 18.0 — Hitos',
      );
      const hitos180 = <Map<String, String>>[
        {
          'codigo': '18.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se fortalecen las capacidades de la administración pública federal sobre la importancia de la biodiversidad y los efectos negativos de las subvenciones e incentivos perjudiciales.",
        },
        {
          'codigo': '18.0.2',
          'periodo': '2025-2026',
          'descripcion': "Para 2025-2026, se identifican, evalúan y priorizan los incentivos y subsidios que proporcionan las instituciones de la administración pública federal con potencial negativo en la biodiversidad, en las convocatorias, reglas de operación, modalidades y definición de programas, con la finalidad de realizar recomendaciones de cambios pertinentes que eviten o minimicen dichos impactos (en línea con el hito 14.1.5 de la meta nacional 14.1).",
        },
        {
          'codigo': '18.0.3',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, se identifican, evalúan y priorizan los tipos de incentivos y subsidios positivos, otorgados por las instituciones de la administración pública federal (en línea con el hito 14.1.5 de la meta nacional 14.1).",
        },
        {
          'codigo': '18.0.4',
          'periodo': '2026-2027',
          'descripcion': "Para 2026-2027, se realiza una evaluación de actores/beneficiarios que reciben los incentivos y subsidios, tanto potencialmente negativos como positivos.",
        },
        {
          'codigo': '18.0.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se promueve el incremento de los montos de los incentivos positivos a la biodiversidad, así como la diversificación de los mismos y se incrementa el número de personas beneficiarias.",
        },
        {
          'codigo': '18.0.6',
          'periodo': '2030',
          'descripcion': "Para 2030, se cuenta con una propuesta interinstitucional para la transición gradual hacia subsidios con beneficios para la biodiversidad, basada en estudios técnicos, evaluaciones socioeconómicas y procesos participativos con los sectores afectados.",
        },
      ];
      for (var i = 0; i < hitos180.length; i++) {
        final hito = hitos180[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '18.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref90,
        );
      }

      final ref92 = await insertarReferencia(
        pagina: 92,
        seccion: 'Meta Nacional 19.1 — Hitos',
      );
      const hitos191 = <Map<String, String>>[
        {
          'codigo': '19.1.1',
          'periodo': '2026',
          'descripcion': "Para 2026, México identifica el monto movilizado y la brecha de financiamiento internacional para la biodiversidad.",
        },
        {
          'codigo': '19.1.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se realiza un diagnóstico que incluya el mapeo de actores y fuentes de financiamiento nacional e internacional, privadas y de filantropía, para el logro de la meta, que incluye el mecanismo de recopilación de información.",
        },
        {
          'codigo': '19.1.3',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con el costeo de la implementación de las metas nacionales alineadas al Marco Mundial de Biodiversidad Kunming-Montreal, incluyendo costos unitarios para restauración, OMEC, ANP y para la transición agroecológica (federal, y metodología para identificación de brechas para la realización por parte de gobiernos subnacionales).",
        },
        {
          'codigo': '19.1.4',
          'periodo': '2025',
          'descripcion': "Para 2025, México revisa y actualiza las actividades en materia de soluciones basadas en la naturaleza y la conservación de la biodiversidad en el sistema financiero (AT.2), dentro de la Estrategia de Movilización de Financiamiento Sostenible (emfs), con el fin de movilizar recursos hacia acciones que permitan la consecución de las metas nacionales en línea con el Marco Mundial de Biodiversidad Kunming-Montreal (en línea con el hito 14.1.4 de la meta nacional 14.1).",
        },
        {
          'codigo': '19.1.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se implementan acciones para el fortalecimiento de las capacidades del personal de la administración pública federal encargado de gestionar y movilizar recursos de diferentes fuentes internacionales.",
        },
        {
          'codigo': '19.1.6',
          'periodo': '2028',
          'descripcion': "Para 2028, se actualiza la Estrategia de Movilización de Financiamiento Sostenible, identificando nuevos instrumentos y mecanismos financieros internacionales relativos a la biodiversidad.",
        },
        {
          'codigo': '19.1.7',
          'periodo': '2028',
          'descripcion': "Para 2028, el Gobierno de México, a través de la Secretaría de Hacienda y Crédito Público (shcp), utiliza nuevos instrumentos, fuentes de financiamiento y/o mecanismos financieros que incidan en el logro de la meta.",
        },
      ];
      for (var i = 0; i < hitos191.length; i++) {
        final hito = hitos191[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '19.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref92,
        );
      }

      final ref93 = await insertarReferencia(
        pagina: 93,
        seccion: 'Meta Nacional 19.2 — Hitos',
      );
      const hitos192 = <Map<String, String>>[
        {
          'codigo': '19.2.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se conoce la brecha de financiamiento para el cumplimiento de las metas nacionales.",
        },
        {
          'codigo': '19.2.2',
          'periodo': '2025',
          'descripcion': "Para 2025, México revisa y actualiza las actividades en materia de soluciones basadas en la naturaleza y la conservación de la biodiversidad en el sistema financiero (AT.2), dentro de la Estrategia de Movilización de Financiamiento Sostenible (emfs), con el propósito de contribuir a la reducción de la brecha financiera (en línea con el hito 14.1.14 de la meta nacional 14.1).",
        },
        {
          'codigo': '19.2.3',
          'periodo': '2028',
          'descripcion': "Para 2028, el Gobierno de México, a través de la Secretaría de Hacienda y Crédito Público (shcp), publica una actualización de la Acción Transversal 2 (AT.2) de la Estrategia de Movilización de Financiamiento Sostenible, relativos a la biodiversidad (en línea con el hito 19.1.6 de la meta nacional 19.1).",
        },
      ];
      for (var i = 0; i < hitos192.length; i++) {
        final hito = hitos192[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '19.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref93,
        );
      }

      final ref95 = await insertarReferencia(
        pagina: 95,
        seccion: 'Meta Nacional 19.4 — Hitos',
      );
      const hitos194 = <Map<String, String>>[
        {
          'codigo': '19.4.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se realiza un diagnóstico que incluya el mapeo de actores y fuentes de financiamiento, nacional, internacional, bilaterales, regionales multilaterales, y de fuentes privadas y de filantropía) para la conservación y el uso sustentable de la biodiversidad, y se diseña el mecanismo de recopilación de información.",
        },
        {
          'codigo': '19.4.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se han realizado pilotajes del mecanismo de recopilación y reporte, e incorporando ajustes con base en las lecciones aprendidas durante su implementación.",
        },
        {
          'codigo': '19.4.3',
          'periodo': '2026',
          'descripcion': "Para 2026, de manera paralela, se promueve una reforma al marco jurídico para crear los mandatos y regulaciones necesarios para el reporte obligatorio y transversal del presupuesto e inversiones en biodiversidad por parte de la administración pública federal y otros actores relevantes.",
        },
        {
          'codigo': '19.4.4',
          'periodo': '2026',
          'descripcion': "Para 2026, se establecen reglas de operación para que las dependencias de la administración pública federal, las empresas del sector privado y las instituciones del sistema financiero reporten de manera voluntaria sus presupuestos e inversiones en conservación y uso sustentable de la biodiversidad.",
        },
        {
          'codigo': '19.4.5',
          'periodo': '2027',
          'descripcion': "Para 2027, se cuenta con un sistema de reporte de información de financiamiento recibido y otorgado, homologado con el Informe Bianual de Transparencia (btr), que establece el artículo 13 del Acuerdo de París, en el cual se incluye una desagregación específica para biodiversidad.",
        },
        {
          'codigo': '19.4.6',
          'periodo': '2027',
          'descripcion': "Para 2027, se fortalecen las capacidades técnicas y operativas de los actores involucrados en la implementación del mecanismo de recopilación y reporte, particularmente en la identificación, sistematización y reporte del financiamiento y gasto en biodiversidad.",
        },
        {
          'codigo': '19.4.7',
          'periodo': '2028',
          'descripcion': "Para 2028, se tendrá una propuesta de sistema de monitoreo homologado entre la semarnat y la shcp, en el que se reporte el financiamiento recibido y otorgado de fondos multilaterales, cooperaciones técnicas y organismos financieros internacionales.",
        },
        {
          'codigo': '19.4.8',
          'periodo': '2029',
          'descripcion': "Para 2029, las dependencias de la administración pública federal reportan anualmente, de manera transversal, los presupuestos e inversiones vinculados a la biodiversidad en sus marcos programáticos y planes de trabajo. Por su parte, los sectores privado, financiero y filantrópico reportan de manera voluntaria sus inversiones y flujos financieros relacionados con la conservación y el uso sustentable de la biodiversidad, conforme a los lineamientos del mecanismo establecido.",
        },
      ];
      for (var i = 0; i < hitos194.length; i++) {
        final hito = hitos194[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '19.4',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref95,
        );
      }

      final ref98 = await insertarReferencia(
        pagina: 98,
        seccion: 'Meta Nacional 20.1 — Hitos',
      );
      const hitos201 = <Map<String, String>>[
        {
          'codigo': '20.1.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se realiza un diagnóstico que identifique las brechas existentes en capacidades, tecnología, innovación y cooperación científica en materia de biodiversidad, dentro de la administración pública federal.",
        },
        {
          'codigo': '20.1.2',
          'periodo': '2026',
          'descripcion': "Para 2026, México realiza un registro del número de personas que asisten a capacitaciones internacionales en materia de biodiversidad.",
        },
        {
          'codigo': '20.1.3',
          'periodo': '2026',
          'descripcion': "Para 2026, se implementan cursos en materia de conservación y uso sustentable de la biodiversidad para la administración pública federal y actores estratégicos para la educación ambiental, a través de la plataforma de cursos en línea del Centro de Educación y Capacitación para el Desarrollo Sustentable (CECADESU).",
        },
        {
          'codigo': '20.1.4',
          'periodo': '2027',
          'descripcion': "Para 2027, se desarrollan programas para mejorar las capacidades técnicas y fortalecer la innovación en las instituciones de la administración pública federal, en materia de conservación y uso sustentable de la biodiversidad.",
        },
        {
          'codigo': '20.1.5',
          'periodo': '2027-2028',
          'descripcion': "Para 2027-2028, México aumenta su participación en programas de cooperación internacional en formación técnica en biodiversidad.",
        },
        {
          'codigo': '20.1.6',
          'periodo': '2029',
          'descripcion': "Para 2029, México promueve que el sector privado reporte de forma voluntaria sus contribuciones anuales a capacitaciones y/o transferencia de tecnología relativas a la biodiversidad.",
        },
        {
          'codigo': '20.1.7',
          'periodo': '2029',
          'descripcion': "Para 2029, se fortalecen los centros de investigación y las redes para la innovación en materia de biodiversidad, de manera que faciliten la investigación científica y el desarrollo de nuevas tecnologías.",
        },
      ];
      for (var i = 0; i < hitos201.length; i++) {
        final hito = hitos201[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '20.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref98,
        );
      }

      final ref99 = await insertarReferencia(
        pagina: 99,
        seccion: 'Meta Nacional 20.2 — Hitos',
      );
      const hitos202 = <Map<String, String>>[
        {
          'codigo': '20.2.1',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, México reporta a través del Registro Nacional de Cooperación Internacional para el Desarrollo (RENCID) el monto de los recursos otorgados en dólares como contribución dirigida a los proyectos de cooperación regional en materia de biodiversidad, Sur-Sur y triangular.",
        },
        {
          'codigo': '20.2.2',
          'periodo': '2026',
          'descripcion': "Para 2026, se establece un registro para evaluar la contribución de México al apoyo técnico a nivel internacional sobre temas de biodiversidad.",
        },
      ];
      for (var i = 0; i < hitos202.length; i++) {
        final hito = hitos202[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '20.2',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref99,
        );
      }

      final ref102 = await insertarReferencia(
        pagina: 102,
        seccion: 'Meta Nacional 21.1 — Hitos',
      );
      final ref103 = await insertarReferencia(
        pagina: 103,
        seccion: 'Meta Nacional 21.1 — Hitos',
      );
      final ref104 = await insertarReferencia(
        pagina: 104,
        seccion: 'Meta Nacional 21.1 — Hitos',
      );
      const hitos211 = <Map<String, String>>[
        {
          'codigo': '21.1.1',
          'periodo': '2030',
          'descripcion': "Para 2030, se consolida el Sistema Nacional de Información para la Biodiversidad (SNIB) como un acervo público, accesible, actualizado y confiable, tomando en cuenta los principios FAIR¹ (Findable, Accessible, Interoperable and Reusable) y CARE² (Collective Benefit, Authority to control, Responsability and Ethics), en concordancia con los Acuerdos de Escazú, considerando lo siguiente:",
        },
        {
          'codigo': '21.1.2',
          'periodo': '2030',
          'descripcion': "Para 2030, se establece un marco de gobernanza de datos para el SNIB, que incluya criterios y protocolos de acceso, uso y gestión de la información, en colaboración con dependencias de gobierno, academia, comunidades indígenas, locales y sociedad civil, en concordancia con el Acuerdo de Escazú.",
        },
        {
          'codigo': '21.1.3',
          'periodo': '2030',
          'descripcion': "Para 2030, se reduce la brecha entre la ciencia y la sociedad mediante la promoción de la participación activa de la sociedad e involucrándose en el conocimiento de la biodiversidad, que incluya iniciativas de ciencia ciudadana.",
        },
      ];
      for (var i = 0; i < hitos211.length; i++) {
        final hito = hitos211[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '21.1',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i == 0 ? ref102 : ref104,
        );
      }
      const subhitos2111 = <Map<String, String>>[
        {
          'codigo': '21.1.1.1',
          'descripcion': "Para 2030, se incrementa el acervo de datos primarios sobre biodiversidad, con estándares, controles de calidad, curados e interoperables con distintos sistemas de información.",
        },
        {
          'codigo': '21.1.1.2',
          'descripcion': "Para 2030, se incrementan los catálogos taxonómicos con información de nombres válidos, sinonimia, nombres comunes, entre otra información que facilita la integración y consulta de datos sobre la biota en el país.",
        },
        {
          'codigo': '21.1.1.3',
          'descripcion': "Para 2025-2030, se integran atributos de especies de interés (enlistadas en los apéndices de la Convención sobre el Comercio Internacional de Especies Amenazadas de Fauna y Flora Silvestres -CITES-, en riesgo de extinción, prioritarias, néctar-poliníferas, polinizadores y exóticas invasoras).",
        },
        {
          'codigo': '21.1.1.4',
          'descripcion': "Para 2026, se integra información al SNIB sobre atributos funcionales de especies silvestres (nativas) de aves y mamíferos de México.",
        },
        {
          'codigo': '21.1.1.5',
          'descripcion': "Para 2026, se encuentran disponibles series de tiempo de vegetación y humedad armonizadas, generadas a partir de datos satelitales, para su análisis y monitoreo de ecosistemas.",
        },
        {
          'codigo': '21.1.1.6',
          'descripcion': "Para 2030, se consolida el Sistema de Información sobre Agrobiodiversidad (siagrobd) como una herramienta accesible y ampliamente difundida y utilizada para el ingreso de datos e información, el conocimiento, la conservación y el uso sustentable de la agrobiodiversidad en México.",
        },
        {
          'codigo': '21.1.1.7',
          'descripcion': "Para 2030, se crea un sistema sobre uso sustentable y comercio de la biodiversidad.",
        },
        {
          'codigo': '21.1.1.8',
          'descripcion': "Para 2030, se integran al SNIB, por primera vez, datos de monitoreo provenientes de sensores pasivos in situ (cámaras trampa y grabadoras).",
        },
        {
          'codigo': '21.1.1.9',
          'descripcion': "Para 2030, se consolida la Plataforma de Información de Monitoreo de la Biodiversidad (pimbio) como parte del SNIB, para registrar, almacenar, analizar y distribuir datos de monitoreo pasivo.",
        },
        {
          'codigo': '21.1.1.10',
          'descripcion': "Para 2030, en el Sistema de Monitoreo de Humedales en México (simoh-Mx) se encuentran publicados: 1) los resultados del análisis de tendencias de humedad y cuerpos de agua en humedales dentro de las áreas naturales protegidas (ANP) y sitios Ramsar. 2) La información de sitios de humedales costeros con datos publicados sobre carbono orgánico.",
        },
        {
          'codigo': '21.1.1.11',
          'descripcion': "Para 2030, el Sistema de Monitoreo de los Manglares de México (smmm) actualiza la distribución de los manglares (2025), el índice de antropización, tendencias de cambio y fichas de sitios prioritarios.",
        },
        {
          'codigo': '21.1.1.12',
          'descripcion': "Entre 2025 y 2030, el Sistema de Información y Análisis Marino Costero (SIMAR), través de su explorador, incorpora mejoras y nuevos sistemas de alerta temprana y herramientas de monitoreo in situ sobre biodiversidad marina, que gestionan monitoreos de campo, imágenes satelitales, modelos ambientales y datos geoespaciales: • Sistema Satelital de Alerta Temprana de Blanqueamiento de Corales 1-km (SATCORAL); Sistema Satelital de Alerta Temprana de Sargazo (SATSUM); Sistema de Alerta de la Calidad del Agua Marina (SATWALITY); Sistema Satelital de Alerta Temprana de Florecimientos de Fitoplancton (SATFIT); proyecto de ciencia ciudadana sat-Collect; y bases de datos de la biodiversidad marina (bioinfo).",
        },
        {
          'codigo': '21.1.1.13',
          'descripcion': "Para 2025, se lanza la plataforma Biodiversidades, con al menos 100 indicadores del estado de conocimiento, conservación y tendencias de cambio de diversos aspectos de la biodiversidad, y continuará su consolidación al 2030.",
        },
        {
          'codigo': '21.1.1.14',
          'descripcion': "Para 2025 - 2027, se cuenta con la publicación de los Estudios de la Biodiversidad en los estados de Querétaro, Baja California Sur, Guerrero y Nuevo León, como diagnósticos integrales de la biodiversidad. Asimismo, se cuenta con las Estrategias para la Conservación y Uso Sustentable de la Biodiversidad del Estado de México, Baja California Sur y Nuevo León.",
        },
        {
          'codigo': '21.1.1.15',
          'descripcion': "Para 2030, se mantiene actualizado e incrementa la información de consulta en el Explorador de Cambio Climático y Biodiversidad (ECCBIO), que contribuye a evaluar las tendencias de cambio en variables climáticas y sus posibles afectaciones a la biodiversidad.",
        },
        {
          'codigo': '21.1.1.16',
          'descripcion': "Para 2030, se encuentra consolidado el Sistema Nacional para la Restauración Ambiental (SNIRA) para documentar, planificar y monitorear acciones de restauración en el país.",
        },
        {
          'codigo': '21.1.1.17',
          'descripcion': "Para 2030, el Sistema de Alerta Temprana de Incendios Forestales (SATIF) continúa proporcionando información diaria en México y Centroamérica para el monitoreo de incendios con datos satelitales disponibles, para las personas encargadas del manejo del fuego y contribuir a minimizar los efectos negativos en los ecosistemas y salvaguardar la vida humana.",
        },
        {
          'codigo': '21.1.1.18',
          'descripcion': "Para 2030, se mejora, actualiza y consolida el Atlas de Naturaleza y Sociedad, que aborda la dimensión social y cultural de la biodiversidad en el SNIB, mediante la integración de datos sociodemográficos, incluyendo, entre otros, presencia de hablantes de lenguas indígenas, niveles de salud, educación, pobreza.",
        },
      ];
      for (var i = 0; i < subhitos2111.length; i++) {
        final subhito = subhitos2111[i];
        await insertarSubhito(
          codigo: subhito['codigo']!,
          hito: '21.1.1',
          descripcion: subhito['descripcion']!,
          orden: i + 1,
          referenciaOrigenId: i < 9 ? ref102 : ref103,
        );
      }
      await insertarSubhito(
        codigo: '21.1.2.1',
        hito: '21.1.2',
        descripcion: "Para 2029, los datos alojados y publicados por el SNIB cumplirán con los principios de datos FAIR, con el fin de potenciar la investigación, la innovación y la toma de decisiones informada, permitiendo su fácil acceso y uso por parte de cualquier persona, sin importar su formación o recursos.",
        orden: 1,
        referenciaOrigenId: ref103,
      );
      await insertarSubhito(
        codigo: '21.1.2.2',
        hito: '21.1.2',
        descripcion: "Para 2029, los datos del SNIB se complementarán con principios CARE, según corresponda, enfocados en asegurar que los datos sobre agrobiodiversidad y uso de las especies, principalmente se hagan considerando estos principios para promover el fortalecimiento de la gobernanza en las comunidades con respeto a sus derechos y autonomía, en concordancia con los Acuerdos de Escazú.",
        orden: 2,
        referenciaOrigenId: ref104,
      );
      await insertarSubhito(
        codigo: '21.1.3.1',
        hito: '21.1.3',
        descripcion: "A partir de 2026, se cuenta con un ecosistema digital gestionado por el Centro de Educación y Capacitación para el Desarrollo Sustentable (CECADESU) a través del cual se difunden materiales dirigidos a diversos sectores de la sociedad para fortalecer la participación en la conservación y el uso sustentable de la biodiversidad.",
        orden: 1,
        referenciaOrigenId: ref104,
      );
      await insertarSubhito(
        codigo: '21.1.3.2',
        hito: '21.1.3',
        descripcion: "A partir de 2026, se desarrollan y promueven proyectos y actividades de divulgación y educación ambiental para fortalecer la conciencia y cultura públicas sobre la conservación de la biodiversidad.",
        orden: 2,
        referenciaOrigenId: ref104,
      );

      final ref108 = await insertarReferencia(
        pagina: 108,
        seccion: 'Meta Nacional 22.0 — Hitos',
      );
      const hitos220 = <Map<String, String>>[
        {
          'codigo': '22.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, se cuenta con una hoja de ruta con acciones, metas, responsabilidades y calendarios de trabajo, por cada derecho de acceso a la información, a la participación pública y a la justicia, así como para la atención de las personas defensoras de los derechos humanos en asuntos ambientales.",
        },
        {
          'codigo': '22.0.2',
          'periodo': '2025',
          'descripcion': "Para 2025, se implementa un programa de capacitación para el fortalecimiento de las capacidades de la administración pública federal en los tres derechos de acceso del Acuerdo de Escazú.",
        },
        {
          'codigo': '22.0.3',
          'periodo': '2025',
          'descripcion': "En 2025, se ha fortalecido el diálogo con las organizaciones de la sociedad civil mediante foros que socializan la información sobre el cumplimiento del mandato de Escazú y que facilitan la creación de condiciones para garantizar el acceso de sus derechos.",
        },
        {
          'codigo': '22.0.4',
          'periodo': '2025',
          'descripcion': "Para 2025, se difunden los contenidos del Acuerdo Escazú al Consejo Nacional de Pueblos Indígenas (cnpi).",
        },
        {
          'codigo': '22.0.5',
          'periodo': '2026',
          'descripcion': "Para 2026, se ejecuta el Plan Nacional de Implementación del Acuerdo de Escazú con base en la hoja de ruta planteada.",
        },
      ];
      for (var i = 0; i < hitos220.length; i++) {
        final hito = hitos220[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '22.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: ref108,
        );
      }

      final ref110 = await insertarReferencia(
        pagina: 110,
        seccion: 'Meta Nacional 23.0 — Hitos',
      );
      final ref111 = await insertarReferencia(
        pagina: 111,
        seccion: 'Meta Nacional 23.0 — Hitos',
      );
      const hitos230 = <Map<String, String>>[
        {
          'codigo': '23.0.1',
          'periodo': '2025',
          'descripcion': "Para 2025, el sector ambiental establece un comité coordinador de género con la finalidad de reforzar la transversalidad del enfoque de género en los programas y políticas del sector ambiental.",
        },
        {
          'codigo': '23.0.2',
          'periodo': '2026',
          'descripcion': "Para 2026, las instituciones del sector ambiental de la administración pública federal identifican las brechas de desigualdad y barreras en el ejercicio de los derechos de acceso, uso, aprovechamiento y beneficio de las mujeres a los recursos naturales y a su participación en las acciones de conservación, toma de decisiones. vigilancia y uso sustentable de la biodiversidad.",
        },
        {
          'codigo': '23.0.3',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, la Procuraduría Federal de Protección al Ambiente (profepa), y en sus 32 oficinas de representación, implementa acciones para incentivar la participación de las mujeres, en toda su diversidad, dentro de los Comités de Vigilancia Ambiental Participativa (cvap) de recursos naturales.",
        },
        {
          'codigo': '23.0.4',
          'periodo': '2024 en adelante',
          'descripcion': "Para 2024 y en adelante, el acceso de las mujeres a la titularidad de la tierra y acceso a los recursos naturales se ha incrementado.",
        },
        {
          'codigo': '23.0.5',
          'periodo': '2024',
          'descripcion': "Para 2024, la Comisión Nacional de Áreas Naturales Protegidas (CONANP) cuenta con una metodología que permite, desde la perspectiva de género, evaluar la brecha salarial, la participación, distribución de beneficios y toma de decisiones entre hombres y mujeres en las iniciativas productivas comunitarias que apoya. Promueve su difusión, conocimiento y aplicación.",
        },
        {
          'codigo': '23.0.6',
          'periodo': '2025',
          'descripcion': "Para 2025, las instituciones del sector ambiental de la administración pública federal, en el marco de sus atribuciones y programas, identifican y ejecutan acciones estratégicas para disminuir las brechas de desigualdad y las barreras en el ejercicio de los derechos de acceso, uso, aprovechamiento y beneficio de las mujeres a los recursos naturales y a su participación en los mecanismos de conservación, vigilancia y uso sustentable de la biodiversidad.",
        },
        {
          'codigo': '23.0.7',
          'periodo': '2025',
          'descripcion': "Para 2025, las instituciones del sector ambiental de la administración pública federal dan continuidad y refuerzan la incorporación de la perspectiva de género en sus acciones conforme a la normatividad aplicable, así como en los programas sociales y políticas públicas.",
        },
        {
          'codigo': '23.0.8',
          'periodo': '2025',
          'descripcion': "Para 2025, se identifica el número de mujeres que forman parte de los mecanismos de participación del sector ambiental y otros de la administración pública federal asociados a medio ambiente, en el marco de la implementación del Acuerdo de Escazú.",
        },
        {
          'codigo': '23.0.9',
          'periodo': '2026',
          'descripcion': "Para 2026, la Secretaría de Medio Ambiente y Recursos Naturales (semarnat), diseñará una propuesta de lineamientos para asegurar la participación plena y efectiva de las mujeres en toda su diversidad en los mecanismos de participación ciudadana para la toma de decisiones respecto al acceso, control, uso y beneficio de los recursos naturales.",
        },
        {
          'codigo': '23.0.10',
          'periodo': '2027',
          'descripcion': "Para 2027, las instituciones de la administración pública federal establecen metas e indicadores para el monitoreo y seguimiento de las acciones de promoción y fortalecimiento de la participación plena y efectiva de las mujeres en las intervenciones territoriales de las políticas públicas, los programas, actividades institucionales, mecanismos, las acciones y estrategias.",
        },
      ];
      for (var i = 0; i < hitos230.length; i++) {
        final hito = hitos230[i];
        await insertarHito(
          codigo: hito['codigo']!,
          metaNacional: '23.0',
          descripcion: hito['descripcion']!,
          periodo: hito['periodo'],
          orden: i + 1,
          referenciaOrigenId: i < 3 ? ref110 : ref111,
        );
      }

      // -------------------------------------------------------------------
      // -------------------------------------------------------------------
      // SUBHITOS COMPLEMENTARIOS VERIFICADOS EN LA GUÍA OFICIAL
      // -------------------------------------------------------------------
      final subhitosComplementarios = <Map<String, String>>[
        {
          'codigo': '2.3.1.1',
          'hito': '2.3.1',
          'descripcion': 'Para 2030, en el marco del Programa Nacional de Restauración Ambiental (PNRA), se restauran 15 mil hectáreas de manglares, equivalentes a 30% de los manglares con procesos de degradación en México, contribuyendo a la recuperación de su cobertura y sus servicios ecosistémicos.',
        },
        {
          'codigo': '8.1.12.1',
          'hito': '8.1.12',
          'descripcion': 'Para 2027, se cuenta con un análisis que permita identificar las ANP federales con mayor riesgo actual y futuro ante el cambio climático. Responsable: conanp; coadyuvantes: inecc y conabio.',
        },
        {
          'codigo': '8.1.12.2',
          'hito': '8.1.12',
          'descripcion': 'Para 2027, se contará con una guía para la evaluación de riesgos ante el cambio climático y diseño de medidas de adaptación para personal de ANP federales, en donde se contemple la gobernanza de las medidas, su financiamiento e indicadores de avance e impacto. Responsable: conanp.',
        },
        {
          'codigo': '8.1.12.3',
          'hito': '8.1.12',
          'descripcion': 'Para 2028, las ANP federales con mayor riesgo a nivel nacional ante el cambio climático contarán con evaluaciones de riesgos específicos (para ecosistemas, comunidades locales y medios de vida) ante el cambio climático. Responsable: conanp.',
        },
        {
          'codigo': '8.1.12.4',
          'hito': '8.1.12',
          'descripcion': 'Para 2030, se han implementado o estarán implementando, medidas de adaptación en ANP federales y sus zonas de influencia con alto riesgo ante el cambio climático a nivel nacional, derivadas de evaluaciones de riesgo específicas, las cuales contarán con mecanismos para asegurar su ejecución en la escala y temporalidad adecuada, con enfoque de género, para tener un impacto significativo en la reducción del riesgo de los ecosistemas, las comunidades y sus medios de vida, en especial en las ANP que abarquen localidades de alta vulnerabilidad al cambio climático. Responsable: conanp; coadyuvantes: inecc y conabio.',
        },
        {
          'codigo': '8.1.12.5',
          'hito': '8.1.12',
          'descripcion': 'Para 2030, se cuenta con un sistema de seguimiento con enfoque de género del progreso respecto a los indicadores de avance e impacto respecto al cambio climático relacionados con las medidas de adaptación implementadas en ANP. Responsable: conanp.',
        },
        {
          'codigo': '14.1.3.1',
          'hito': '14.1.3',
          'descripcion': 'Para 2025, todos los sectores gubernamentales que formulan e implementan políticas públicas que impactan directa o indirectamente a la diversidad biológica han realizado sus diagnósticos para identificar riesgos, impactos, dependencias y oportunidades en la conservación y uso sustentable de la biodiversidad.',
        },
        {
          'codigo': '14.1.3.2',
          'hito': '14.1.3',
          'descripcion': 'Para 2027, todos los sectores gubernamentales que formulan e implementan políticas públicas que impactan directa o indirectamente a la biodiversidad han integrado en sus herramientas de planeación, políticas y programas, consideraciones de conservación y uso sustentable de la biodiversidad.',
        },
      ];

      for (var i = 0; i < subhitosComplementarios.length; i++) {
        final subhito = subhitosComplementarios[i];
        await insertarSubhito(
          codigo: subhito['codigo']!,
          hito: subhito['hito']!,
          descripcion: subhito['descripcion']!,
          orden: i + 1,
          referenciaOrigenId: null,
        );
      }

      // INSTITUCIONES, SIGLAS Y MATRIZ INSTITUCIONAL
      // Fuente: Guía Rápida 2026, Cuadro 1 y apartado "Siglas y acrónimos".
      // Se conservan las 73 siglas de la fuente y se agrega APF como la
      // entidad colectiva indicada para 14.1, 18.0 y 21.2.
      // -------------------------------------------------------------------
      final institucionIds = <String, int>{};

      Future<int> insertarInstitucionSeed({
        required String sigla,
        required String nombre,
      }) async {
        final id = await database
            .into(database.instituciones)
            .insert(
              InstitucionesCompanion.insert(
                nombre: nombre,
                nombreCorto: Value(sigla),
                tipo: const Value(null),
                descripcion: const Value(null),
              ),
            );
        institucionIds[sigla] = id;
        return id;
      }

      await insertarInstitucionSeed(
        sigla: 'agricultura',
        nombre: 'Secretaría de Agricultura y Desarrollo Rural',
      );
      await insertarInstitucionSeed(
        sigla: 'anam',
        nombre: 'Agencia Nacional de Aduanas de México',
      );
      await insertarInstitucionSeed(
        sigla: 'asea',
        nombre: 'Agencia de Seguridad, Energía y Ambiente',
      );
      await insertarInstitucionSeed(
        sigla: 'bienestar',
        nombre: 'Secretaría de Bienestar',
      );
      await insertarInstitucionSeed(
        sigla: 'cenaprece',
        nombre: 'Centro Nacional de Prevención y Control de Enfermedades',
      );
      await insertarInstitucionSeed(
        sigla: 'cenapred',
        nombre: 'Centro Nacional de Prevención de Desastres',
      );
      await insertarInstitucionSeed(
        sigla: 'cibiogem',
        nombre: 'Comisión Intersecretarial de Bioseguridad de los Organismos Genéticamente Modificados',
      );
      await insertarInstitucionSeed(
        sigla: 'CICC',
        nombre: 'Comisión Intersecretarial de Cambio Climático',
      );
      await insertarInstitucionSeed(
        sigla: 'cimares',
        nombre: 'Comisión Intersecretarial para el Manejo Sustentable de Mares y Costas',
      );
      await insertarInstitucionSeed(
        sigla: 'cjf',
        nombre: 'Consejo de la Judicatura Federal',
      );
      await insertarInstitucionSeed(
        sigla: 'cnpa',
        nombre: 'Consejo Nacional de Pesca y Acuacultura',
      );
      await insertarInstitucionSeed(
        sigla: 'cnpi',
        nombre: 'Consejo Nacional de Pueblos Indígenas',
      );
      await insertarInstitucionSeed(
        sigla: 'ciconmar',
        nombre: 'Comisión Intersecretarial para Prevenir y Atender la Comisión por Hidrocarburos y Sustancias Nocivas en las Zonas Marinas Mexicanas',
      );
      await insertarInstitucionSeed(
        sigla: 'cofepris',
        nombre: 'Comisión Federal para la Protección contra Riesgos Sanitarios',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio',
        nombre:
            'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio-ac cites',
        nombre: 'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad-Autoridad Científica cites',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio-carb',
        nombre: 'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad-Coordinación de Agrobiodiversidad y Recursos Biológicos',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio-csiamc',
        nombre: 'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad-Coordiación del Sistema de Información y Análisis Marino Costero',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio-dap',
        nombre: 'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad-Dirección de Análisis y Prioridades',
      );
      await insertarInstitucionSeed(
        sigla: 'conabio-deeb',
        nombre: 'Comisión Nacional para el Conocimiento y Uso de la Biodiversidad-Dirección de Enlace Estratégico en Biodiversidad',
      );
      await insertarInstitucionSeed(
        sigla: 'conafor',
        nombre: 'Comisión Nacional Forestal',
      );
      await insertarInstitucionSeed(
        sigla: 'conagua',
        nombre: 'Comisión Nacional del Agua',
      );
      await insertarInstitucionSeed(
        sigla: 'conanp',
        nombre: 'Comisión Nacional de Áreas Naturales Protegidas',
      );
      await insertarInstitucionSeed(
        sigla: 'conapesca',
        nombre: 'Comisión Nacional de Acuacultura y Pesca',
      );
      await insertarInstitucionSeed(
        sigla: 'conaza',
        nombre: 'Comisión Nacional de Zonas Áridas',
      );
      await insertarInstitucionSeed(
        sigla: 'conuee',
        nombre: 'Comisión Nacional para el Uso Eficiente de la Energía',
      );
      await insertarInstitucionSeed(
        sigla: 'economia',
        nombre: 'Secretaría de Economía',
      );
      await insertarInstitucionSeed(
        sigla: 'gt-adapt',
        nombre: 'Grupo de Trabajo de Políticas de Adaptación de la Comisión Intersecretarial de Cambio Climático',
      );
      await insertarInstitucionSeed(
        sigla: 'GT-REDD+',
        nombre: 'Grupo de Trabajo redd+ de la Comisión Intersecretarial de Cambio Climático',
      );
      await insertarInstitucionSeed(
        sigla: 'imipas',
        nombre: 'Instituto Mexicano de Investigación en Pesca y Acuacultura Sustentables',
      );
      await insertarInstitucionSeed(
        sigla: 'impi',
        nombre: 'Instituto Mexicano de la Propiedad Industrial',
      );
      await insertarInstitucionSeed(
        sigla: 'imta',
        nombre: 'Instituto Mexicano de Tecnología del Agua',
      );
      await insertarInstitucionSeed(
        sigla: 'inecc',
        nombre: 'Instituto Nacional de Ecología y Cambio Climático',
      );
      await insertarInstitucionSeed(
        sigla: 'inegi',
        nombre: 'Instituto Nacional de Estadística y Geografía',
      );
      await insertarInstitucionSeed(
        sigla: 'inifap',
        nombre: 'Instituto Nacional de Investigaciones Forestales, Agrícolas y Pecuarias',
      );
      await insertarInstitucionSeed(
        sigla: 'inpi',
        nombre: 'Instituto Nacional de los Pueblos Indígenas',
      );
      await insertarInstitucionSeed(
        sigla: 'insp',
        nombre: 'Instituto Nacional de Salud Pública',
      );
      await insertarInstitucionSeed(
        sigla: 'mujeres',
        nombre: 'Secretaría de las Mujeres',
      );
      await insertarInstitucionSeed(
        sigla: 'pa',
        nombre: 'Procuraduria Agraria',
      );
      await insertarInstitucionSeed(
        sigla: 'pemex',
        nombre: 'Petróleos Mexicanos',
      );
      await insertarInstitucionSeed(
        sigla: 'profepa',
        nombre: 'Procuraduría Federal de Protección al Ambiente',
      );
      await insertarInstitucionSeed(
        sigla: 'ran',
        nombre: 'Registro Agrario Nacional',
      );
      await insertarInstitucionSeed(
        sigla: 'salud',
        nombre: 'Secretaría de Salud',
      );
      await insertarInstitucionSeed(
        sigla: 'secihti',
        nombre: 'Secretaría de Ciencia, Humanidades, Tecnología e Innovación',
      );
      await insertarInstitucionSeed(
        sigla: 'sectur',
        nombre: 'Secretaría de Turismo',
      );
      await insertarInstitucionSeed(
        sigla: 'sedatu',
        nombre: 'Secretaría de Desarrollo Agrario, Territorial y Urbano',
      );
      await insertarInstitucionSeed(
        sigla: 'sedena',
        nombre: 'Secretaría de Defensa Nacional',
      );
      await insertarInstitucionSeed(
        sigla: 'segob',
        nombre: 'Secretaría de Gobernación',
      );
      await insertarInstitucionSeed(
        sigla: 'semar',
        nombre: 'Secretaría de Marina',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-cecadesu',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Centro de Educación y Capacitación para el Desarrollo Sustentable',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgcgmc',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Conservación y Gestión de Mares y Costas',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dggfsoe',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Gestión Forestal, Suelos y Ordenamiento Ecológico',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dggimar',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Gestión Integral de Materiales y Actividades Riesgosas',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgielgca',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Industria, Energías Limpias y Gestión de la Calidad del Aire',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgira',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Impacto y Riesgo Ambiental',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgit',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Informática y Telecomunicaciones',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgpac',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Políticas para la Acción Climática',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgpeea',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Planeación, Evaluación y Estadística Ambiental',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgra',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Restauración Ambiental',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgvs',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Vida Silvestre',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-dgzfmtac',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Dirección General de Zona Federal Marítimo Terrestre y Ambientes Costeros',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-ucai',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Unidad Coordinadora de Asuntos Internacionales',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-ucaj',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Unidad Coordinadora de Asuntos Jurídicos',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-ucorgt',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Unidad Coordinadora de Oficinas de Representación y Gestión Territorial',
      );
      await insertarInstitucionSeed(
        sigla: 'semarnat-ucppvsdh',
        nombre: 'Secretaría de Medio Ambiente y Recursos Naturales-Unidad Coordinadora de Proyectos Prioritarios, Vinculación Social y Derechos Humanos',
      );
      await insertarInstitucionSeed(
        sigla: 'senasica',
        nombre:
            'Servicio Nacional de Sanidad, Inocuidad y Calidad Agroalimentaria',
      );
      await insertarInstitucionSeed(
        sigla: 'sener',
        nombre: 'Secretaría de Energía',
      );
      await insertarInstitucionSeed(
        sigla: 'sep',
        nombre: 'Secretaría de Educación Pública',
      );
      await insertarInstitucionSeed(
        sigla: 'shcp',
        nombre: 'Secretaría de Hacienda y Crédito Público',
      );
      await insertarInstitucionSeed(
        sigla: 'sict',
        nombre: 'Secretaría de Infraestructura, Comunicaciones y Transportes',
      );
      await insertarInstitucionSeed(
        sigla: 'sre',
        nombre: 'Secretaría de Relaciones Exteriores',
      );
      await insertarInstitucionSeed(
        sigla: 'sre-amexcid',
        nombre: 'Secretaría de Relaciones Exteriores-Agencia Mexicana de Cooperación Internacional para el Desarrollo',
      );
      // Catálogo de siglas y acrónimos de la Guía.
      // Cada sigla se vincula con la institución que acabamos de insertar.
      // APF no se incluye aquí porque la fuente la presenta como una
      // participación colectiva y no como una sigla del catálogo.
      for (final entry in institucionIds.entries) {
        await database
            .into(database.siglasAcronimos)
            .insert(
              SiglasAcronimosCompanion.insert(
                institucionId: entry.value,
                sigla: entry.key.toUpperCase(),
                descripcion: Value(
                  (await (database.select(database.instituciones)
                            ..where((tbl) => tbl.id.equals(entry.value)))
                          .getSingle())
                      .nombre,
                ),
              ),
            );
      }

      final refMatrizInstitucional = await insertarReferencia(
        pagina: 7,
        seccion: 'Cuadro 1 — Agrupación de metas nacionales por dependencias coordinadoras y coadyuvantes',
        observacion: 'La fuente continúa en las páginas 8 y 9-10; esta referencia identifica el cuadro institucional.',
      );

      final apfId = await database
          .into(database.instituciones)
          .insert(
            InstitucionesCompanion.insert(
              nombre: 'Administración Pública Federal',
              nombreCorto: const Value(null),
              tipo: const Value(null),
              descripcion: const Value(
                'Participación identificada por la fuente para las metas nacionales 14.1, 18.0 y 21.2.',
              ),
            ),
          );
      institucionIds['__APF__'] = apfId;

      Future<void> insertarParticipacionSeed({
        required String institucion,
        required String meta,
        required String tipo,
      }) async {
        await database
            .into(database.participacionesInstitucionales)
            .insert(
              ParticipacionesInstitucionalesCompanion.insert(
                institucionId: institucion == '__APF__'
                    ? apfId
                    : institucionIds[institucion]!,
                metaNacionalId: Value(metaNacionalIds[meta]!),
                hitoId: const Value(null),
                tipoParticipacion: tipo,
                descripcion: const Value(null),
                referenciaOrigenId: Value(refMatrizInstitucional),
              ),
            );
      }

      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '7.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '10.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '10.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '10.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '10.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'agricultura',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'anam',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'anam',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'anam',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'anam',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'anam',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'asea',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'asea',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'asea',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'asea',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'bienestar',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'bienestar',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cenaprece',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cenapred',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cibiogem',
        meta: '17.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'cibiogem',
        meta: '17.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'CICC',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cimares',
        meta: '1.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'cjf',
        meta: '22.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cnpa',
        meta: '10.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cnpi',
        meta: '22.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'ciconmar',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cofepris',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cofepris',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cofepris',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'cofepris',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '3.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '3.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '14.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '19.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '19.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-ac cites',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-ac cites',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-ac cites',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-ac cites',
        meta: '9.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-ac cites',
        meta: '10.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '9.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '10.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-carb',
        meta: '16.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-csiamc',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-csiamc',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-csiamc',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-csiamc',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '6.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '6.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-dap',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-deeb',
        meta: '21.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conabio-deeb',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '1.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '9.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '11.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '1.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '3.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '10.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '10.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '19.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conafor',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '7.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conagua',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '3.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '6.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '6.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '11.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '3.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conanp',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '9.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '10.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '6.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '10.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conapesca',
        meta: '11.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conaza',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conuee',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'conuee',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '15.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '19.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '10.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '11.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'economia',
        meta: '17.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'gt-adapt',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'GT-REDD+',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '9.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '10.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '6.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '7.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imipas',
        meta: '10.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'impi',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '7.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'imta',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '8.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '8.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '19.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inecc',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inegi',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inegi',
        meta: '11.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inegi',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inifap',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inifap',
        meta: '10.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inpi',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inpi',
        meta: '21.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'inpi',
        meta: '22.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'insp',
        meta: '16.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'mujeres',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'mujeres',
        meta: '10.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'mujeres',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'pa',
        meta: '1.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'pa',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'pa',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'pemex',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '4.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '7.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '10.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '11.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '17.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'profepa',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'ran',
        meta: '1.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'ran',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'ran',
        meta: '10.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'ran',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'salud',
        meta: '16.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'salud',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'salud',
        meta: '17.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'salud',
        meta: '17.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'secihti',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'secihti',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'secihti',
        meta: '17.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sectur',
        meta: '1.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sectur',
        meta: '14.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sectur',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sectur',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sedatu',
        meta: '1.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sedatu',
        meta: '12.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sedatu',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sedatu',
        meta: '1.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sedena',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'segob',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'segob',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'segob',
        meta: '6.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'segob',
        meta: '22.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semar',
        meta: '1.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semar',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semar',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semar',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat',
        meta: '14.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat',
        meta: '23.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-cecadesu',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-cecadesu',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-cecadesu',
        meta: '20.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-cecadesu',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '1.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '2.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '4.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '6.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '7.5',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '13.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '17.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgcgmc',
        meta: '17.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '1.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '1.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '1.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '4.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '6.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '9.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '10.5',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '2.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '10.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '12.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggfsoe',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dggimar',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgielgca',
        meta: '7.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgielgca',
        meta: '7.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgira',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgit',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpac',
        meta: '1.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpac',
        meta: '8.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpac',
        meta: '8.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '5.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '11.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '14.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '18.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '19.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgpeea',
        meta: '15.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '2.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '2.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '2.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '7.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '8.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgra',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '4.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '9.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '6.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '6.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '8.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgvs',
        meta: '13.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgzfmtac',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-dgzfmtac',
        meta: '7.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucai',
        meta: '19.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucai',
        meta: '19.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucaj',
        meta: '2.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucorgt',
        meta: '10.5',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucppvsdh',
        meta: '21.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucppvsdh',
        meta: '22.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'semarnat-ucppvsdh',
        meta: '23.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '2.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '5.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '6.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '7.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '10.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'senasica',
        meta: '17.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sener',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sener',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sener',
        meta: '7.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sener',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sep',
        meta: '7.4',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sep',
        meta: '16.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sep',
        meta: '21.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '14.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '15.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '19.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '19.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '19.3',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '19.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'shcp',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sict',
        meta: '1.2',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sre',
        meta: '19.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre',
        meta: '22.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre',
        meta: '23.0',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre',
        meta: '1.3',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: 'sre-amexcid',
        meta: '19.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre-amexcid',
        meta: '19.4',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre-amexcid',
        meta: '20.1',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: 'sre-amexcid',
        meta: '20.2',
        tipo: 'COORDINADORA',
      );
      await insertarParticipacionSeed(
        institucion: '__APF__',
        meta: '14.1',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: '__APF__',
        meta: '18.0',
        tipo: 'COADYUVANTE',
      );
      await insertarParticipacionSeed(
        institucion: '__APF__',
        meta: '21.2',
        tipo: 'COADYUVANTE',
      );
    });
  }
}
