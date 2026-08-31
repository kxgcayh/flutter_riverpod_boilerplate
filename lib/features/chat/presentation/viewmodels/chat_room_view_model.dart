import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/network/network_result.dart';
import '../../data/models/chat_message.dart';
import '../../data/repositories/chat_repository_impl.dart';

/// State for a specific chat room
class ChatRoomState {
  const ChatRoomState({
    required this.messages,
    this.isPartnerTyping = false,
    this.isSending = false,
    this.errorMessage,
  });

  final AsyncValue<List<ChatMessage>> messages;
  final bool isPartnerTyping;
  final bool isSending;
  final String? errorMessage;

  ChatRoomState copyWith({
    AsyncValue<List<ChatMessage>>? messages,
    bool? isPartnerTyping,
    bool? isSending,
    String? errorMessage,
  }) {
    return ChatRoomState(
      messages: messages ?? this.messages,
      isPartnerTyping: isPartnerTyping ?? this.isPartnerTyping,
      isSending: isSending ?? this.isSending,
      errorMessage: errorMessage,
    );
  }
}

/// Family ViewModel for chat rooms
class ChatRoomViewModel extends Notifier<ChatRoomState> {
  ChatRoomViewModel(this.roomId);

  final String roomId;
  StreamSubscription<dynamic>? _messageSubscription;

  @override
  ChatRoomState build() {
    ref.onDispose(() {
      _messageSubscription?.cancel();
    });

    _listenToIncomingMessages();
    Future.microtask(() => _loadMessages());

    return const ChatRoomState(messages: AsyncValue.loading());
  }

  Future<void> _loadMessages() async {
    state = state.copyWith(messages: const AsyncValue.loading());
    final repository = ref.read(chatRepositoryProvider);
    final result = await repository.getMessages(roomId);

    if (result case Success<List<ChatMessage>>(:final data)) {
      state = state.copyWith(messages: AsyncValue.data(data));
    } else if (result case Failure<List<ChatMessage>>(:final failure)) {
      state = state.copyWith(
        messages: AsyncValue.error(failure.message, StackTrace.current),
      );
    }
  }

  void _listenToIncomingMessages() {
    final repository = ref.read(chatRepositoryProvider);
    _messageSubscription = repository.messageStream.listen((message) {
      if (message.roomId == roomId) {
        state.messages.whenData((currentList) {
          state = state.copyWith(
            messages: AsyncValue.data([...currentList, message]),
          );
        });
      }
    });
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final repository = ref.read(chatRepositoryProvider);

    // Optimistic message placeholder
    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final optimisticMessage = ChatMessage(
      id: tempId,
      roomId: roomId,
      senderId: 'user_me',
      senderName: 'Me',
      message: trimmed,
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
      isMine: true,
    );

    final currentMessages = state.messages.value ?? [];
    state = state.copyWith(
      messages: AsyncValue.data([...currentMessages, optimisticMessage]),
      isSending: true,
    );

    final result = await repository.sendMessage(
      roomId: roomId,
      message: trimmed,
    );

    if (result case Success<ChatMessage>(:final data)) {
      state.messages.whenData((msgs) {
        final updated = msgs.map((m) {
          return m.id == tempId ? data : m;
        }).toList();
        state = state.copyWith(
          messages: AsyncValue.data(updated),
          isSending: false,
        );
      });
    } else if (result case Failure<ChatMessage>(:final failure)) {
      state.messages.whenData((msgs) {
        final updated = msgs.map((m) {
          return m.id == tempId
              ? m.copyWith(status: MessageStatus.failed)
              : m;
        }).toList();
        state = state.copyWith(
          messages: AsyncValue.data(updated),
          isSending: false,
          errorMessage: failure.message,
        );
      });
    }
  }
}

final chatRoomViewModelProvider =
    NotifierProvider.autoDispose.family<ChatRoomViewModel, ChatRoomState, String>(
  (arg) => ChatRoomViewModel(arg),
);
