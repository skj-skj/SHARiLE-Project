import 'package:flutter/cupertino.dart';

Route screenRoute({dynamic screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Animation<double> opacityAnimation =
          Tween(begin: 0.5, end: 1.0).animate(animation);
      return FadeTransition(
        opacity: opacityAnimation,
        child: child,
      );
    },
  );
}
