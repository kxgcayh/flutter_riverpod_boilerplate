import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String roomId,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String message,
    required DateTime timestamp,
    @Default(MessageStatus.sent) MessageStatus status,
    @Default(false) bool isMine,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
