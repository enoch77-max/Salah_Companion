import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<Map<String, dynamic>> rawDataset;

  setUpAll(() {
    final file = File('assets/data/daily_content.json');
    expect(file.existsSync(), isTrue,
        reason: 'assets/data/daily_content.json file must exist');

    final jsonString = file.readAsStringSync();
    final decoded = json.decode(jsonString);
    expect(decoded, isA<List>(),
        reason: 'daily_content.json root element must be a JSON array');

    rawDataset = (decoded as List).cast<Map<String, dynamic>>();
  });

  group('Full Dataset Sanity Verification Tests', () {
    test('Total entries count >= 180', () {
      expect(rawDataset.length, greaterThanOrEqualTo(180),
          reason: 'Dataset must contain at least 180 entries');
    });

    test('100% of Hadith entries must have grade == "Sahih"', () {
      final hadiths = rawDataset.where((item) => item['type'] == 'hadith');
      expect(hadiths.isNotEmpty, isTrue, reason: 'Dataset must contain hadiths');

      for (final item in hadiths) {
        expect(item['grade'], equals('Sahih'),
            reason: 'Hadith ${item['id']} must have grade == "Sahih"');
      }
    });

    test('100% of Hadith entries must have non-empty graded_by field', () {
      final hadiths = rawDataset.where((item) => item['type'] == 'hadith');
      expect(hadiths.isNotEmpty, isTrue, reason: 'Dataset must contain hadiths');

      for (final item in hadiths) {
        final gradedBy = item['graded_by'];
        expect(gradedBy, isNotNull,
            reason: 'Hadith ${item['id']} must have graded_by field');
        expect(gradedBy is String && gradedBy.trim().isNotEmpty, isTrue,
            reason: 'Hadith ${item['id']} must have non-empty graded_by');
      }
    });

    test(
        'All entries MUST have non-empty id, type, arabic_text, translation_text, translation_source, reference',
        () {
      for (final item in rawDataset) {
        final id = item['id'];
        expect(id, isNotNull, reason: 'Item missing id');
        expect(id is String && id.trim().isNotEmpty, isTrue,
            reason: 'Item has empty id');

        final type = item['type'];
        expect(type, isNotNull, reason: 'Item $id missing type');
        expect(type is String && (type == 'hadith' || type == 'ayah'), isTrue,
            reason: 'Item $id has invalid type $type');

        final arabicText = item['arabic_text'];
        expect(arabicText, isNotNull, reason: 'Item $id missing arabic_text');
        expect(arabicText is String && arabicText.trim().isNotEmpty, isTrue,
            reason: 'Item $id has empty arabic_text');

        final translationText = item['translation_text'];
        expect(translationText, isNotNull,
            reason: 'Item $id missing translation_text');
        expect(
            translationText is String && translationText.trim().isNotEmpty,
            isTrue,
            reason: 'Item $id has empty translation_text');

        final translationSource = item['translation_source'];
        expect(translationSource, isNotNull,
            reason: 'Item $id missing translation_source');
        expect(
            translationSource is String && translationSource.trim().isNotEmpty,
            isTrue,
            reason: 'Item $id has empty translation_source');

        final reference = item['reference'];
        expect(reference, isNotNull, reason: 'Item $id missing reference');
        expect(reference is String && reference.trim().isNotEmpty, isTrue,
            reason: 'Item $id has empty reference');
      }
    });

    test('No duplicate IDs across entire dataset', () {
      final seenIds = <String>{};
      final duplicateIds = <String>{};

      for (final item in rawDataset) {
        final id = item['id'] as String;
        if (seenIds.contains(id)) {
          duplicateIds.add(id);
        } else {
          seenIds.add(id);
        }
      }

      expect(duplicateIds, isEmpty,
          reason: 'Duplicate IDs found in dataset: $duplicateIds');
    });

    test('source_weight is defined and > 0 for all items', () {
      for (final item in rawDataset) {
        final id = item['id'];
        final sourceWeight = item['source_weight'];
        expect(sourceWeight, isNotNull,
            reason: 'Item $id missing source_weight');
        expect(sourceWeight is num && sourceWeight > 0, isTrue,
            reason: 'Item $id source_weight ($sourceWeight) must be > 0');
      }
    });

    test('Dataset contains entries from at least 3 distinct hadith collections',
        () {
      final hadiths = rawDataset.where((item) => item['type'] == 'hadith');
      final collections = <String>{};

      for (final item in hadiths) {
        final source = item['source'] as String?;
        if (source != null && source.trim().isNotEmpty) {
          collections.add(source.trim());
        }
      }

      expect(collections.length, greaterThanOrEqualTo(3),
          reason:
              'Expected at least 3 distinct hadith collections, found ${collections.length}: $collections');
    });
  });
}
