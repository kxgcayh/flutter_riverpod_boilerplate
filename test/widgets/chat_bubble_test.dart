import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/chat/data/models/chat_message.dart';
import 'package:flutter_boilerplate/features/chat/presentation/widgets/chat_bubble.dart';

void main() {
  testWidgets('ChatBubble renders sent message properly', (tester) async {
    final message = ChatMessage(
      id: 'msg_1',
      roomId: 'room_1',
      senderId: 'user_me',
      senderName: 'Me',
      message: 'Hello testing flutter',
      timestamp: DateTime.parse('2026-08-31T10:30:00.000Z'),
      status: MessageStatus.sent,
      isMine: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatBubble(message: message),
        ),
      ),
    );

    expect(find.text('Hello testing flutter'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('ChatBubble renders received message with sender name', (tester) async {
    final message = ChatMessage(
      id: 'msg_2',
      roomId: 'room_1',
      senderId: 'user_alex',
      senderName: 'Alex Vance',
      message: 'Testing incoming bubble',
      timestamp: DateTime.parse('2026-08-31T10:30:00.000Z'),
      status: MessageStatus.read,
      isMine: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatBubble(message: message),
        ),
      ),
    );

    expect(find.text('Testing incoming bubble'), findsOneWidget);
    expect(find.text('Alex Vance'), findsOneWidget);
  });
}
