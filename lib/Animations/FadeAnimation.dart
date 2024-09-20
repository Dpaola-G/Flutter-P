import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
                0,
                50 *
                    (1 -
                        value)), // Desplaza el widget hacia arriba a medida que se desvanece
            child: child,
          ),
        );
      },
      child: child,
      onEnd: () {
        // Se ejecuta cuando la animación finaliza
      },
    );
  }
}
