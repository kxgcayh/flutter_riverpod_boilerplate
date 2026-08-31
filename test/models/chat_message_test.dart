import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/chat/data/models/chat_message.dart';

void main() {
  group('ChatMessage Freezed Model', () {
    test('supports value equality and copyWith', () {
      final now = DateTime.now();
      final msg1 = ChatMessage(
        id: 'msg_1',
        roomId: 'room_1',
        senderId: 'user_1',
        senderName: 'David',
        message: 'Hello world',
        timestamp: now,
        status: MessageStatus.sent,
        isMine: false,
      );

      final msg2 = ChatMessage(
        id: 'msg_1',
        roomId: 'room_1',
        senderId: 'user_1',
        senderName: 'David',
        message: 'Hello world',
        timestamp: now,
        status: MessageStatus.sent,
        isMine: false,
      );

      expect(msg1, equals(msg2));

      final updated = msg1.copyWith(status: MessageStatus.read);
      expect(updated.status, equals(MessageStatus.read));
      expect(updated.id, equals('msg_1'));
    });

    test('serializes to and from json', () {
      final now = DateTime.parse('2026-08-31T12:00:00.000Z');
      final msg = ChatMessage(
        id: 'msg_json_1',
        roomId: 'room_1',
        senderId: 'user_1',
        senderName: 'Elena',
        message: 'Dart 3 pattern matching!',
        timestamp: now,
        status: MessageStatus.delivered,
        isMine: true,
      );

      final json = msg.toJson();
      expect(json['id'], equals('msg_json_1'));
      expect(json['message'], equals('Dart 3 pattern matching!'));

      final fromJson = ChatMessage.fromJson(json);
      expect(fromJson, equals(msg));
    });
  });
}
