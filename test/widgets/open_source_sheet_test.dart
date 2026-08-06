import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/home/presentation/widgets/open_source_sheet.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: child),
  );
}

void main() {
  group('OpenSourceSheet Widget Tests', () {
    testWidgets('renders OpenSourceSheet title, privacy tiles, and GitHub button', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const OpenSourceSheet()),
      );
      await tester.pump();

      expect(find.text('100% Open Source'), findsOneWidget);
      expect(find.text('Transparent & Privacy-First'), findsOneWidget);
      expect(find.text('Non-Commercial'), findsOneWidget);
      expect(find.text('Zero Data Stored or Shared'), findsOneWidget);
      expect(find.text('100% Offline Capability'), findsOneWidget);
      expect(find.text('Fully Auditable Code'), findsOneWidget);
      expect(find.text('enoch77-max/Salah_Companion'), findsOneWidget);
      expect(find.text('View Code on GitHub'), findsOneWidget);
    });

    testWidgets('show modal sheet opens OpenSourceSheet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => OpenSourceSheet.show(context),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(OpenSourceSheet), findsOneWidget);
    });
  });
}
