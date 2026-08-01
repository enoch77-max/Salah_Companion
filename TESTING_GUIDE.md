# Adhan Playback Testing Guide

## 🧪 Test Plan

This guide will help you test the Adhan playback functionality after implementing the fixes.

### **1. Test Environment Setup**

**Requirements:**
- Physical Android device (recommended for audio testing)
- Flutter development environment
- App installed with the latest changes

**Test Data:**
- All 4 Adhan audio files in `android/app/src/main/res/raw/`
- Fallback "Allahu akbar" sound file in `android/app/src/main/res/raw/allahu_akbar.mp3`
- Test button added to home screen AppBar

### **2. Test Cases**

#### **Test Case 1: Adhan Voice Selection**
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open Settings → Adhan Voice | Voice selection screen appears |
| 2 | Select "Makkah (Ali Mulla)" | Voice is selected, preview plays |
| 3 | Tap test notification button | Makkah Adhan plays |
| 4 | Repeat for other voices | Correct Adhan plays for each selection |

#### **Test Case 2: Adhan Toggle**
| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Ensure Adhan Audio is ON | Adhan plays when notification fires |
| 2 | Toggle Adhan Audio OFF | Fallback sound plays when notification fires |
| 3 | Tap test notification button | "Allahu akbar Allahu akbar" plays |

#### **Test Case 3: Notification Scenarios**
| Scenario | Expected Result |
|----------|-----------------|
| App in foreground | Notification appears, correct sound plays |
| App in background | Notification appears, correct sound plays |
| App closed | Notification appears, correct sound plays |
| Battery optimization ON | Notification may be delayed (expected) |
| Battery optimization OFF | Notification fires on time |

### **3. Test Procedure**

**Step 1: Build and Install the App**
```bash
flutter clean
flutter pub get
flutter run --release
```

**Step 2: Test Adhan Voice Selection**
1. Open the app
2. Tap the settings button (gear icon)
3. Go to "Adhan Voice" section
4. Select different voices and tap the play button to preview
5. Tap the test notification button (bell icon) to verify the correct sound plays

**Step 3: Test Adhan Toggle**
1. Go to Settings → Notifications
2. Toggle "Adhan Audio" ON and test notification
3. Toggle "Adhan Audio" OFF and test notification
4. Verify fallback sound plays when Adhan is disabled

**Step 4: Test Different Scenarios**
1. Test with app in foreground
2. Test with app in background (press home button)
3. Test with app closed (swipe from recent apps)
4. Test with battery optimization enabled/disabled

### **4. Expected Results**

✅ **Adhan Voice Selection:** Correct Adhan sound plays based on user selection
✅ **Adhan Toggle:** When disabled, fallback sound plays instead of full Adhan
✅ **Platform Support:** Both Android and iOS play sounds correctly
✅ **Notification Scenarios:** Sounds play in all app states (foreground, background, closed)

### **5. Troubleshooting**

**Issue: No sound plays**
- Verify audio files exist in `android/app/src/main/res/raw/`
- Check file permissions and names
- Ensure notification permissions are granted
- Verify the notification channel exists and has sound enabled

**Issue: Wrong sound plays**
- Check `AudioService.getAndroidNotificationSound()` logic
- Verify SharedPreferences values are being read correctly
- Ensure the correct resource name is being used

**Issue: Fallback sound doesn't play**
- Verify `allahu_akbar.mp3` exists in raw resources
- Check the logic in `AudioService` when Adhan is disabled
- Ensure the fallback sound is properly referenced

### **6. Cleanup**

After testing is complete:
1. Remove the test notification button from `home_screen.dart`
2. Remove any test code or comments
3. Commit the final implementation

```dart
// Remove this code from home_screen.dart
// TEST BUTTON - REMOVE FOR PRODUCTION
IconButton(
  icon: Icon(
    Icons.notifications_active_rounded,
    color: colors.textPrimary,
    size: 26,
  ),
  onPressed: () async {
    await NotificationService().showInstantTestNotification();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Test notification sent!', style: TextStyle(color: colors.textPrimary)),
        backgroundColor: colors.surface,
      ),
    );
  },
),
```