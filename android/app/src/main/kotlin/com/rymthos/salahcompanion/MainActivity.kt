package com.rymthos.salahcompanion

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
                    val launched = openBatteryOptimizationSettings()
                    result.success(launched)
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

    private fun safeStartIntent(intent: Intent): Boolean {
        return try {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun openBatteryOptimizationSettings(): Boolean {
        val manufacturer = (Build.MANUFACTURER ?: "").lowercase()

        // 1. Standard Android Direct 1-Tap Exemption Request (API 23+)
        // When REQUEST_IGNORE_BATTERY_OPTIMIZATIONS is declared in manifest,
        // this displays the system's native whitelist dialog directly inside the app.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val powerManager = getSystemService(POWER_SERVICE) as? PowerManager
            val isAlreadyIgnored = powerManager?.isIgnoringBatteryOptimizations(packageName) ?: false
            if (!isAlreadyIgnored) {
                val directIntent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS).apply {
                    data = Uri.parse("package:$packageName")
                }
                if (safeStartIntent(directIntent)) {
                    return true
                }
            }
        }

        // 2. OEM-Specific Background & Autostart Management
        var launched = false
        when {
            manufacturer.contains("xiaomi") || manufacturer.contains("redmi") || manufacturer.contains("poco") -> {
                // Try Xiaomi Powerkeeper (Battery Saver -> No restrictions)
                val powerKeeperIntent = Intent().apply {
                    component = ComponentName("com.miui.powerkeeper", "com.miui.powerkeeper.ui.HiddenAppsConfigActivity")
                    putExtra("package_name", packageName)
                    putExtra("package_label", "Salah Companion")
                }
                launched = safeStartIntent(powerKeeperIntent)

                // Try Xiaomi Autostart
                if (!launched) {
                    val autostartIntent = Intent().apply {
                        component = ComponentName("com.miui.securitycenter", "com.miui.permcenter.autostart.AutoStartManagementActivity")
                        putExtra("extra_pkgname", packageName)
                    }
                    launched = safeStartIntent(autostartIntent)
                }

                // Try Xiaomi App Permissions Editor
                if (!launched) {
                    val permIntent = Intent("miui.intent.action.APP_PERM_EDITOR").apply {
                        setClassName("com.miui.securitycenter", "com.miui.permcenter.permissions.PermissionsEditorActivity")
                        putExtra("extra_pkgname", packageName)
                    }
                    launched = safeStartIntent(permIntent)
                }
            }
            manufacturer.contains("samsung") -> {
                // Try Samsung Device Care Battery
                val samsungIntent1 = Intent().apply {
                    component = ComponentName("com.samsung.android.lool", "com.samsung.android.sm.battery.ui.BatteryActivity")
                }
                launched = safeStartIntent(samsungIntent1)

                if (!launched) {
                    val samsungIntent2 = Intent().apply {
                        component = ComponentName("com.samsung.android.sm", "com.samsung.android.sm.battery.ui.BatteryActivity")
                    }
                    launched = safeStartIntent(samsungIntent2)
                }
            }
            manufacturer.contains("huawei") || manufacturer.contains("honor") -> {
                val huaweiIntent1 = Intent().apply {
                    component = ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity")
                }
                launched = safeStartIntent(huaweiIntent1)

                if (!launched) {
                    val huaweiIntent2 = Intent().apply {
                        component = ComponentName("com.huawei.systemmanager", "com.huawei.systemmanager.appcontrol.activity.StartupAppListActivity")
                    }
                    launched = safeStartIntent(huaweiIntent2)
                }
            }
            manufacturer.contains("oppo") || manufacturer.contains("realme") || manufacturer.contains("oneplus") -> {
                val oppoIntent1 = Intent().apply {
                    component = ComponentName("com.coloros.safecenter", "com.coloros.safecenter.permission.startup.StartupAppListActivity")
                }
                launched = safeStartIntent(oppoIntent1)

                if (!launched) {
                    val oppoIntent2 = Intent().apply {
                        component = ComponentName("com.oplus.battery", "com.oplus.battery.AppListActivity")
                    }
                    launched = safeStartIntent(oppoIntent2)
                }
            }
            manufacturer.contains("vivo") || manufacturer.contains("iqoo") -> {
                val vivoIntent1 = Intent().apply {
                    component = ComponentName("com.iqoo.secure", "com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity")
                }
                launched = safeStartIntent(vivoIntent1)

                if (!launched) {
                    val vivoIntent2 = Intent().apply {
                        component = ComponentName("com.vivo.permissionmanager", "com.vivo.permissionmanager.activity.PurviewTabActivity")
                    }
                    launched = safeStartIntent(vivoIntent2)
                }
            }
            manufacturer.contains("transsion") || manufacturer.contains("infinix") || manufacturer.contains("tecno") || manufacturer.contains("itel") -> {
                val transsionIntent = Intent().apply {
                    component = ComponentName("com.transsion.phonemaster", "com.transsion.phonemaster.AutoStartActivity")
                }
                launched = safeStartIntent(transsionIntent)
            }
        }

        if (launched) {
            return true
        }

        // 3. Fallback to System Battery Optimization Settings
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val optIntent = Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS)
            if (safeStartIntent(optIntent)) {
                return true
            }
        }

        // 4. Universal Fallback: App Details Settings (Guaranteed to work on 100% of Android devices)
        val detailsIntent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
            data = Uri.parse("package:$packageName")
        }
        return safeStartIntent(detailsIntent)
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
