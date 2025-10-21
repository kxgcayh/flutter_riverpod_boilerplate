import 'package:flutter/material.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/application/post_provider.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';
import 'package:flutter_riverpod_boilerplate/src/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        data: (posts) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              for (final post in posts)
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  child: Card(
                    child: InkWell(
                      onTap: () => PostDetailRoute(id: '${post.id}').go(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 4),
                            Text(
                              post.body,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Text('PostPage is Error: $error'),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
