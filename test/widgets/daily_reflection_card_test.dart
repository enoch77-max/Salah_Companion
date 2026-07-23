import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mocktail/mocktail.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/home/presentation/widgets/daily_reflection_card.dart';
import 'package:salah_companion/features/reflection/data/repositories/daily_content_repository.dart';
import 'package:salah_companion/features/reflection/domain/models/daily_content.dart';
import 'package:salah_companion/features/reflection/presentation/screens/favorites_screen.dart';

class MockDailyContentRepository extends Mock implements DailyContentRepository {}

final Uint8List _kFontBytes = Uint8List.fromList([
  0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;

    final fontList = [
      'packages/google_fonts/fonts/Inter-Bold.ttf',
      'packages/google_fonts/fonts/Inter-SemiBold.ttf',
      'packages/google_fonts/fonts/Inter-Medium.ttf',
      'packages/google_fonts/fonts/Inter-Regular.ttf',
      'packages/google_fonts/fonts/Amiri-Regular.ttf',
      'packages/google_fonts/fonts/Lora-Italic.ttf',
      'packages/google_fonts/fonts/NotoSansArabic-Regular.ttf',
    ];

    final manifestMap = <String, List<Object?>>{
      for (final font in fontList) font: [font],
    };

    final manifestBinaryData = const StandardMessageCodec().encodeMessage(manifestMap);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      if (message == null) return null;
      final key = const StringCodec().decodeMessage(message);
      if (key != null && key.contains('AssetManifest')) {
        return manifestBinaryData;
      }
      return ByteData.sublistView(_kFontBytes);
    });
  });

  final testHadith = const DailyContentItem(
    id: 'hadith_1',
    type: DailyContentType.hadith,
    reference: 'Sahih al-Bukhari 1',
    sourceWeight: 1.0,
    grade: 'Sahih',
    gradedBy: 'Al-Bukhari',
    arabicText: 'إنما الأعمال بالنيات',
    translationText: 'Actions are judged by intentions.',
    translationSource: 'Bukhari',
  );

  final testAyah = const DailyContentItem(
    id: 'ayah_1',
    type: DailyContentType.ayah,
    reference: 'Surah Al-Baqarah 2:255',
    sourceWeight: 1.0,
    arabicText: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
    translationText: 'Allah! There is no deity except Him, the Ever-Living, the Sustainer of all existence.',
    translationSource: 'Saheeh International',
  );

  Widget buildTestableWidget(Widget child, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.dark,
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('DailyReflectionCard Widget Tests', () {
    testWidgets('renders Hadith content with grade and gradedBy caption', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DailyReflectionCard(
            content: testHadith,
            isFavorited: false,
            onToggleFavorite: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('إنما الأعمال بالنيات'), findsOneWidget);
      expect(find.text('Actions are judged by intentions.'), findsOneWidget);
      expect(find.text('Sahih al-Bukhari 1 • Sahih • Al-Bukhari'), findsOneWidget);
      expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);
    });

    testWidgets('renders Ayah content correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DailyReflectionCard(
            content: testAyah,
            isFavorited: true,
            onToggleFavorite: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ'), findsOneWidget);
      expect(find.text('Allah! There is no deity except Him, the Ever-Living, the Sustainer of all existence.'), findsOneWidget);
      expect(find.text('Surah Al-Baqarah 2:255'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    });

    testWidgets('triggers onToggleFavorite callback when star icon is tapped', (tester) async {
      bool toggled = false;

      await tester.pumpWidget(
        buildTestableWidget(
          DailyReflectionCard(
            content: testHadith,
            isFavorited: false,
            onToggleFavorite: () {
              toggled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('star_icon')));
      await tester.pumpAndSettle();

      expect(toggled, isTrue);
    });

    testWidgets('triggers onShare callback when share icon is tapped', (tester) async {
      bool shared = false;

      await tester.pumpWidget(
        buildTestableWidget(
          DailyReflectionCard(
            content: testHadith,
            isFavorited: false,
            onToggleFavorite: () {},
            onShare: () {
              shared = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Share'));
      await tester.pumpAndSettle();

      expect(shared, isTrue);
    });
  });

  group('FavoritesScreen Widget Tests', () {
    testWidgets('displays clean empty state when list is empty', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const FavoritesScreen(
            initialItems: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No favorites saved yet'), findsOneWidget);
      expect(find.text('Tap the star icon on any daily reflection to save it here.'), findsOneWidget);
    });

    testWidgets('renders list of favorited items correctly', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          FavoritesScreen(
            initialItems: [testHadith, testAyah],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DailyReflectionCard), findsNWidgets(2));
      expect(find.text('Sahih al-Bukhari 1 • Sahih • Al-Bukhari'), findsOneWidget);
      expect(find.text('Surah Al-Baqarah 2:255'), findsOneWidget);
    });

    testWidgets('unfavorites and removes item optimistically on star tap', (tester) async {
      final repo = MockDailyContentRepository();
      when(() => repo.toggleFavorite('hadith_1')).thenAnswer((_) async {});

      await tester.pumpWidget(
        buildTestableWidget(
          FavoritesScreen(
            repository: repo,
            initialItems: [testHadith, testAyah],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DailyReflectionCard), findsNWidgets(2));

      // Tap star on first item (hadith_1)
      await tester.tap(find.byKey(const ValueKey('star_icon')).first);
      await tester.pumpAndSettle();

      // Optimistically removed
      expect(find.byType(DailyReflectionCard), findsOneWidget);
      expect(find.text('Sahih al-Bukhari 1 • Sahih • Al-Bukhari'), findsNothing);
      expect(find.text('Surah Al-Baqarah 2:255'), findsOneWidget);

      verify(() => repo.toggleFavorite('hadith_1')).called(1);
    });

    testWidgets('restores item and shows SnackBar when repository.toggleFavorite throws an exception', (tester) async {
      final repo = MockDailyContentRepository();
      when(() => repo.toggleFavorite('hadith_1')).thenThrow(Exception('Database error'));

      await tester.pumpWidget(
        buildTestableWidget(
          FavoritesScreen(
            repository: repo,
            initialItems: [testHadith, testAyah],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DailyReflectionCard), findsNWidgets(2));

      // Tap star on first item (hadith_1)
      await tester.tap(find.byKey(const ValueKey('star_icon')).first);
      await tester.pumpAndSettle();

      // Item should be restored and SnackBar error message displayed
      expect(find.byType(DailyReflectionCard), findsNWidgets(2));
      expect(find.text('Sahih al-Bukhari 1 • Sahih • Al-Bukhari'), findsOneWidget);
      expect(find.text('Failed to update favorite status'), findsOneWidget);

      verify(() => repo.toggleFavorite('hadith_1')).called(1);
    });
  });
}
