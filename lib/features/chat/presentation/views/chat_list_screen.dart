import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodels/chat_list_view_model.dart';
import '../widgets/chat_room_tile.dart';

/// Screen displaying user conversation channels and search
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListViewModelProvider);
    final viewModel = ref.read(chatListViewModelProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Flutter Boilerplate'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            tooltip: 'Profile',
            onPressed: () => const ProfileRoute().go(context),
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Settings',
            onPressed: () => const SettingsRoute().go(context),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chats, people...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.lightTextSecondary,
                ),
                suffixIcon: state.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () => viewModel.setSearchQuery(''),
                      )
                    : null,
              ),
              onChanged: viewModel.setSearchQuery,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: viewModel.refresh,
              child: state.rooms.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (err, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Error loading chats',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$err',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: viewModel.refresh,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (_) {
                  final filtered = state.filteredRooms;
                  if (filtered.isEmpty) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 48,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.searchQuery.isEmpty
                                      ? 'No conversations yet'
                                      : 'No matching chats found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      indent: 78,
                      endIndent: 16,
                      color: isDark
                          ? AppColors.darkBorder.withValues(alpha: 0.5)
                          : AppColors.lightBorder.withValues(alpha: 0.7),
                    ),
                    itemBuilder: (context, index) {
                      final room = filtered[index];
                      return ChatRoomTile(
                        room: room,
                        onTap: () {
                          ChatRoomRoute(
                            id: room.id,
                            title: room.name,
                          ).go(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Start new conversation')),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit_rounded),
      ),
    );
  }
}
