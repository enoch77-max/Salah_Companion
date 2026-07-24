package com.salahcompanion.salah_companion

import android.os.Build
import android.os.PowerManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.salahcompanion/battery"
    private val WIDGET_CHANNEL = "com.salahcompanion/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isIgnoringBatteryOptimizations") {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val powerManager = getSystemService(POWER_SERVICE) as PowerManager
                    val isIgnoring = powerManager.isIgnoringBatteryOptimizations(packageName)
                    result.success(isIgnoring)
                } else {
                    result.success(true)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                PrayerWidgetProvider.sendUpdateBroadcast(context)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }
}
