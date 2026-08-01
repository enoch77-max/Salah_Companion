package com.salahcompanion.salah_companion

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.salahcompanion/battery"
    private val WIDGET_CHANNEL = "com.salahcompanion/widget"
    private val DISPLAY_CHANNEL = "com.salahcompanion/display"

    override fun onResume() {
        super.onResume()
        enableHighRefreshRate()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        enableHighRefreshRate()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DISPLAY_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableHighRefreshRate" -> {
                    enableHighRefreshRate()
                    result.success(true)
                }
                "getRefreshRate" -> {
                    val rate = getRefreshRate()
                    result.success(rate)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isIgnoringBatteryOptimizations" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        val powerManager = getSystemService(POWER_SERVICE) as PowerManager
                        val isIgnoring = powerManager.isIgnoringBatteryOptimizations(packageName)
                        result.success(isIgnoring)
                    } else {
                        result.success(true)
                    }
                }
                "getManufacturer" -> {
                    result.success(Build.MANUFACTURER ?: "Unknown")
                }
                "openBatteryOptimizationSettings", "requestIgnoreBatteryOptimizations" -> {
                    openBatteryOptimizationSettings()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "updateWidget" -> {
                    PrayerWidgetProvider.sendUpdateBroadcast(context)
                    PrayerWidgetSmallProvider.sendUpdateBroadcast(context)
                    DuaWidgetProvider.sendUpdateBroadcast(context)
                    result.success(true)
                }
                "isWidgetPinned" -> {
                    val widgetType = call.argument<String>("widgetType") ?: "full_schedule"
                    val appWidgetManager = AppWidgetManager.getInstance(context)
                    val providerClass = when (widgetType) {
                        "small_salah" -> PrayerWidgetSmallProvider::class.java
                        "daily_dua" -> DuaWidgetProvider::class.java
                        else -> PrayerWidgetProvider::class.java
                    }
                    val componentName = ComponentName(context, providerClass)
                    val activeIds = appWidgetManager.getAppWidgetIds(componentName)
                    val isPinned = activeIds != null && activeIds.isNotEmpty()
                    result.success(isPinned)
                }
                "getWidgetCount" -> {
                    val widgetType = call.argument<String>("widgetType") ?: "full_schedule"
                    val appWidgetManager = AppWidgetManager.getInstance(context)
                    val providerClass = when (widgetType) {
                        "small_salah" -> PrayerWidgetSmallProvider::class.java
                        "daily_dua" -> DuaWidgetProvider::class.java
                        else -> PrayerWidgetProvider::class.java
                    }
                    val componentName = ComponentName(context, providerClass)
                    val activeIds = appWidgetManager.getAppWidgetIds(componentName)
                    result.success(activeIds?.size ?: 0)
                }
                "isPinWidgetSupported" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val appWidgetManager = AppWidgetManager.getInstance(context)
                        result.success(appWidgetManager.isRequestPinAppWidgetSupported)
                    } else {
                        result.success(false)
                    }
                }
                "requestPinWidget" -> {
                    val widgetType = call.argument<String>("widgetType") ?: "full_schedule"
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val appWidgetManager = AppWidgetManager.getInstance(context)
                        if (appWidgetManager.isRequestPinAppWidgetSupported) {
                            val providerClass = when (widgetType) {
                                "small_salah" -> PrayerWidgetSmallProvider::class.java
                                "daily_dua" -> DuaWidgetProvider::class.java
                                else -> PrayerWidgetProvider::class.java
                            }
                            val layoutRes = when (widgetType) {
                                "small_salah" -> R.layout.prayer_widget_small
                                "daily_dua" -> R.layout.dua_widget
                                else -> R.layout.prayer_widget
                            }
                            val myProvider = ComponentName(context, providerClass)
                            val successIntent = Intent(context, providerClass).apply {
                                action = "com.salahcompanion.WIDGET_PINNED"
                            }
                            val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
                            } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
                            } else {
                                PendingIntent.FLAG_UPDATE_CURRENT
                            }
                            val successCallback = PendingIntent.getBroadcast(context, 0, successIntent, flags)
                            
                            val previewViews = android.widget.RemoteViews(packageName, layoutRes)
                            val bundle = android.os.Bundle().apply {
                                putParcelable(AppWidgetManager.EXTRA_APPWIDGET_PREVIEW, previewViews)
                            }
                            
                            val success = appWidgetManager.requestPinAppWidget(myProvider, bundle, successCallback)
                            result.success(success)
                        } else {
                            result.success(false)
                        }
                    } else {
                        result.success(false)
                    }
                }
                "openWidgetPermissionSettings" -> {
                    openWidgetPermissionSettings()
                    result.success(true)
                }
                "goToHomeScreen" -> {
                    try {
                        val intent = Intent(Intent.ACTION_MAIN).apply {
                            addCategory(Intent.CATEGORY_HOME)
                            flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        }
                        startActivity(intent)
                        result.success(true)
                    } catch (_: Exception) {
                        result.success(false)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun openWidgetPermissionSettings() {
        val manufacturer = (Build.MANUFACTURER ?: "").lowercase()
        var launched = false
        try {
            when {
                manufacturer.contains("xiaomi") || manufacturer.contains("redmi") || manufacturer.contains("poco") -> {
                    val intent = Intent("miui.intent.action.APP_PERM_EDITOR").apply {
                        setClassName("com.miui.securitycenter", "com.miui.permcenter.permissions.PermissionsEditorActivity")
                        putExtra("extra_pkgname", packageName)
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    }
                    startActivity(intent)
                    launched = true
                }
                manufacturer.contains("oppo") || manufacturer.contains("realme") -> {
                    val intent = Intent().apply {
                        component = ComponentName("com.coloros.safecenter", "com.coloros.safecenter.permission.PermissionManagerActivity")
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    }
                    startActivity(intent)
                    launched = true
                }
                manufacturer.contains("vivo") -> {
                    val intent = Intent().apply {
                        component = ComponentName("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.SoftPermissionDetailActivity")
                        putExtra("packagename", packageName)
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    }
                    startActivity(intent)
                    launched = true
                }
            }
        } catch (_: Exception) {
            launched = false
        }

        if (!launched) {
            try {
                val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                    data = Uri.parse("package:$packageName")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                startActivity(intent)
            } catch (_: Exception) {}
        }
    }

    private fun openBatteryOptimizationSettings() {
        val manufacturer = (Build.MANUFACTURER ?: "").lowercase()

        // 1. Standard Android Direct Request Intent (API 23+)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS).apply {
                    data = Uri.parse("package:$packageName")
                }
                startActivity(intent)
                return
            } catch (_: Exception) {
                // Fallback if ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS fails
            }
        }

        // 2. OEM Specific Settings Intents
        var launched = false
        try {
            when {
                manufacturer.contains("xiaomi") || manufacturer.contains("redmi") || manufacturer.contains("poco") -> {
                    val intent = Intent().apply {
                        setClassName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")
                    }
                    startActivity(intent)
                    launched = true
                }
                manufacturer.contains("huawei") || manufacturer.contains("honor") -> {
                    val intent = Intent().apply {
                        setClassName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
                    }
                    startActivity(intent)
                    launched = true
                }
                manufacturer.contains("oppo") || manufacturer.contains("realme") -> {
                    val intent = Intent().apply {
                        setClassName("com.coloros.safecenter", "com.coloros.safecenter.permission.startup.StartupAppListActivity")
                    }
                    startActivity(intent)
                    launched = true
                }
                manufacturer.contains("vivo") || manufacturer.contains("iqoo") -> {
                    val intent = Intent().apply {
                        setClassName("com.iqoo.secure", "com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity")
                    }
                    startActivity(intent)
                    launched = true
                }
            }
        } catch (_: Exception) {
            launched = false
        }

        // 3. Fallback to Ignore Battery Optimization Settings or App Details Settings
        if (!launched) {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val intent = Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS)
                    startActivity(intent)
                } else {
                    val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                        data = Uri.parse("package:$packageName")
                    }
                    startActivity(intent)
                }
            } catch (_: Exception) {
                val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                    data = Uri.parse("package:$packageName")
                }
                startActivity(intent)
            }
        }
    }

    private fun enableHighRefreshRate() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                val display = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    display
                } else {
                    @Suppress("DEPRECATION")
                    windowManager.defaultDisplay
                }
                display?.supportedModes?.maxByOrNull { it.refreshRate }?.let { mode ->
                    val params = window.attributes
                    params.preferredDisplayModeId = mode.modeId
                    window.attributes = params
                }
            } catch (_: Exception) {}
        }
    }

    private fun getRefreshRate(): Float {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                display?.refreshRate ?: 60f
            } else {
                @Suppress("DEPRECATION")
                windowManager.defaultDisplay?.refreshRate ?: 60f
            }
        } catch (_: Exception) {
            60f
        }
    }
}
