import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.binds(i);

    i.addLazySingleton(HttpClient.new);
    i.addLazySingleton(LocalStorage.new);
  }
}

class HttpClient {}

class LocalStorage {}
