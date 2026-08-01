import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/onboarding/presentation/widgets/walkthrough_overlay.dart';

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
    ];

    final manifestMap = <String, List<Object?>>{
      for (final font in fontList) font: [font],
    };

    final manifestBinaryData = const StandardMessageCodec().encodeMessage(manifestMap);

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      final String key = const StringCodec().decodeMessage(message) ?? '';
      if (key == 'AssetManifest.bin') {
        return manifestBinaryData;
      }
      return _kFontBytes.buffer.asByteData();
    });
  });

  group('WalkthroughOverlay Widget Tests', () {
    testWidgets('renders WalkthroughOverlay and advances steps on Next tap', (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: WalkthroughOverlay(
              onDismiss: () => dismissed = true,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 350));

      // Step 1: Welcome
      expect(find.text('1 OF 4'), findsOneWidget);
      expect(find.text('Welcome to Salah Companion'), findsOneWidget);
      expect(find.byKey(const ValueKey('walkthrough_next_button')), findsOneWidget);

      // Tap Next to advance to Step 2 (Gesture Demo)
      await tester.tap(find.byKey(const ValueKey('walkthrough_next_button')));
      await tester.pump(const Duration(milliseconds: 350));

      // Step 2: Swipe Edge Navigation
      expect(find.text('2 OF 4'), findsOneWidget);
      expect(find.text('Swipe Left Edge for Menu'), findsOneWidget);
      expect(find.text('SWIPE FROM LEFT EDGE →'), findsOneWidget);

      // Tap Next to advance to Step 3
      await tester.tap(find.byKey(const ValueKey('walkthrough_next_button')));
      await tester.pump(const Duration(milliseconds: 350));

      // Step 3: Authentic Sunnah & Guidance
      expect(find.text('3 OF 4'), findsOneWidget);
      expect(find.text('Authentic Sunnah & Guidance'), findsOneWidget);

      // Tap Next to advance to Step 4
      await tester.tap(find.byKey(const ValueKey('walkthrough_next_button')));
      await tester.pump(const Duration(milliseconds: 350));

      // Step 4: Qibla, Tasbih & Customization
      expect(find.text('4 OF 4'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);

      // Tap Get Started
      await tester.tap(find.byKey(const ValueKey('walkthrough_next_button')));
      await tester.pump(const Duration(milliseconds: 350));

      expect(dismissed, isTrue);
    });

    testWidgets('dismisses WalkthroughOverlay when Skip button is pressed', (WidgetTester tester) async {
      bool dismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(
            body: WalkthroughOverlay(
              onDismiss: () => dismissed = true,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byKey(const ValueKey('walkthrough_skip_button')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('walkthrough_skip_button')));
      await tester.pump(const Duration(milliseconds: 350));

      expect(dismissed, isTrue);
    });
  });
}
