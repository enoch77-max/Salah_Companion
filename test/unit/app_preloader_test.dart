import 'package:flutter_test/flutter_test.dart';
import 'package:salah_companion/core/services/app_preloader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppPreloader Tests', () {
    test('prewarm executes cleanly without throwing exceptions', () async {
      await expectLater(AppPreloader.prewarm(), completes);
    });
  });
}
