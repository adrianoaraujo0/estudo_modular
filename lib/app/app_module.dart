import 'package:estudo_modular/core/auth_module/auth_module.dart';
import 'package:estudo_modular/core/routes/path_modules.dart';
import 'package:estudo_modular/core/routes/path_pages.dart';
import 'package:estudo_modular/home/home_module.dart';
import 'package:estudo_modular/login/login_module.dart';
import 'package:estudo_modular/splash_module/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.redirect('/', to: '${PathModules.splash}${PathPages.splashPage}');
    r.module(PathModules.splash, module: SplashModule());
    r.module(PathModules.login, module: LoginModule());
    r.module(PathModules.home, module: HomeModule());
  }

  @override
  List<Module> get imports => [AuthModule()];
}
