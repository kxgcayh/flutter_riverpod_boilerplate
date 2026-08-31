import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/network/network_result.dart';
import '../../data/models/chat_room.dart';
import '../../data/repositories/chat_repository_impl.dart';

/// State for the chat list screen
class ChatListState {
  const ChatListState({
    required this.rooms,
    this.searchQuery = '',
  });

  final AsyncValue<List<ChatRoom>> rooms;
  final String searchQuery;

  List<ChatRoom> get filteredRooms {
    return rooms.maybeWhen(
      data: (list) {
        if (searchQuery.trim().isEmpty) return list;
        return list
            .where((room) =>
                room.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                (room.lastMessage?.toLowerCase().contains(searchQuery.toLowerCase()) ??
                    false))
            .toList();
      },
      orElse: () => [],
    );
  }

  ChatListState copyWith({
    AsyncValue<List<ChatRoom>>? rooms,
    String? searchQuery,
  }) {
    return ChatListState(
      rooms: rooms ?? this.rooms,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// ViewModel for Chat List screen
class ChatListViewModel extends Notifier<ChatListState> {
  StreamSubscription<dynamic>? _messageSubscription;

  @override
  ChatListState build() {
    ref.onDispose(() {
      _messageSubscription?.cancel();
    });

    _listenToIncomingMessages();
    Future.microtask(() => _loadRooms());

    return const ChatListState(rooms: AsyncValue.loading());
  }

  Future<void> _loadRooms() async {
    state = state.copyWith(rooms: const AsyncValue.loading());
    final repository = ref.read(chatRepositoryProvider);
    final result = await repository.getChatRooms();

    switch (result) {
      case Success<List<ChatRoom>>(:final data):
        state = state.copyWith(rooms: AsyncValue.data(data));
      case Failure<List<ChatRoom>>(:final failure):
        state = state.copyWith(
          rooms: AsyncValue.error(failure.message, StackTrace.current),
        );
    }
  }

  void _listenToIncomingMessages() {
    final repository = ref.read(chatRepositoryProvider);
    _messageSubscription = repository.messageStream.listen((message) {
      state.rooms.whenData((currentRooms) {
        final updatedRooms = currentRooms.map((room) {
          if (room.id == message.roomId) {
            return room.copyWith(
              lastMessage: message.message,
              lastMessageTime: message.timestamp,
              unreadCount: message.isMine ? room.unreadCount : room.unreadCount + 1,
            );
          }
          return room;
        }).toList();

        state = state.copyWith(rooms: AsyncValue.data(updatedRooms));
      });
    });
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> refresh() async {
    await _loadRooms();
  }
}

final chatListViewModelProvider =
    NotifierProvider<ChatListViewModel, ChatListState>(ChatListViewModel.new);
