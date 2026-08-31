import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/chat_message.dart';

/// Chat bubble widget optimized for 120 FPS scrolling with const subtrees
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final timeString = DateFormat('HH:mm').format(message.timestamp);

    final bubbleColor = message.isMine
        ? (isDark ? AppColors.myMessageDark : AppColors.myMessageLight)
        : (isDark ? AppColors.otherMessageDark : AppColors.otherMessageLight);

    final textColor = message.isMine
        ? Colors.white
        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    final secondaryTextColor = message.isMine
        ? Colors.white70
        : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);

    return RepaintBoundary(
      child: Align(
        alignment:
            message.isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.76,
          ),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(message.isMine ? 18 : 4),
              bottomRight: Radius.circular(message.isMine ? 4 : 18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: message.isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!message.isMine)
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    message.senderName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.secondaryLight : AppColors.primary,
                    ),
                  ),
                ),
              Text(
                message.message,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  color: textColor,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    timeString,
                    style: TextStyle(
                      fontSize: 11,
                      color: secondaryTextColor,
                    ),
                  ),
                  if (message.isMine) ...[
                    const SizedBox(width: 4),
                    _MessageStatusIcon(status: message.status),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageStatusIcon extends StatelessWidget {
  const _MessageStatusIcon({required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      MessageStatus.sending => const SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Colors.white70,
          ),
        ),
      MessageStatus.sent => const Icon(
          Icons.check,
          size: 13,
          color: Colors.white70,
        ),
      MessageStatus.delivered => const Icon(
          Icons.done_all,
          size: 13,
          color: Colors.white70,
        ),
      MessageStatus.read => const Icon(
          Icons.done_all,
          size: 13,
          color: AppColors.secondaryLight,
        ),
      MessageStatus.failed => const Icon(
          Icons.error_outline,
          size: 13,
          color: AppColors.error,
        ),
    };
  }
}
