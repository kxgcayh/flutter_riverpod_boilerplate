import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/theme/app_colors.dart';

/// Chat message input field utilizing [HookWidget] for localized controller & focus lifecycle
class ChatInputField extends HookWidget {
  const ChatInputField({
    super.key,
    required this.onSendMessage,
    this.isSending = false,
  });

  final ValueChanged<String> onSendMessage;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();
    final isComposing = useState(false);

    useEffect(() {
      void listener() {
        isComposing.value = textController.text.trim().isNotEmpty;
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    void handleSubmit() {
      final text = textController.text.trim();
      if (text.isNotEmpty && !isSending) {
        onSendMessage(text);
        textController.clear();
      }
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: MediaQuery.paddingOf(context).bottom + 8,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              size: 26,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Message...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onSubmitted: (_) => handleSubmit(),
              ),
            ),
          ),
          AnimatedScale(
            scale: isComposing.value ? 1.0 : 0.88,
            duration: const Duration(milliseconds: 150),
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: isComposing.value
                    ? AppColors.primary
                    : (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                foregroundColor: isComposing.value
                    ? Colors.white
                    : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
              icon: isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.arrow_upward_rounded, size: 20),
              onPressed: isComposing.value && !isSending ? handleSubmit : null,
            ),
          ),
        ],
      ),
    );
  }
}
