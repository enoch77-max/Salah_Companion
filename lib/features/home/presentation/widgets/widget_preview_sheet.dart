import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/services/app_haptics.dart';
import '../../../../core/services/widget_service.dart';

class WidgetPreviewSheet extends StatefulWidget {
  final WidgetService? widgetService;

  const WidgetPreviewSheet({
    super.key,
    this.widgetService,
  });

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const WidgetPreviewSheet(),
    );
  }

  @override
  State<WidgetPreviewSheet> createState() => _WidgetPreviewSheetState();
}

class _WidgetPreviewSheetState extends State<WidgetPreviewSheet> with WidgetsBindingObserver {
  late final WidgetService _service;
  final Map<String, int> _widgetCounts = {
    'small_salah': 0,
    'full_schedule': 0,
    'daily_dua': 0,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _service = widget.widgetService ?? WidgetService();
    _loadPinnedStates();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadPinnedStates();
    }
  }

  Future<void> _loadPinnedStates() async {
    await _service.notifyWidgetUpdate();
    final countSmall = await _service.getWidgetCount('small_salah');
    final countFull = await _service.getWidgetCount('full_schedule');
    final countDua = await _service.getWidgetCount('daily_dua');

    if (mounted) {
      setState(() {
        _widgetCounts['small_salah'] = countSmall;
        _widgetCounts['full_schedule'] = countFull;
        _widgetCounts['daily_dua'] = countDua;
      });
    }
  }

  Future<void> _handleAddWidgetTap(String type, String title) async {
    AppHaptics.light();
    final count = _widgetCounts[type] ?? 0;

    if (count > 0) {
      _showAlreadyAddedDialog(type, title);
    } else {
      await _triggerNativePin(type, title);
    }
  }

  Future<void> _triggerNativePin(String type, String title) async {
    final supported = await _service.isPinWidgetSupported();
    if (supported) {
      final success = await _service.requestPinWidget(type);
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color(0xFF10B981),
              content: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pin request sent for "$title". Approve on screen!',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 4),
            ),
          );
          // Continuously re-check hardware state while user interacts with Android OS pin prompt
          for (int i = 1; i <= 5; i++) {
            Future.delayed(Duration(seconds: i), () async {
              if (mounted) {
                await _loadPinnedStates();
                // If after 3 seconds on a Custom ROM the widget is still not added, show helpful dialog
                if (i == 3 && (_widgetCounts[type] ?? 0) == 0) {
                  _showManualPinInstructionDialog(title);
                }
              }
            });
          }
        } else {
          _showManualPinInstructionDialog(title);
        }
      }
    } else {
      _showManualPinInstructionDialog(title);
    }
  }

  void _showAlreadyAddedDialog(String type, String title) {
    final colors = context.appColors;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colors.divider, width: 1.0),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.widgets_rounded, color: colors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Widget Already Added',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        content: Text(
          'You already have the "$title" widget on your home screen!\n\nWould you like to add another copy to your home screen?',
          style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
                height: 1.4,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Done', style: TextStyle(color: colors.textSecondary)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _triggerNativePin(type, title);
            },
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Add Another'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showManualPinInstructionDialog(String title) {
    final colors = context.appColors;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colors.divider, width: 1.0),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.settings_suggest_rounded, color: colors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Permission or Manual Add',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On some devices (Xiaomi, Poco, Oppo, Realme, Vivo), 1-tap widget pinning requires enabling "Home Screen Shortcuts" or "Display pop-up windows" in phone settings.',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 14),
              Text(
                'Option 1: Allow Permission',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap "Open Settings" below -> Permissions -> Enable "Home screen shortcuts" or "Display pop-up windows".',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(height: 14),
              Text(
                'Option 2: Add Manually from Home Screen',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              _InstructionStep(
                number: '1',
                text: 'Go to your phone\'s Home Screen and touch & hold any empty space for 1 sec.',
                colors: colors,
              ),
              const SizedBox(height: 6),
              _InstructionStep(
                number: '2',
                text: 'Tap "Widgets" -> Scroll down to "Salah Companion".',
                colors: colors,
              ),
              const SizedBox(height: 6),
              _InstructionStep(
                number: '3',
                text: 'Touch & hold the "$title" widget and drag it onto your screen!',
                colors: colors,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: TextStyle(color: colors.textSecondary)),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _service.openWidgetPermissionSettings();
            },
            icon: const Icon(Icons.settings_rounded, size: 14),
            label: const Text('Open Settings'),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary.withValues(alpha: 0.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _service.goToHomeScreen();
            },
            icon: const Icon(Icons.home_rounded, size: 16),
            label: const Text('Go to Home Screen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: ShapeDecoration(
        color: colors.background,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.dividerStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Title
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: ShapeDecoration(
                    color: colors.primarySoft,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Icon(Icons.widgets_rounded, color: colors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home Screen Widgets',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        'Choose from 3 live widgets for your home screen',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, color: colors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ─── WIDGET 1: SALAH TIME (COMPACT 2x2) ───────────────────────────
            _WidgetOptionCard(
              title: 'Salah Time',
              sizeLabel: 'Compact 2x2',
              description: 'Live countdown to next prayer & city location.',
              activeCount: _widgetCounts['small_salah'] ?? 0,
              onAddTap: () => _handleAddWidgetTap('small_salah', 'Salah Time'),
              colors: colors,
              previewWidget: Container(
                width: 140,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: const Color(0xFF181B24),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFF2D3748), width: 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('NEXT SALAH', style: TextStyle(color: Color(0xFF64748B), fontSize: 9, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    const Text('Dhuhr', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 1),
                    const Text('12:15 PM', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.location_on_rounded, size: 10, color: Color(0xFF94A3B8)),
                        SizedBox(width: 2),
                        Text('Riyadh', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ─── WIDGET 2: FULL SALAH SCHEDULE (MEDIUM 4x2) ────────────────────
            _WidgetOptionCard(
              title: 'Full Salah Schedule',
              sizeLabel: 'Wide 4x2',
              description: 'Full 5 daily prayer times with active prayer highlight.',
              activeCount: _widgetCounts['full_schedule'] ?? 0,
              onAddTap: () => _handleAddWidgetTap('full_schedule', 'Full Salah Schedule'),
              colors: colors,
              previewWidget: Container(
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: const Color(0xFF181B24),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFF2D3748), width: 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('16 Safar 1448 AH', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 10, fontWeight: FontWeight.bold)),
                        Text('Riyadh', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Dhuhr', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('12:15 PM', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _MiniChip(name: 'Fajr', time: '04:12', active: false),
                        _MiniChip(name: 'Dhuhr', time: '12:15', active: true),
                        _MiniChip(name: 'Asr', time: '03:45', active: false),
                        _MiniChip(name: 'Maghrib', time: '06:42', active: false),
                        _MiniChip(name: 'Isha', time: '08:12', active: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ─── WIDGET 3: DAILY DUA & REFLECTION (MEDIUM 4x2) ───────────────
            _WidgetOptionCard(
              title: 'Daily Dua & Reflection',
              sizeLabel: 'Wide 4x2',
              description: 'Daily Quranic Ayah & Hadith with Arabic & translation.',
              activeCount: _widgetCounts['daily_dua'] ?? 0,
              onAddTap: () => _handleAddWidgetTap('daily_dua', 'Daily Dua & Reflection'),
              colors: colors,
              previewWidget: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: const Color(0xFF181B24),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFF2D3748), width: 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('DAILY REMEMBRANCE', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 9, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Glory be to Allah and His is the praise, Glory be to Allah the Most Great.',
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: ShapeDecoration(
                color: colors.primarySoft.withValues(alpha: 0.15),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: colors.primary.withValues(alpha: 0.3)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.touch_app_rounded, color: colors.primary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'How to add manually from Home Screen',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Long-press any empty space on your phone home screen.\n2. Tap "Widgets" at the bottom and search "Salah Companion".\n3. Drag your favorite widget to your screen. If full, drag it to the right edge to automatically create a NEW home screen page!',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => _service.openWidgetPermissionSettings(),
                    icon: Icon(Icons.security_rounded, size: 14, color: colors.primary),
                    label: Text(
                      'Open Phone Settings (Xiaomi / Oppo / Vivo)',
                      style: TextStyle(color: colors.primary, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.primary.withValues(alpha: 0.4)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final String number;
  final String text;
  final AppCustomColors colors;

  const _InstructionStep({
    required this.number,
    required this.text,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: colors.primarySoft,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: colors.primary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  height: 1.3,
                ),
          ),
        ),
      ],
    );
  }
}

class _WidgetOptionCard extends StatelessWidget {
  final String title;
  final String sizeLabel;
  final String description;
  final int activeCount;
  final VoidCallback onAddTap;
  final AppCustomColors colors;
  final Widget previewWidget;

  const _WidgetOptionCard({
    required this.title,
    required this.sizeLabel,
    required this.description,
    required this.activeCount,
    required this.onAddTap,
    required this.colors,
    required this.previewWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isPinned = activeCount > 0;

    return Container(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.divider, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.surfaceHover,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  sizeLabel,
                  style: TextStyle(
                    color: colors.textTertiary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Live Visual Mockup Preview
          Center(child: previewWidget),

          const SizedBox(height: 12),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAddTap,
              icon: Icon(isPinned ? Icons.check_circle_rounded : Icons.add_rounded, size: 18),
              label: Text(isPinned ? 'Active on Screen ($activeCount)' : 'Add Widget'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isPinned ? colors.primarySoft : colors.primary,
                foregroundColor: isPinned ? colors.primaryText : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  final String name;
  final String time;
  final bool active;

  const _MiniChip({
    required this.name,
    required this.time,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0D9488) : const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? const Color(0xFF2DD4BF) : const Color(0xFF334155),
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Text(name, style: TextStyle(color: active ? Colors.white : const Color(0xFFCBD5E1), fontSize: 8, fontWeight: FontWeight.bold)),
          Text(time, style: TextStyle(color: active ? Colors.white : const Color(0xFF94A3B8), fontSize: 8)),
        ],
      ),
    );
  }
}
