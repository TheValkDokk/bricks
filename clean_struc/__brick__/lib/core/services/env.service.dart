import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class EnvService {
  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await dotenv.load();
  }

  String get(String key) {
    return dotenv.env[key]!;
  }
}
