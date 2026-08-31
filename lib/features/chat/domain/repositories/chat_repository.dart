import '../../../../core/network/network_result.dart';
import '../../data/models/chat_message.dart';
import '../../data/models/chat_room.dart';

/// Domain interface for chat repository
abstract interface class ChatRepository {
  Future<Result<List<ChatRoom>>> getChatRooms();
  Future<Result<List<ChatMessage>>> getMessages(String roomId);
  Future<Result<ChatMessage>> sendMessage({
    required String roomId,
    required String message,
  });
  Stream<ChatMessage> get messageStream;
}
