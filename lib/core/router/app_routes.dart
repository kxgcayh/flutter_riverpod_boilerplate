import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/views/chat_list_screen.dart';
import '../../features/chat/presentation/views/chat_room_screen.dart';
import '../../features/profile/presentation/views/profile_screen.dart';
import '../../features/settings/presentation/views/settings_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<ChatListRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ChatRoomRoute>(
      path: 'chat/:id',
    ),
    TypedGoRoute<ProfileRoute>(
      path: 'profile',
    ),
    TypedGoRoute<SettingsRoute>(
      path: 'settings',
    ),
  ],
)
class ChatListRoute extends GoRouteData with $ChatListRoute {
  const ChatListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChatListScreen();
}

class ChatRoomRoute extends GoRouteData with $ChatRoomRoute {
  const ChatRoomRoute({required this.id, this.title});

  final String id;
  final String? title;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ChatRoomScreen(roomId: id, roomTitle: title ?? 'Chat');
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
