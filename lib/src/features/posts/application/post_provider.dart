import 'package:dio/dio.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/data/post_repository.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.p.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepositoryImpl(ref));

final asyncPostProvider = AsyncNotifierProvider.autoDispose<PostListNotifier, List<PostModel>>(() {
  return PostListNotifier();
});

final postDetailProvider = AutoDisposeFutureProviderFamily<PostModel, String>((ref, String id) async {
  final CancelToken cancelToken = CancelToken();
  final PostRepository repository = ref.read(postRepositoryProvider);
  ref.onDispose(() => cancelToken.cancel());
  return await repository.post(id, cancelToken);
});
