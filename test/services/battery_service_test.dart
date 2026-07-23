import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/database/app_database.dart';
import 'package:salah_companion/core/services/battery_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late BatteryService batteryService;

  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    batteryService = BatteryService(
      db: db,
      platform: TargetPlatform.android,
    );
  });

  tearDown(() async {
    await db.close();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(BatteryService.defaultChannel, null);
  });

  group('BatteryService MethodChannel & Platform tests', () {
    test('isIgnoringBatteryOptimizations returns channel value on Android',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(BatteryService.defaultChannel,
              (call) async {
        if (call.method == 'isIgnoringBatteryOptimizations') {
          return true;
        }
        return null;
      });

      final result = await batteryService.isIgnoringBatteryOptimizations();
      expect(result, isTrue);
    });

    test(
        'isIgnoringBatteryOptimizations returns false when channel returns false',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(BatteryService.defaultChannel,
              (call) async {
        if (call.method == 'isIgnoringBatteryOptimizations') {
          return false;
        }
        return null;
      });

      final result = await batteryService.isIgnoringBatteryOptimizations();
      expect(result, isFalse);
    });

    test('isIgnoringBatteryOptimizations returns true on non-Android platform',
        () async {
      final iosService = BatteryService(
        db: db,
        platform: TargetPlatform.iOS,
      );
      final result = await iosService.isIgnoringBatteryOptimizations();
      expect(result, isTrue);
    });

    test('checkBatteryOptimizationStatus updates lastKnownExempt in DB',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(BatteryService.defaultChannel,
              (call) async {
        return false;
      });

      final isExempt = await batteryService.checkBatteryOptimizationStatus();
      expect(isExempt, isFalse);

      final state = await batteryService.getBatteryState();
      expect(state, isNotNull);
      expect(state!.lastKnownExempt, isFalse);
    });
  });

  group('BatteryService Cooldown & Prompt Logic tests', () {
    test('shouldShowPrompt returns true when not exempt and lastPromptAt is null',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(BatteryService.defaultChannel,
              (call) async {
        return false;
      });

      await batteryService.checkBatteryOptimizationStatus();
      final shouldShow = await batteryService.shouldShowPrompt();
      expect(shouldShow, isTrue);
    });

    test('shouldShowPrompt returns false when exempt is true', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(BatteryService.defaultChannel,
              (call) async {
        return true;
      });
      await batteryService.checkBatteryOptimizationStatus();

      final shouldShow = await batteryService.shouldShowPrompt();
      expect(shouldShow, isFalse);
    });

    test('shouldShowPrompt respects 24-hour cooldown', () async {
      final now = DateTime(2026, 7, 24, 12, 0, 0);

      // Record prompt shown at `now`
      await batteryService.recordPromptShown(now);

      // 23 hours later: should NOT show prompt
      final hour23 = now.add(const Duration(hours: 23));
      final showAt23 = await batteryService.shouldShowPrompt(now: hour23);
      expect(showAt23, isFalse);

      // 24 hours later: should show prompt
      final hour24 = now.add(const Duration(hours: 24));
      final showAt24 = await batteryService.shouldShowPrompt(now: hour24);
      expect(showAt24, isTrue);

      // 25 hours later: should show prompt
      final hour25 = now.add(const Duration(hours: 25));
      final showAt25 = await batteryService.shouldShowPrompt(now: hour25);
      expect(showAt25, isTrue);
    });

    test('shouldShowPrompt returns false when nagDisabled is true', () async {
      await batteryService.setNagDisabled(true);

      final state = await batteryService.getBatteryState();
      expect(state!.nagDisabled, isTrue);

      final shouldShow = await batteryService.shouldShowPrompt();
      expect(shouldShow, isFalse);
    });
  });

  group('BatteryService OEM Guidance tests', () {
    test('getOemGuidance returns correct text for OEMs', () {
      expect(batteryService.getOemGuidance('Samsung'), contains('Unrestricted'));
      expect(batteryService.getOemGuidance('samsung'), contains('Background usage limits'));

      expect(batteryService.getOemGuidance('Xiaomi'), contains('Autostart'));
      expect(batteryService.getOemGuidance('Redmi'), contains('Autostart'));

      expect(batteryService.getOemGuidance('Huawei'), contains('Auto-launch'));
      expect(batteryService.getOemGuidance('Honor'), contains('Auto-launch'));

      expect(batteryService.getOemGuidance('Oppo'), contains('auto-startup'));
      expect(batteryService.getOemGuidance('Realme'), contains('auto-startup'));

      expect(batteryService.getOemGuidance('Vivo'),
          contains('High background power consumption'));
      expect(batteryService.getOemGuidance('iQOO'),
          contains('High background power consumption'));

      expect(batteryService.getOemGuidance('Google Pixel'),
          contains('Unrestricted'));
    });
  });
}
