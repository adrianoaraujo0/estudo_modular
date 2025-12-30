import 'package:estudo_modular/core/routes/path_pages.dart';
import 'package:estudo_modular/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child(
      PathPages.loginPage,
      child: (_) => const LoginPage(),
    );
  }
}
