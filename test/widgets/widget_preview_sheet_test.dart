import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/core/services/widget_service.dart';
import 'package:salah_companion/features/home/presentation/widgets/widget_preview_sheet.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    );
  }

  group('WidgetPreviewSheet Widget Tests', () {
    testWidgets('renders all 3 widget options correctly', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final mockService = WidgetService(prefs: prefs, isAndroid: false);

      await tester.pumpWidget(
        buildTestableWidget(
          WidgetPreviewSheet(widgetService: mockService),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home Screen Widgets'), findsOneWidget);
      expect(find.text('Salah Time'), findsOneWidget);
      expect(find.text('Full Salah Schedule'), findsOneWidget);
      expect(find.text('Daily Dua & Reflection'), findsOneWidget);
      expect(find.text('Add Widget'), findsNWidgets(3));
    });

    testWidgets('shows already added prompt dialog when tapping an already pinned widget', (tester) async {
      SharedPreferences.setMockInitialValues({'widget_pinned_small_salah': true});
      final prefs = await SharedPreferences.getInstance();
      final mockService = WidgetService(prefs: prefs, isAndroid: false);

      await tester.pumpWidget(
        buildTestableWidget(
          WidgetPreviewSheet(widgetService: mockService),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Active on Screen (1)'), findsOneWidget);

      // Tap the pinned widget button
      await tester.tap(find.text('Active on Screen (1)'));
      await tester.pumpAndSettle();

      expect(find.text('Widget Already Added'), findsOneWidget);
      expect(find.textContaining('You already have the "Salah Time" widget'), findsOneWidget);
      expect(find.text('Add Another'), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);
    });
  });
}
