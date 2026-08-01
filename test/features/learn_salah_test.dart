import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/learn_salah/data/salah_guide_data.dart';
import 'package:salah_companion/features/learn_salah/domain/models/salah_learning_models.dart';
import 'package:salah_companion/features/learn_salah/presentation/screens/learn_salah_hub_screen.dart';
import 'package:salah_companion/features/learn_salah/presentation/screens/salah_step_by_step_screen.dart';
import 'package:salah_companion/features/learn_salah/presentation/screens/salah_category_detail_screen.dart';
import 'package:salah_companion/features/learn_salah/presentation/widgets/posture_avatars.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: child,
    );
  }

  group('Learn Salah Feature Tests', () {
    test('SalahGuideData contains valid prophetic steps and references', () {
      expect(SalahGuideData.propheticSteps.isNotEmpty, isTrue);
      expect(SalahGuideData.pillars.length, equals(14));
      expect(SalahGuideData.obligations.length, equals(8));
      expect(SalahGuideData.errorsToAvoid.isNotEmpty, isTrue);

      final step0 = SalahGuideData.propheticSteps.first;
      expect(step0.title, contains('Preparing'));
      expect(step0.references.isNotEmpty, isTrue);
    });

    testWidgets('PostureAvatarWidget renders correctly for various posture keys', (tester) async {
      await tester.pumpWidget(createTestableWidget(
        const Column(
          children: [
            PostureAvatarWidget(postureKey: 'raf_al_yadayn'),
            PostureAvatarWidget(postureKey: 'ruku'),
            PostureAvatarWidget(postureKey: 'sujood'),
          ],
        ),
      ));

      expect(find.byType(PostureAvatarWidget), findsNWidgets(3));
    });

    testWidgets('LearnSalahHubScreen renders modules and opens Step-by-Step Guide', (tester) async {
      await tester.pumpWidget(createTestableWidget(const LearnSalahHubScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Learn Salah'), findsOneWidget);
      expect(find.text('AUTHENTIC SUNNAH GUIDE'), findsOneWidget);
      expect(find.text('Step-by-Step Prophetic Guide'), findsOneWidget);
      expect(find.text('The 14 Pillars of Salah (Arkan)'), findsOneWidget);

      // Tap Step-by-Step Guide card
      await tester.tap(find.text('Step-by-Step Prophetic Guide'));
      await tester.pumpAndSettle();

      expect(find.byType(SalahStepByStepScreen), findsOneWidget);
    });

    testWidgets('SalahStepByStepScreen renders step content and expands proof tile', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalahStepByStepScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Step 0 of 9'), findsOneWidget);
      expect(find.text('Authentic Evidence & Hadiths'), findsOneWidget);

      // Tap to expand references tile
      await tester.tap(find.text('Authentic Evidence & Hadiths'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Sahih Muslim, Hadith 223'), findsOneWidget);
    });

    testWidgets('SalahCategoryDetailScreen renders category items correctly', (tester) async {
      await tester.pumpWidget(createTestableWidget(
        const SalahCategoryDetailScreen(
          title: '14 Pillars of Salah (Arkan)',
          category: SalahRuleCategory.pillar,
          items: SalahGuideData.pillars,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('14 Pillars of Salah (Arkan)'), findsOneWidget);
      expect(find.text('Standing (Qiyam)'), findsOneWidget);
      expect(find.text('Opening Takbir (Takbirat al-Ihram)'), findsOneWidget);
    });
  });
}
