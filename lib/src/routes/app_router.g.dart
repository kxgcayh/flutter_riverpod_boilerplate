// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$postRoute];

RouteBase get $postRoute => GoRouteData.$route(
  path: '/post',
  factory: $PostRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'detail/:id',
      factory: $PostDetailRoute._fromState,
    ),
  ],
);

mixin $PostRoute on GoRouteData {
  static PostRoute _fromState(GoRouterState state) => const PostRoute();

  @override
  String get location => GoRouteData.$location('/post');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PostDetailRoute on GoRouteData {
  static PostDetailRoute _fromState(GoRouterState state) =>
      PostDetailRoute(id: state.pathParameters['id']!);

  PostDetailRoute get _self => this as PostDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/post/detail/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
