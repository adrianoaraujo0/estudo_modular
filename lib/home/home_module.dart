import 'package:estudo_modular/core/routes/path_pages.dart';
import 'package:estudo_modular/home/home_guard.dart';
import 'package:estudo_modular/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child(
      PathPages.homePage,
      child: (_) => const HomePage(),
      guards: [
        HomeGuard(),
      ],
    );
  }
}
