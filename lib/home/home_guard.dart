import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class HomeGuard extends RouteGuard {
  HomeGuard() : super(redirectTo: '/login/login-page');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    bool isLogged = true;
    return isLogged;
  }
}
