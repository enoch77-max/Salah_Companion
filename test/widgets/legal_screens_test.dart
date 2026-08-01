import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:drift/native.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/core/services/battery_service.dart';
import 'package:salah_companion/features/legal/presentation/screens/calculation_docs_screen.dart';
import 'package:salah_companion/features/legal/presentation/screens/privacy_policy_screen.dart';
import 'package:salah_companion/features/legal/presentation/screens/terms_screen.dart';
import 'package:salah_companion/features/settings/presentation/screens/settings_screen.dart';

void main() {
  group('Legal & Documentation Screens Widget Tests', () {
    Widget buildTestableWidget(Widget child) {
      return MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        home: child,
      );
    }

    testWidgets('renders PrivacyPolicyScreen with open source and zero tracking text', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const PrivacyPolicyScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Privacy Policy'), findsOneWidget);
      expect(find.text('100% Private & Open Source'), findsOneWidget);
      expect(find.text('Completely Free & Open Source'), findsOneWidget);
      expect(find.text('Zero Ads & Zero Commercial Tracking'), findsOneWidget);
      expect(find.text('Local-Only GPS Usage'), findsOneWidget);
    });

    testWidgets('renders TermsScreen with terms of service and calculation disclaimer', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const TermsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Terms & Conditions'), findsOneWidget);
      expect(find.text('Terms of Service'), findsOneWidget);
      expect(find.textContaining('1. Open Source & License'), findsOneWidget);
      expect(find.textContaining('2. Calculation Disclaimer'), findsOneWidget);
    });

    testWidgets('renders CalculationDocsScreen with FAQ explaining 1-3 min variations', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const CalculationDocsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Calculation Accuracy & FAQ'), findsOneWidget);
      expect(find.text('Understanding Prayer Times'), findsOneWidget);
      expect(find.textContaining('Why do prayer times differ by a few minutes'), findsOneWidget);
      expect(find.textContaining('Regional Calculation Methods'), findsOneWidget);
    });

    testWidgets('renders SettingsScreen with ABOUT & PRIVACY section and navigates to screens', (tester) async {
      await tester.pumpWidget(buildTestableWidget(SettingsScreen(batteryService: FakeBatteryService())));
      await tester.pumpAndSettle();

      expect(find.text('ABOUT & PRIVACY'), findsOneWidget);
      expect(find.byKey(const ValueKey('privacy_policy_tile')), findsOneWidget);
      expect(find.byKey(const ValueKey('terms_tile')), findsOneWidget);
      expect(find.byKey(const ValueKey('calculation_docs_tile')), findsOneWidget);

      // Ensure tile is scrolled into view and tap Privacy Policy tile
      await tester.ensureVisible(find.byKey(const ValueKey('privacy_policy_tile')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('privacy_policy_tile')));
      await tester.pumpAndSettle();
      expect(find.text('Your Privacy is Sacred'), findsOneWidget);

      // Pop back
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);
    });
  });
}

class FakeBatteryService extends BatteryService {
  FakeBatteryService() : super(db: AppDatabase(NativeDatabase.memory()));

  @override
  Future<bool> checkBatteryOptimizationStatus() async => true;

  @override
  Future<bool> isIgnoringBatteryOptimizations() async => true;

  @override
  Future<String> getManufacturer() async => 'Samsung';
}
