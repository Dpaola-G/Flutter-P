import 'package:app_movil_coffe/Animations/FadeAnimation.dart';
import 'package:app_movil_coffe/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeAnimation(
        1.2,
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 41, 28, 171),
              Color.fromARGB(255, 0, 0, 116)
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned.fill(
                top: 110,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FadeAnimation(
                      1.5,
                      Image.asset(
                        'assets/logo.png',
                        scale: 0.9,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
