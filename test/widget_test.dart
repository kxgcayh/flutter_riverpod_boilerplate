import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_boilerplate/app.dart';

void main() {
  testWidgets('FlutterBoilerplateApp renders chat list screen and items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: FlutterBoilerplateApp(),
      ),
    );

    // Initial frame
    await tester.pump();
    expect(find.text('Flutter Boilerplate'), findsOneWidget);

    // Advance fake timer for async mock repository and trigger rebuild
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    // Verify chat rooms are rendered
    expect(find.text('Flutter Architecture Guild'), findsOneWidget);
    expect(find.text('Alex Vance'), findsOneWidget);
  });
}
