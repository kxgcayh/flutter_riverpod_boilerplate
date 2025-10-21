import 'package:flutter/material.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/application/post_provider.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/domain/post_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostDetailPage extends ConsumerWidget {
  final String id;
  const PostDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<PostModel> post = ref.watch(postDetailProvider(id));
    return post.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Post Detail'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    data.body,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('PostDetailPage is Error ($error)'),
        ),
      ),
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
