import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/core/services/location_service.dart';
import 'package:salah_companion/features/qibla/presentation/screens/qibla_screen.dart';

final Uint8List _kFontBytes = Uint8List.fromList([
  0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
]);

class MockCompassEvent implements CompassEvent {
  @override
  final double? heading;
  @override
  final double? accuracy;
  @override
  final double? headingForCameraMode;

  const MockCompassEvent({
    this.heading,
    this.accuracy,
    this.headingForCameraMode,
  });
}

class FakeLocationService implements LocationService {
  final LocationData? locationData;
  final Exception? errorToThrow;

  FakeLocationService({
    this.locationData,
    this.errorToThrow,
  });

  @override
  Future<LocationData> getCurrentLocation({
    PositionFetcher? positionFetcher,
    PlacemarkFetcher? placemarkFetcher,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return locationData ??
        const LocationData(
          latitude: 24.7136,
          longitude: 46.6753,
          city: 'Riyadh',
          countryName: 'Saudi Arabia',
        );
  }

  @override
  Future<LocationData?> getCachedLocation() async => locationData;

  @override
  Future<void> cacheLocation(LocationData location) async {}

  @override
  Stream<LocationData> listenToHighAccuracyUpdates() async* {
    if (locationData != null) yield locationData!;
  }

  @override
  Future<bool> openLocationSettings() async => true;
}

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
      if (message == null) return null;
      final key = const StringCodec().decodeMessage(message);
      if (key != null && key.contains('AssetManifest')) {
        return manifestBinaryData;
      }
      return ByteData.sublistView(_kFontBytes);
    });
  });

  Widget buildTestableWidget(Widget child, {ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? AppTheme.dark,
      home: child,
    );
  }

  group('QiblaScreen Widget Tests', () {
    testWidgets('renders QiblaScreen correctly with initial location and compass heading',
        (tester) async {
      final compassController = StreamController<CompassEvent>.broadcast();
      const sampleLocation = LocationData(
        latitude: 24.7136,
        longitude: 46.6753,
        city: 'Riyadh',
        countryName: 'Saudi Arabia',
      );

      await tester.pumpWidget(
        buildTestableWidget(
          QiblaScreen(
            initialLocation: sampleLocation,
            initialQiblaBearing: 255.0,
            compassEvents: compassController.stream,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Qibla Compass'), findsOneWidget);
      expect(find.text('Riyadh, Saudi Arabia'), findsOneWidget);
      expect(find.textContaining('TRUE NORTH'), findsOneWidget);
      expect(find.text('HEADING (TRUE)'), findsOneWidget);
      expect(find.text('QIBLA BEARING'), findsOneWidget);
      expect(find.text('255° W'), findsOneWidget);

      compassController.add(const MockCompassEvent(heading: 180.0, accuracy: 5.0));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.textContaining('° S'), findsOneWidget);
      expect(find.textContaining('TURN'), findsOneWidget);

      await compassController.close();
    });

    testWidgets('displays ALIGNED WITH QIBLA state when heading is within ±3 degrees of Qibla bearing',
        (tester) async {
      final compassController = StreamController<CompassEvent>.broadcast();

      await tester.pumpWidget(
        buildTestableWidget(
          QiblaScreen(
            initialLocation: const LocationData(
              latitude: 24.7136,
              longitude: 46.6753,
            ),
            initialQiblaBearing: 255.0,
            compassEvents: compassController.stream,
          ),
        ),
      );
      await tester.pump();

      // Heading magnetic = 251.4 (with Riyadh declination ~ +3.6° -> true heading ~ 255.0°, aligned)
      compassController.add(const MockCompassEvent(heading: 251.4, accuracy: 2.0));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('ALIGNED WITH QIBLA'), findsOneWidget);

      await compassController.close();
    });

    testWidgets('displays sensor accuracy warning pill when compass accuracy is low',
        (tester) async {
      final compassController = StreamController<CompassEvent>.broadcast();

      await tester.pumpWidget(
        buildTestableWidget(
          QiblaScreen(
            initialLocation: const LocationData(
              latitude: 24.7136,
              longitude: 46.6753,
            ),
            initialQiblaBearing: 255.0,
            compassEvents: compassController.stream,
          ),
        ),
      );
      await tester.pump();

      // Accuracy = 25.0 (> 15.0 limit)
      compassController.add(const MockCompassEvent(heading: 180.0, accuracy: 25.0));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byKey(const ValueKey('sensor_warning_pill')), findsOneWidget);
      expect(find.textContaining('Compass accuracy low'), findsOneWidget);

      await compassController.close();
    });

    testWidgets('displays sensor unavailable warning pill when compass heading is null',
        (tester) async {
      final compassController = StreamController<CompassEvent>.broadcast();

      await tester.pumpWidget(
        buildTestableWidget(
          QiblaScreen(
            initialLocation: const LocationData(
              latitude: 24.7136,
              longitude: 46.6753,
            ),
            initialQiblaBearing: 255.0,
            compassEvents: compassController.stream,
          ),
        ),
      );
      await tester.pump();

      compassController.add(const MockCompassEvent(heading: null, accuracy: null));
      await tester.pump();

      expect(find.byKey(const ValueKey('sensor_warning_pill')), findsOneWidget);
      expect(find.text('Compass sensor unavailable'), findsOneWidget);

      await compassController.close();
    });

    testWidgets('displays location error view when location fetching fails', (tester) async {
      final fakeLocationService = FakeLocationService(
        errorToThrow: const LocationException('Location permissions were denied.'),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          QiblaScreen(
            locationService: fakeLocationService,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Location Access Failed'), findsOneWidget);
      expect(find.text('Location permissions were denied.'), findsOneWidget);
      expect(find.text('Retry Location'), findsOneWidget);
    });
  });
}
