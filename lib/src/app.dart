import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_boilerplate/src/routes/app_router.dart';
import 'package:flutter_riverpod_boilerplate/src/routes/router_listenable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiverpodApp extends HookConsumerWidget {
  const RiverpodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerNotifier = ref.watch(routerListenableProvider.notifier);
    final key = useRef(GlobalKey<NavigatorState>(debugLabel: 'routerKey'));
    final router = useMemoized(
      () => GoRouter(
        navigatorKey: key.value,
        refreshListenable: routerNotifier,
        initialLocation: PostRoute.path,
        debugLogDiagnostics: true,
        routes: $appRoutes,
        redirect: routerNotifier.redirect,
      ),
      [routerNotifier],
    );

    return MaterialApp.router(
      title: 'Flutter Boilerplate',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
