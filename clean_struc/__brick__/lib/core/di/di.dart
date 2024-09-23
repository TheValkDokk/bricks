import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final get = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({Environment env = mainEnv}) async =>
    get.init(environment: mainEnv.name);

const mainEnv = Environment('main');
