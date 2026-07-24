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
  bool _isLoading = true;
  List<PrayerLogsTableData> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.initialLogs != null) {
      setState(() {
        _logs = widget.initialLogs!;
        _isLoading = false;
      });
      return;
    }

    if (widget.database != null) {
      try {
        final logs = await widget.database!.select(widget.database!.prayerLogsTable).get();
        if (mounted) {
          setState(() {
            _logs = logs;
            _isLoading = false;
          });
        }
        return;
      } catch (_) {
        // Fallback to sample data if database query fails or is empty
      }
    }

    // Default sample data for demonstration / non-db context
    if (mounted) {
      setState(() {
        _logs = _generateSampleLogs();
        _isLoading = false;
      });
    }
  }

  List<PrayerLogsTableData> _generateSampleLogs() {
    final now = DateTime.now();
    final prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    final sampleList = <PrayerLogsTableData>[];
    int id = 1;

    for (int dayOffset = 0; dayOffset < 30; dayOffset++) {
      final date = now.subtract(Duration(days: dayOffset));
      final dateStr =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      for (final prayer in prayers) {
        // Mock pattern: 85% prayed, 15% missed
        final status = ((dayOffset * 7 + prayer.length) % 6 != 0) ? 'prayed' : 'missed';
        sampleList.add(PrayerLogsTableData(
          id: id++,
          date: dateStr,
          prayerName: prayer,
          status: status,
          updatedAt: date,
        ));
      }
    }
    return sampleList;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    // Filter weekly (past 7 days) and monthly (past 30 days) logs
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final weeklyLogs = _logs.where((log) {
      final logDate = DateTime.tryParse(log.date);
      return logDate != null && logDate.isAfter(sevenDaysAgo);
    }).toList();

    final monthlyLogs = _logs;

    final weeklyPrayed = weeklyLogs.where((l) => l.status.toLowerCase() == 'prayed').length;
    final weeklyTotal = weeklyLogs.isEmpty ? 35 : weeklyLogs.length;
    final weeklyRate = (weeklyPrayed / weeklyTotal).clamp(0.0, 1.0);

    final monthlyPrayed = monthlyLogs.where((l) => l.status.toLowerCase() == 'prayed').length;
    final monthlyTotal = monthlyLogs.isEmpty ? 150 : monthlyLogs.length;
    final monthlyRate = (monthlyPrayed / monthlyTotal).clamp(0.0, 1.0);

    // Prayer breakdown
    final prayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    final Map<String, int> prayerPrayedCount = {};
    final Map<String, int> prayerTotalCount = {};

    for (final p in prayers) {
      prayerPrayedCount[p] = 0;
      prayerTotalCount[p] = 0;
    }

    for (final log in _logs) {
      final p = log.prayerName;
      if (prayerTotalCount.containsKey(p)) {
        prayerTotalCount[p] = (prayerTotalCount[p] ?? 0) + 1;
        if (log.status.toLowerCase() == 'prayed') {
          prayerPrayedCount[p] = (prayerPrayedCount[p] ?? 0) + 1;
        }
      }
    }

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Prayer Tracker',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: colors.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overview Header Card
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: colors.elevatedBackground,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: colors.dividerStrong, width: 1.0),
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
                                fontWeight: FontWeight.w600,
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

                  // Weekly Progress Bar Card
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: colors.surface,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                                    fontWeight: FontWeight.w600,
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
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '${weeklyTotal - weeklyPrayed} Missed',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: colors.missedText,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Per-Prayer Breakdown
                  Text(
                    'PRAYER BREAKDOWN',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.textSecondary,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  ...prayers.map((prayer) {
                    final prayed = prayerPrayedCount[prayer] ?? 0;
                    final total = prayerTotalCount[prayer] ?? 1;
                    final rate = total == 0 ? 0.0 : (prayed / total).clamp(0.0, 1.0);
                    final missed = total - prayed;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: colors.surface,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: colors.divider, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '${(rate * 100).toInt()}% Completion',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        color: colors.primaryText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: LinearProgressIndicator(
                                value: rate,
                                minHeight: 8,
                                backgroundColor: colors.missedSoft,
                                valueColor: AlwaysStoppedAnimation<Color>(colors.success),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Prayed: $prayed',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: colors.successText,
                                      ),
                                ),
                                Text(
                                  'Missed: $missed',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: colors.missedText,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
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
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
              ),
        ),
      ],
    );
  }
}
