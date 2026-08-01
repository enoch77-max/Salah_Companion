import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:salah_companion/features/home/presentation/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders successfully in app context', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(animateHero: false),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
