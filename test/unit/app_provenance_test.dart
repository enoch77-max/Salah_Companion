import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/constants/app_provenance.dart';

void main() {
  group('AppProvenance Unit Tests', () {
    test('contains authentic copyright author metadata', () {
      expect(AppProvenance.author, equals('enoch77-max'));
      expect(AppProvenance.repositoryUrl, contains('enoch77-max/Salah_Companion'));
      expect(AppProvenance.licenseType, equals('PolyForm Noncommercial License 1.0.0'));
      expect(AppProvenance.copyrightNotice, contains('enoch77-max'));
    });

    test('digitalSignature contains compiled cryptographic fingerprint', () {
      expect(
        AppProvenance.digitalSignature,
        startsWith('SALAH_COMPANION_ORIGINAL_AUTHOR_ENOCH77_MAX'),
      );
      expect(
        AppProvenance.digitalSignature,
        contains('POLYFORM_NC_1.0_FINGERPRINT'),
      );
    });

    test('verifyProvenance returns true for authentic builds', () {
      expect(AppProvenance.verifyProvenance(), isTrue);
    });

    test('summary provides clean audit metadata', () {
      final summary = AppProvenance.summary;
      expect(summary, contains('Salah Companion'));
      expect(summary, contains('enoch77-max'));
      expect(summary, contains('PolyForm Noncommercial License 1.0.0'));
    });
  });
}
