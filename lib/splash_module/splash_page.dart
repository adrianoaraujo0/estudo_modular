import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashController {}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate('/home/home-page');
    });
  }

  @override
  void dispose() {
    super.dispose();

    print("**SPLASH DISPOSE**");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SPLASH PAGE"),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
