part of 'post_provider.dart';

class PostListNotifier extends AsyncNotifier<List<PostModel>> {
  @override
  FutureOr<List<PostModel>> build() async {
    final PostRepository repository = ref.read(postRepositoryProvider);
    return await repository.posts();
  }
}
