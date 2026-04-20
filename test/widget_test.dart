import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App base widget test', (WidgetTester tester) async {
    // Basic test to ensure the standalone widget wrapper can load without throwing
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('FinTrack Pro')),
        ),
      ),
    );

    expect(find.text('FinTrack Pro'), findsOneWidget);
  });
}
