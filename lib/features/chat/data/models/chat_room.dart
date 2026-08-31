import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String name,
    String? avatarUrl,
    String? lastMessage,
    DateTime? lastMessageTime,
    @Default(0) int unreadCount,
    @Default(false) bool isOnline,
    @Default([]) List<String> participantIds,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
