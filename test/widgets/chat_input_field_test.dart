import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/chat/presentation/widgets/chat_input_field.dart';

void main() {
  testWidgets('ChatInputField types and submits text', (tester) async {
    String? submittedText;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatInputField(
            onSendMessage: (text) {
              submittedText = text;
            },
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Test message from hook widget');
    await tester.pumpAndSettle();

    final sendButton = find.byType(IconButton).last;
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    expect(submittedText, equals('Test message from hook widget'));
  });
}
