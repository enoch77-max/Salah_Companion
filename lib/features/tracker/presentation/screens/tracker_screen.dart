import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/database/app_database.dart';

class TrackerScreen extends StatefulWidget {
  final AppDatabase? database;
  final List<PrayerLogsTableData>? initialLogs;

  const TrackerScreen({
    super.key,
    this.database,
    this.initialLogs,
  });

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  List<PrayerLogsTableData> _logs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    if (widget.initialLogs != null) {
      setState(() {
        _logs = widget.initialLogs!;
        _isLoading = false;
      });
      return;
    }
    final db = widget.database ?? AppDatabase.instance();
    try {
      final logs = await db.select(db.prayerLogsTable).get();
      if (mounted) {
        setState(() {
          _logs = logs;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _logs = [];
          _isLoading = false;
        });
      }
    }
  }

  Color _getSquircleBadgeColor(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
        return const Color(0xFF6366F1); // Indigo
      case 'dhuhr':
        return const Color(0xFFEAB308); // Sun Gold
      case 'asr':
        return const Color(0xFFF97316); // Orange
      case 'maghrib':
        return const Color(0xFFEC4899); // Rose
      case 'isha':
        return const Color(0xFF8B5CF6); // Purple
      default:
        return const Color(0xFF64748B);
    }
  }

  IconData _getPrayerIcon(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
        return Icons.wb_twilight_rounded;
      case 'dhuhr':
        return Icons.wb_sunny_rounded;
      case 'asr':
        return Icons.wb_cloudy_rounded;
      case 'maghrib':
        return Icons.nights_stay_rounded;
      case 'isha':
        return Icons.bedtime_rounded;
      default:
        return Icons.access_time_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final weeklyLogs = _logs.where((log) {
      final logDate = DateTime.tryParse(log.date);
      return logDate != null && logDate.isAfter(sevenDaysAgo);
    }).toList();

    final weeklyTotal = weeklyLogs.length;
    final weeklyPrayed = weeklyLogs.where((l) => l.status.toLowerCase() == 'prayed').length;
    final weeklyMissed = weeklyLogs.where((l) => l.status.toLowerCase() == 'missed').length;
    final weeklyRate = weeklyTotal == 0 ? 0.0 : (weeklyPrayed / weeklyTotal).clamp(0.0, 1.0);

    final monthlyTotal = _logs.length;
    final monthlyPrayed = _logs.where((l) => l.status.toLowerCase() == 'prayed').length;
    final monthlyRate = monthlyTotal == 0 ? 0.0 : (monthlyPrayed / monthlyTotal).clamp(0.0, 1.0);

    final prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    final prayerTotalCount = <String, int>{for (var p in prayers) p: 0};
    final prayerPrayedCount = <String, int>{for (var p in prayers) p: 0};
    final prayerMissedCount = <String, int>{for (var p in prayers) p: 0};

    for (final log in _logs) {
      final p = log.prayerName;
      if (prayerTotalCount.containsKey(p)) {
        prayerTotalCount[p] = (prayerTotalCount[p] ?? 0) + 1;
        if (log.status.toLowerCase() == 'prayed') {
          prayerPrayedCount[p] = (prayerPrayedCount[p] ?? 0) + 1;
        } else if (log.status.toLowerCase() == 'missed') {
          prayerMissedCount[p] = (prayerMissedCount[p] ?? 0) + 1;
        }
      }
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colors.primary),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Apple Display Title
                    Text(
                      'Prayer Tracker',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            letterSpacing: -0.2,
                          ),
                    ),
                    const SizedBox(height: 20),

                    // Overview iOS Inset Card
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: colors.surface,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: colors.divider, width: 1.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COMPLETION OVERVIEW',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: colors.textSecondary,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _StatSummaryCard(
                                  title: 'Weekly Rate',
                                  value: '${(weeklyRate * 100).toInt()}%',
                                  subtitle: '$weeklyPrayed / $weeklyTotal Prayers',
                                  progress: weeklyRate,
                                  color: colors.success,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatSummaryCard(
                                  title: 'Monthly Rate',
                                  value: '${(monthlyRate * 100).toInt()}%',
                                  subtitle: '$monthlyPrayed / $monthlyTotal Prayers',
                                  progress: monthlyRate,
                                  color: colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Weekly Performance Bar Card
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: colors.surface,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: colors.divider, width: 1.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly Performance',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Row(
                                children: [
                                  _LegendDot(color: colors.success, label: 'Prayed'),
                                  const SizedBox(width: 12),
                                  _LegendDot(color: colors.missed, label: 'Missed'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 14,
                              width: double.infinity,
                              color: colors.missedSoft,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: (weeklyRate * 100).toInt(),
                                    child: Container(
                                      color: colors.success,
                                    ),
                                  ),
                                  Expanded(
                                    flex: ((1.0 - weeklyRate) * 100).toInt(),
                                    child: Container(
                                      color: colors.missed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$weeklyPrayed Prayed',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: colors.successText,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '$weeklyMissed Missed',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: colors.missedText,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Per-Prayer Breakdown Section Header
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        'PRAYER BREAKDOWN',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.textSecondary,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),

                    // Grouped Inset Card for Prayer Breakdown
                    Container(
                      decoration: ShapeDecoration(
                        color: colors.surface,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: colors.divider, width: 1.0),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: prayers.map((prayer) {
                          final prayed = prayerPrayedCount[prayer] ?? 0;
                          final missed = prayerMissedCount[prayer] ?? 0;
                          final total = prayerTotalCount[prayer] ?? 0;
                          final rate = total == 0 ? 0.0 : (prayed / total).clamp(0.0, 1.0);
                          final badgeColor = _getSquircleBadgeColor(prayer);
                          final iconData = _getPrayerIcon(prayer);
                          final isLast = prayer == 'Isha';

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: badgeColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        iconData,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                prayer,
                                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                      color: colors.textPrimary,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                              Text(
                                                '${(rate * 100).toInt()}% Completion',
                                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                      color: colors.primaryText,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: LinearProgressIndicator(
                                              value: rate,
                                              minHeight: 8,
                                              backgroundColor: colors.missedSoft,
                                              valueColor: AlwaysStoppedAnimation<Color>(colors.success),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Prayed: $prayed',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: colors.successText,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                              Text(
                                                'Missed: $missed',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: colors.missedText,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  thickness: 0.8,
                                  indent: 66,
                                  color: colors.divider,
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
    );
  }
}

class _StatSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final double progress;
  final Color color;

  const _StatSummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        color: colors.elevatedBackground,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: colors.divider, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTypography.timerStyle(
              fontSize: 26,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
