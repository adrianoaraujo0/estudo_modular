import 'package:estudo_modular/core/routes/path_pages.dart';
import 'package:estudo_modular/splash_module/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child(
      PathPages.splashPage,
      child: (_) => const SplashPage(),
    );
  }

  @override
  void binds(Injector i) {
    super.binds(i);

    i.addLazySingleton(() => SplashController());
  }
}
