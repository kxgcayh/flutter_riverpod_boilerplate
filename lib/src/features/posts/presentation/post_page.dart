import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/application/post_provider.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<PostModel>> asyncPost = ref.watch(asyncPostProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Posts Page'),
        centerTitle: true,
      ),
      body: asyncPost.when(
        data: (data) => Center(
          child: const Text('PostPage is Working'),
        ),
        error: (error, stack) => Center(
          child: Text('PostPage is Error: $error'),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
