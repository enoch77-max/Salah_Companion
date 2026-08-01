package com.salahcompanion.salah_companion

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class PrayerWidgetProvider : AppWidgetProvider() {

    private fun syncPinnedState(context: Context) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context, PrayerWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        val isPinned = appWidgetIds != null && appWidgetIds.isNotEmpty()
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit().putBoolean("flutter.widget_pinned_full_schedule", isPinned).apply()
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        syncPinnedState(context)
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit().putBoolean("flutter.widget_pinned_full_schedule", false).apply()
    }

    override fun onDeleted(context: Context, appWidgetIds: IntArray) {
        super.onDeleted(context, appWidgetIds)
        syncPinnedState(context)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        syncPinnedState(context)
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        syncPinnedState(context)
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context, PrayerWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        const val PREFS_NAME = "FlutterSharedPreferences"
        const val KEY_NEXT_PRAYER_NAME = "flutter.widget_next_prayer_name"
        const val KEY_NEXT_PRAYER_TIME = "flutter.widget_next_prayer_time"
        const val KEY_CITY = "flutter.widget_city"
        const val KEY_HIJRI_DATE = "flutter.widget_hijri_date"

        const val KEY_FAJR_TIME = "flutter.widget_fajr_time"
        const val KEY_DHUHR_TIME = "flutter.widget_dhuhr_time"
        const val KEY_ASR_TIME = "flutter.widget_asr_time"
        const val KEY_MAGHRIB_TIME = "flutter.widget_maghrib_time"
        const val KEY_ISHA_TIME = "flutter.widget_isha_time"

        const val KEY_FAJR_MILLIS = "flutter.widget_fajr_millis"
        const val KEY_DHUHR_MILLIS = "flutter.widget_dhuhr_millis"
        const val KEY_ASR_MILLIS = "flutter.widget_asr_millis"
        const val KEY_MAGHRIB_MILLIS = "flutter.widget_maghrib_millis"
        const val KEY_ISHA_MILLIS = "flutter.widget_isha_millis"

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

            var name = prefs.getString(KEY_NEXT_PRAYER_NAME, "Fajr") ?: "Fajr"
            var time = prefs.getString(KEY_NEXT_PRAYER_TIME, "--:--") ?: "--:--"
            val city = prefs.getString(KEY_CITY, "Riyadh") ?: "Riyadh"
            val hijri = prefs.getString(KEY_HIJRI_DATE, "") ?: ""

            val fajrTimeStr = prefs.getString(KEY_FAJR_TIME, "04:12") ?: "04:12"
            val dhuhrTimeStr = prefs.getString(KEY_DHUHR_TIME, "12:15") ?: "12:15"
            val asrTimeStr = prefs.getString(KEY_ASR_TIME, "03:45") ?: "03:45"
            val maghribTimeStr = prefs.getString(KEY_MAGHRIB_TIME, "06:42") ?: "06:42"
            val ishaTimeStr = prefs.getString(KEY_ISHA_TIME, "08:12") ?: "08:12"

            val fajrMs = prefs.getLong(KEY_FAJR_MILLIS, 0L)
            val dhuhrMs = prefs.getLong(KEY_DHUHR_MILLIS, 0L)
            val asrMs = prefs.getLong(KEY_ASR_MILLIS, 0L)
            val maghribMs = prefs.getLong(KEY_MAGHRIB_MILLIS, 0L)
            val ishaMs = prefs.getLong(KEY_ISHA_MILLIS, 0L)

            val now = System.currentTimeMillis()

            // Note: Keep name & time as written by Flutter WidgetService (preserves active unprayed state)
            if (name.isEmpty()) {
                name = "Fajr"
                time = fajrTimeStr
            }

            val views = RemoteViews(context.packageName, R.layout.prayer_widget)
            views.setTextViewText(R.id.widget_next_prayer_name, name)
            views.setTextViewText(R.id.widget_next_prayer_time, time)
            views.setTextViewText(R.id.widget_city, city)
            if (hijri.isNotEmpty()) {
                views.setTextViewText(R.id.widget_hijri_date, hijri)
            }

            views.setTextViewText(R.id.widget_fajr_time, fajrTimeStr)
            views.setTextViewText(R.id.widget_dhuhr_time, dhuhrTimeStr)
            views.setTextViewText(R.id.widget_asr_time, asrTimeStr)
            views.setTextViewText(R.id.widget_maghrib_time, maghribTimeStr)
            views.setTextViewText(R.id.widget_isha_time, ishaTimeStr)

            val chipFajr = if (name.equals("Fajr", ignoreCase = true)) R.drawable.widget_chip_active else R.drawable.widget_chip_background
            val chipDhuhr = if (name.equals("Dhuhr", ignoreCase = true)) R.drawable.widget_chip_active else R.drawable.widget_chip_background
            val chipAsr = if (name.equals("Asr", ignoreCase = true)) R.drawable.widget_chip_active else R.drawable.widget_chip_background
            val chipMaghrib = if (name.equals("Maghrib", ignoreCase = true)) R.drawable.widget_chip_active else R.drawable.widget_chip_background
            val chipIsha = if (name.equals("Isha", ignoreCase = true)) R.drawable.widget_chip_active else R.drawable.widget_chip_background

            views.setInt(R.id.chip_fajr, "setBackgroundResource", chipFajr)
            views.setInt(R.id.chip_dhuhr, "setBackgroundResource", chipDhuhr)
            views.setInt(R.id.chip_asr, "setBackgroundResource", chipAsr)
            views.setInt(R.id.chip_maghrib, "setBackgroundResource", chipMaghrib)
            views.setInt(R.id.chip_isha, "setBackgroundResource", chipIsha)

            val intent = Intent(context, MainActivity::class.java)
            val pendingIntentFlags = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            } else {
                PendingIntent.FLAG_UPDATE_CURRENT
            }
            val pendingIntent = PendingIntent.getActivity(context, 0, intent, pendingIntentFlags)
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        fun sendUpdateBroadcast(context: Context) {
            val intent = Intent(context, PrayerWidgetProvider::class.java).apply {
                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            }
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context, PrayerWidgetProvider::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
            intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
            context.sendBroadcast(intent)
        }
    }
}
