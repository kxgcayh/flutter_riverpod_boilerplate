import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/presentation/post_detail_page.dart';
import 'package:flutter_riverpod_boilerplate/src/features/posts/presentation/post_page.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

@TypedGoRoute<PostRoute>(
  path: PostRoute.path,
  routes: [TypedGoRoute<PostDetailRoute>(path: PostDetailRoute.path)],
)
class PostRoute extends GoRouteData with _$PostRoute {
  const PostRoute();
  static const path = '/post';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PostPage();
  }
}

class PostDetailRoute extends GoRouteData with _$PostDetailRoute {
  const PostDetailRoute({required this.id});
  final String id;
  static const path = 'detail/:id';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PostDetailPage(id: id);
  }
}
