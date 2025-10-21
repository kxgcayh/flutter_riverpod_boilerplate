import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final routerListenableProvider = AutoDisposeAsyncNotifierProvider<RouterListener, void>(() {
  return RouterListener();
});

class RouterListener extends AutoDisposeAsyncNotifier<void> implements Listenable {
  VoidCallback? _routerListener;

  @override
  Future<void> build() async {
    listenSelf((_, __) {
      if (state.isLoading) return;
      _routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    // Deep Link Handler
    // if (state.matchedLocation.contains('/r/')) {
    //   try {
    //     final splitMatched = state.matchedLocation.split('/');
    //     final videoID = int.parse(splitMatched[2]);
    //     final subCategoryId = int.parse(splitMatched[3]);
    //     return '/video?video-id=$videoID&subcategory-id=$subCategoryId';
    //   } catch (_, __) {
    //     return null;
    //   }
    // }
    return null;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
