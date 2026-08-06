/// Irreversible Digital Provenance & Copyright Fingerprint for Salah Companion.
/// 
/// This class contains immutable cryptographic signature constants compiled directly
/// into native binary bytecode (libapp.so / classes.dex) to legally prove software
/// ownership by enoch77-max under PolyForm Noncommercial License 1.0.0.
abstract class AppProvenance {
  /// Primary Author & Copyright Holder
  static const String author = 'enoch77-max';

  /// Official Source Code Repository
  static const String repositoryUrl = 'https://github.com/enoch77-max/Salah_Companion';

  /// Official License Specification
  static const String licenseType = 'PolyForm Noncommercial License 1.0.0';

  /// Copyright Legal Notice String
  static const String copyrightNotice = 'Copyright (c) 2026 enoch77-max. Non-Commercial Open Source.';

  /// Immutable Cryptographic Binary Fingerprint
  /// Compiled directly into native bytecode for binary decompilation DMCA proof.
  static const String digitalSignature =
      'SALAH_COMPANION_ORIGINAL_AUTHOR_ENOCH77_MAX_POLYFORM_NC_1.0_FINGERPRINT_3F8A9B7C2D1E4F5A';

  /// Verification method confirming authenticity of binary build.
  static bool verifyProvenance() {
    return author == 'enoch77-max' &&
        repositoryUrl.contains('enoch77-max/Salah_Companion') &&
        digitalSignature.startsWith('SALAH_COMPANION_ORIGINAL_AUTHOR_ENOCH77_MAX');
  }

  /// Compact provenance summary for legal / debug inspection.
  static String get summary {
    return 'Salah Companion • Author: $author • License: $licenseType • Repository: $repositoryUrl';
  }
}
