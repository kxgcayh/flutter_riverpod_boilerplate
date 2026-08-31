import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/chat/data/models/chat_room.dart';

void main() {
  group('ChatRoom Freezed Model', () {
    test('supports value equality and json serialization', () {
      final now = DateTime.parse('2026-08-31T12:00:00.000Z');
      const room = ChatRoom(
        id: 'room_1',
        name: 'Flutter Guild',
        unreadCount: 3,
        isOnline: true,
        participantIds: ['u1', 'u2'],
      );

      final json = room.toJson();
      expect(json['id'], equals('room_1'));
      expect(json['name'], equals('Flutter Guild'));
      expect(json['unreadCount'], equals(3));

      final fromJson = ChatRoom.fromJson(json);
      expect(fromJson, equals(room));

      final updated = room.copyWith(unreadCount: 0, lastMessageTime: now);
      expect(updated.unreadCount, equals(0));
      expect(updated.lastMessageTime, equals(now));
    });
  });
}
