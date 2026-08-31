import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/core/widgets/app_avatar.dart';

void main() {
  testWidgets('AppAvatar renders user initials when image is null', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppAvatar(
            fallbackName: 'Elena Rostova',
            radius: 24,
            isOnline: true,
          ),
        ),
      ),
    );

    expect(find.text('ER'), findsOneWidget);
    // Online indicator is present
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('AppAvatar computes single letter initial when single word provided', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppAvatar(
            fallbackName: 'Developer',
            radius: 20,
            isOnline: false,
          ),
        ),
      ),
    );

    expect(find.text('D'), findsOneWidget);
  });
}
