package com.salahcompanion.salah_companion

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class DuaWidgetProvider : AppWidgetProvider() {

    private fun syncPinnedState(context: Context) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context, DuaWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        val isPinned = appWidgetIds != null && appWidgetIds.isNotEmpty()
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit().putBoolean("flutter.widget_pinned_daily_dua", isPinned).apply()
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        syncPinnedState(context)
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        prefs.edit().putBoolean("flutter.widget_pinned_daily_dua", false).apply()
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
        val componentName = ComponentName(context, DuaWidgetProvider::class.java)
        val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        const val PREFS_NAME = "FlutterSharedPreferences"
        const val KEY_DUA_TITLE = "flutter.widget_dua_title"
        const val KEY_DUA_ARABIC = "flutter.widget_dua_arabic"
        const val KEY_DUA_TRANSLATION = "flutter.widget_dua_translation"

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

            val title = prefs.getString(KEY_DUA_TITLE, "DAILY REMEMBRANCE") ?: "DAILY REMEMBRANCE"
            val arabic = prefs.getString(KEY_DUA_ARABIC, "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ")
                ?: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ"
            val translation = prefs.getString(KEY_DUA_TRANSLATION, "Glory be to Allah and His is the praise, Glory be to Allah the Most Great.")
                ?: "Glory be to Allah and His is the praise, Glory be to Allah the Most Great."

            val views = RemoteViews(context.packageName, R.layout.dua_widget)
            views.setTextViewText(R.id.widget_dua_category, title)
            views.setTextViewText(R.id.widget_dua_arabic, arabic)
            views.setTextViewText(R.id.widget_dua_translation, translation)

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
            val intent = Intent(context, DuaWidgetProvider::class.java).apply {
                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
            }
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context, DuaWidgetProvider::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
            intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
            context.sendBroadcast(intent)
        }
    }
}
