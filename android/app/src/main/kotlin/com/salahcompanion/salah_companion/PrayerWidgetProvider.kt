package com.salahcompanion.salah_companion

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class PrayerWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
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

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val name = prefs.getString(KEY_NEXT_PRAYER_NAME, "Fajr") ?: "Fajr"
            val time = prefs.getString(KEY_NEXT_PRAYER_TIME, "--:--") ?: "--:--"
            val city = prefs.getString(KEY_CITY, "") ?: ""

            val views = RemoteViews(context.packageName, R.layout.prayer_widget)
            views.setTextViewText(R.id.widget_next_prayer_name, name)
            views.setTextViewText(R.id.widget_next_prayer_time, time)
            views.setTextViewText(R.id.widget_city, city)

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
