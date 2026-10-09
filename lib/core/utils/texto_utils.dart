const List<String> _siglasMayusculas = [
  'nom-059-semarnat-2010',
  'conabio',
  'semarnat',
  'conanp',
  'conagua',
  'conafor',
  'conaza',
  'conapesca',
  'conuee',
  'conabio-ac cites',
  'conabio-carb',
  'conabio-csiamc',
  'conabio-dap',
  'conabio-deeb',
  'anam',
  'anp',
  'apb',
  'asea',
  'abrrd',
  'cenaprece',
  'cenapred',
  'cfp',
  'cibiogem',
  'cicc',
  'ciconmar',
  'cjf',
  'cma',
  'cmnucc',
  'cnpa',
  'cnpi',
  'cofepris',
  'dgpac',
  'dgot',
  'eca',
  'eei',
  'emfs',
  'enaredd+',
  'fip',
  'gt-adapt',
  'gt-redd+',
  'hfc',
  'hcfc',
  'imipas',
  'impi',
  'imta',
  'inecc',
  'inegi',
  'inifap',
  'inpi',
  'insp',
  'lgaas',
  'lgeepa',
  'nap',
  'ndc',
  'oit',
  'omec',
  'pace',
  'pecc',
  'pemex',
  'pfn',
  'picla',
  'pimvs',
  'pmt',
  'pmp',
  'pnmsmcm',
  'pnra',
  'poem',
  'profepa',
  'psa',
  'ran',
  'redd+',
  'sbn',
  'scian',
  'simoh-mx',
  'snib',
  'pimbio',
  'secihti',
  'sectur',
  'sedatu',
  'sedena',
  'segob',
  'semar',
  'sener',
  'senasica',
  'sep',
  'shcp',
  'sict',
  'siagrobd',
  'smmm',
  'simar',
  'eccbio',
  'snira',
  'eneei',
  'satif',
  'renom',
  'wdoecm',
  'prosectur',
  'ogm',
  'sre',
  'sre-amexcid',
  'uaiff',
  'upp',
  'zrp',
  'unam',
  'ipn',
  'uam',
  'inah',
  'inapesca',
  'fao',
  'onu',
  'cfe',
  'semarnat-cecadesu',
  'semarnat-dgcgmc',
  'semarnat-dggfsoe',
  'semarnat-dgielgca',
  'semarnat-dgimar',
  'semarnat-dgira',
  'semarnat-dgit',
  'semarnat-dgpac',
  'semarnat-dgpeea',
  'semarnat-dgra',
  'semarnat-dgvs',
  'semarnat-dgzfmtac',
  'semarnat-ucai',
  'semarnat-ucaj',
  'semarnat-ucorgt',
  'semarnat-ucppvsdh',
  'pap',
  'ptm',
  'mer',
  'gm',
  'nom-003-sedatu-2023',
  'nom-052-fito-1995',
];

/// Denominaciones oficiales con capitalización mixta.
/// Se procesan después de las siglas para conservar su forma correcta.
const Map<String, String> _nombresMixtos = {
  'SATCORAL': 'SATcoral',
  'SATSUM': 'SATsum',
  'SATWALITY': 'SATwality',
  'SATFIT': 'SATfit',
  'BIOINFO': 'BIOinfo',
  'SAT-COLLECT': 'SAT-Collect',
  'ENBIOMEX': 'ENBioMex',
  'SBN': 'SbN',
  'ABE': 'AbE',
  'ABC': 'AbC',
  'ABRRD': 'AbRRD',
};

// Los límites impiden reemplazar fragmentos dentro de palabras como
// «catálogos», «educación» o «comunidad».
final List<({RegExp patron, String reemplazo})> _reglasSiglas = (() {
  final ordenadas = [..._siglasMayusculas]
    ..sort((a, b) => b.length.compareTo(a.length));
  return ordenadas
      .map((sigla) {
        return (
          patron: RegExp(
            r'(?<![A-Za-zÀ-ÖØ-öø-ÿ0-9])' +
                RegExp.escape(sigla) +
                r'(?![A-Za-zÀ-ÖØ-öø-ÿ0-9])',
            caseSensitive: false,
          ),
          reemplazo: sigla.toUpperCase(),
        );
      })
      .toList(growable: false);
})();

final List<({RegExp patron, String reemplazo})> _reglasNombresMixtos =
    _nombresMixtos.entries
        .map((entry) {
          return (
            patron: RegExp(
              r'(?<![A-Za-zÀ-ÖØ-öø-ÿ0-9])' +
                  RegExp.escape(entry.key) +
                  r'(?![A-Za-zÀ-ÖØ-öø-ÿ0-9])',
              caseSensitive: false,
            ),
            reemplazo: entry.value,
          );
        })
        .toList(growable: false);

/// Corrige únicamente la presentación de siglas y nombres oficiales.
String corregirSiglas(String texto) {
  var resultado = texto;
  for (final regla in _reglasSiglas) {
    resultado = resultado.replaceAll(regla.patron, regla.reemplazo);
  }
  for (final regla in _reglasNombresMixtos) {
    resultado = resultado.replaceAll(regla.patron, regla.reemplazo);
  }
  return resultado;
}
