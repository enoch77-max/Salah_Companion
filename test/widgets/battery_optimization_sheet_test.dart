import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/core/services/battery_service.dart';
import 'package:salah_companion/features/battery_protection/presentation/sheets/battery_optimization_sheet.dart';
import 'package:salah_companion/features/battery_protection/presentation/widgets/battery_protection_listener.dart';

final Uint8List _kFontBytes = Uint8List.fromList([
  0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late BatteryService batteryService;

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

    final manifestBinaryData =
        const StandardMessageCodec().encodeMessage(manifestMap);

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

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    batteryService = BatteryService(
      db: db,
      platform: TargetPlatform.android,
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(BatteryService.defaultChannel, (call) async {
      if (call.method == 'isIgnoringBatteryOptimizations') {
        return false;
      }
      return null;
    });
  });

  tearDown(() async {
    await db.close();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(BatteryService.defaultChannel, null);
  });

  Widget buildTestableWidget(Widget child, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.dark,
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('BatteryOptimizationSheet Widget Tests', () {
    testWidgets('renders title, body text, and action buttons', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BatteryOptimizationSheet(
            onFixPressed: () {},
            onRemindLaterPressed: () {},
            onDontAskAgainPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Prayer alerts may be delayed'), findsOneWidget);
      expect(
        find.text(
          'Battery optimization is on for Salah Companion. Some devices delay or block the adhan when this is enabled.',
        ),
        findsOneWidget,
      );
      expect(find.text('Disable Battery Optimization'), findsOneWidget);
      expect(find.text('Remind me later'), findsOneWidget);
      expect(find.text("Don't ask again"), findsOneWidget);
      expect(find.byIcon(Icons.battery_alert_rounded), findsOneWidget);
    });

    testWidgets('renders OEM guidance when provided', (tester) async {
      const sampleGuidance =
          "Go to Settings > Apps > Salah Companion > Battery > Select 'Unrestricted'.";

      await tester.pumpWidget(
        buildTestableWidget(
          BatteryOptimizationSheet(
            onFixPressed: () {},
            onRemindLaterPressed: () {},
            onDontAskAgainPressed: () {},
            oemGuidance: sampleGuidance,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(sampleGuidance), findsOneWidget);
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
    });

    testWidgets('does not render OEM guidance section when oemGuidance is null',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BatteryOptimizationSheet(
            onFixPressed: () {},
            onRemindLaterPressed: () {},
            onDontAskAgainPressed: () {},
            oemGuidance: null,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.info_outline_rounded), findsNothing);
    });

    testWidgets('triggers onFixPressed callback when Disable Battery Optimization button is tapped',
        (tester) async {
      bool fixPressed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                BatteryOptimizationSheet.show(
                  context,
                  onFixPressed: () {
                    fixPressed = true;
                  },
                  onRemindLaterPressed: () {},
                  onDontAskAgainPressed: () {},
                );
              },
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      expect(find.text('Prayer alerts may be delayed'), findsOneWidget);

      await tester.tap(find.text('Disable Battery Optimization'));
      await tester.pumpAndSettle();

      expect(fixPressed, isTrue);
      expect(find.text('Prayer alerts may be delayed'), findsNothing);
    });

    testWidgets(
        'triggers onRemindLaterPressed callback when Remind me later button is tapped',
        (tester) async {
      bool remindPressed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                BatteryOptimizationSheet.show(
                  context,
                  onFixPressed: () {},
                  onRemindLaterPressed: () {
                    remindPressed = true;
                  },
                  onDontAskAgainPressed: () {},
                );
              },
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Remind me later'));
      await tester.pumpAndSettle();

      expect(remindPressed, isTrue);
      expect(find.text('Prayer alerts may be delayed'), findsNothing);
    });

    testWidgets(
        'triggers onDontAskAgainPressed callback when Don\'t ask again button is tapped',
        (tester) async {
      bool dontAskPressed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                BatteryOptimizationSheet.show(
                  context,
                  onFixPressed: () {},
                  onRemindLaterPressed: () {},
                  onDontAskAgainPressed: () {
                    dontAskPressed = true;
                  },
                );
              },
              child: const Text('Open Sheet'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Sheet'));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Don't ask again"));
      await tester.pumpAndSettle();

      expect(dontAskPressed, isTrue);
      expect(find.text('Prayer alerts may be delayed'), findsNothing);
    });
  });

  group('BatteryProtectionListener Widget Tests', () {
    testWidgets('does not show prompt on iOS platform when resumed',
        (tester) async {
      final iosService = BatteryService(
        db: db,
        platform: TargetPlatform.iOS,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          BatteryProtectionListener(
            batteryService: iosService,
            platform: TargetPlatform.iOS,
            child: const Text('App Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text('Prayer alerts may be delayed'), findsNothing);
      expect(find.text('App Content'), findsOneWidget);
    });

    testWidgets(
        'checks status and displays sheet on Android resume when prompt should show',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BatteryProtectionListener(
            batteryService: batteryService,
            platform: TargetPlatform.android,
            manufacturer: 'Samsung',
            child: const Text('App Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text('Prayer alerts may be delayed'), findsOneWidget);
      expect(find.textContaining('Background usage limits'), findsOneWidget);

      await tester.tap(find.text('Remind me later'));
      await tester.pumpAndSettle();

      final state = await batteryService.getBatteryState();
      expect(state?.lastPromptAt, isNotNull);
    });

    testWidgets('sets nagDisabled when Don\'t ask again is tapped via listener',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BatteryProtectionListener(
            batteryService: batteryService,
            platform: TargetPlatform.android,
            child: const Text('App Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text("Don't ask again"), findsOneWidget);
      await tester.tap(find.text("Don't ask again"));
      await tester.pumpAndSettle();

      final state = await batteryService.getBatteryState();
      expect(state?.nagDisabled, isTrue);
    });

    testWidgets('guards against duplicate popups when already showing prompt',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          BatteryProtectionListener(
            batteryService: batteryService,
            platform: TargetPlatform.android,
            child: const Text('App Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.text('Prayer alerts may be delayed'), findsOneWidget);

      // Resume again while prompt is visible
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      // Only 1 sheet title is visible
      expect(find.text('Prayer alerts may be delayed'), findsOneWidget);
    });
  });
}
