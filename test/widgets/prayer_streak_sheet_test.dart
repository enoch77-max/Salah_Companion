import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/home/presentation/widgets/prayer_streak_sheet.dart';

void main() {
  Widget buildSheetWidget({VoidCallback? onDismiss}) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => PrayerStreakSheet.show(context, onDismiss: onDismiss),
            child: const Text('Show Sheet'),
          ),
        ),
      ),
    );
  }

  testWidgets('PrayerStreakSheet renders title, subtitle, 5 prayer chips, verse, and dismiss button', (tester) async {
    bool dismissed = false;
    await tester.pumpWidget(buildSheetWidget(onDismiss: () => dismissed = true));

    // Tap to open sheet
    await tester.tap(find.text('Show Sheet'));
    await tester.pumpAndSettle();

    // Verify Title & Subtitle
    expect(find.text('ALL 5 PRAYERS COMPLETED!'), findsOneWidget);
    expect(find.textContaining("Masha'Allah! You have completed all 5 daily prayers today."), findsOneWidget);

    // Verify 5 Prayer Chips
    expect(find.text('Fajr'), findsOneWidget);
    expect(find.text('Dhuhr'), findsOneWidget);
    expect(find.text('Asr'), findsOneWidget);
    expect(find.text('Maghrib'), findsOneWidget);
    expect(find.text('Isha'), findsOneWidget);

    // Verify Verse
    expect(find.textContaining('Surah An-Nisa (4:103)'), findsOneWidget);

    // Tap ALHAMDULILLAH button
    await tester.tap(find.text('ALHAMDULILLAH'));
    await tester.pumpAndSettle();

    expect(dismissed, isTrue);
    expect(find.text('ALL 5 PRAYERS COMPLETED!'), findsNothing);
  });
}
