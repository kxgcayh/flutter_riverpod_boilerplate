import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/data/post_repository.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepository(ref));

final asyncPostProvider = AsyncNotifierProvider<AsyncPostNotifier, List<PostModel>>(() {
  return AsyncPostNotifier();
});

class AsyncPostNotifier extends AsyncNotifier<List<PostModel>> {
  @override
  FutureOr<List<PostModel>> build() async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.posts();
  }
}
