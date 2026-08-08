# Privacy Policy for Salah Companion

**Effective Date**: August 8, 2026  
**License**: PolyForm Noncommercial License 1.0.0  
**GitHub Repository**: [https://github.com/enoch77-max/Salah_Companion](https://github.com/enoch77-max/Salah_Companion)

---

## 1. Zero Tracking Commitment
Salah Companion is built with a strict privacy-first architecture. We believe a worship companion app should respect your spiritual focus without tracking, advertising, or selling user data.

- **Zero Advertisements**: No ad SDKs, banner ads, or promotional tracking.
- **Zero Third-Party Analytics**: No Google Analytics, Firebase Analytics, Mixpanel, or behavioral tracking SDKs.
- **Zero Account Requirement**: No sign-up, email registration, or user accounts.

---

## 2. Location Permission & Usage
Location permissions (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION` on Android; `NSLocationWhenInUseUsageDescription` on iOS) are requested strictly for:
- Calculating exact astronomical prayer times for your current geographic location.
- Determining the magnetic Qibla bearing toward the Kaaba.

**Local-Only Processing**: Your geographical coordinates are calculated entirely on your device using local offline math libraries (`adhan_dart`). Coordinates are **NEVER uploaded** to any remote server or transmitted off-device.

---

## 3. Local Storage & Data Retention
All data—including prayer calculation methods, madhab preferences, logged prayers, and tasbih counts—is stored in a local SQLite database (`drift`) on your device. You remain in 100% control of your data.

---

## 4. Open Source Auditability
The entire source code is available publicly on GitHub for community inspection and security auditing:
[https://github.com/enoch77-max/Salah_Companion](https://github.com/enoch77-max/Salah_Companion)

---

## 5. Contact
For privacy questions or security inquiries, please file an issue on GitHub:
[https://github.com/enoch77-max/Salah_Companion/issues](https://github.com/enoch77-max/Salah_Companion/issues)
