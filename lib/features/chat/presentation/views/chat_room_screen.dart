import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodels/chat_room_view_model.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';

/// Screen representing an individual chat conversation feed
class ChatRoomScreen extends HookConsumerWidget {
  const ChatRoomScreen({
    super.key,
    required this.roomId,
    required this.roomTitle,
  });

  final String roomId;
  final String roomTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final state = ref.watch(chatRoomViewModelProvider(roomId));
    final viewModel = ref.read(chatRoomViewModelProvider(roomId).notifier);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Scroll to bottom when new messages arrive
    useEffect(() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
      return null;
    }, [state.messages.value?.length]);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isDark
                  ? AppColors.darkSurfaceVariant
                  : AppColors.primaryContainer,
              child: Text(
                roomTitle.isNotEmpty ? roomTitle[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.isPartnerTyping ? 'Typing...' : 'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: state.isPartnerTyping
                          ? AppColors.secondary
                          : AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.messages.when(
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
                        color: AppColors.error,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text('Failed to load messages: $err'),
                    ],
                  ),
                ),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet.\nSay hello! 👋',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  );
                }

                // Reversed list for natural chat scrolling pinned to bottom
                final reversedMessages = messages.reversed.toList();

                return ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: reversedMessages.length,
                  itemBuilder: (context, index) {
                    final message = reversedMessages[index];
                    return ChatBubble(
                      key: ValueKey(message.id),
                      message: message,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(
            isSending: state.isSending,
            onSendMessage: (text) => viewModel.sendMessage(text),
          ),
        ],
      ),
    );
  }
}
