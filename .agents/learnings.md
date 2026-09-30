# Project Learnings: Salah Companion

## Battery Optimization & Doze Mode
- `Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` requires `<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />` in `AndroidManifest.xml`. Without this permission, Android throws `SecurityException` when attempting to show the direct 1-tap exemption dialog.
- Intent calls from Flutter/Activity must include `Intent.FLAG_ACTIVITY_NEW_TASK` to guarantee seamless navigation across all Android versions (API 23 to 35).
- On Android, `AppLifecycleState.resumed` fires during app launch and when returning from external dialogs/settings. If `recordPromptShown()` is not called when the battery sheet is presented, `shouldShowPrompt()` will evaluate to `true` immediately upon resume, causing infinite prompt pop-up loops.
- `BatteryProtectionListener` needs an in-session guard and prompt-time recording to prevent re-opening sheets across lifecycle blinks.
