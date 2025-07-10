import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

typedef RouteBuilder = Widget Function(BuildContext context, GoRouterState state);

class RouteItem {
  final String path;
  final RouteBuilder builder;

  RouteItem({required this.path, required this.builder});

  GoRoute toGoRoute() {
    return GoRoute(
      path: path,
      builder: builder,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: builder(context, state),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}