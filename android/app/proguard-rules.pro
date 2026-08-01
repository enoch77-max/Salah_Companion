# WorkManager & Room DB Reflection Rules
-keep class androidx.work.impl.WorkDatabase_Impl {
    public <init>();
}
-keep class * extends androidx.work.impl.WorkDatabase {
    public <init>();
}
-keep class * extends androidx.room.RoomDatabase {
    public <init>();
}
-keep class androidx.work.WorkManagerInitializer { *; }
-keep class androidx.work.impl.background.systemalarm.RescheduleReceiver { *; }
-keep class androidx.work.impl.background.systemalarm.ConstraintProxy* { *; }

# Native App & Method Channel Rules
-keep class com.salahcompanion.salah_companion.** { *; }
