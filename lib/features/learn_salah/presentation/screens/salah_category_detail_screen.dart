import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/learn_salah/domain/models/salah_learning_models.dart';
import 'package:salah_companion/features/learn_salah/presentation/widgets/posture_avatars.dart';

/// Detail Screen for Pillars, Obligations, Sunnahs, or Errors to Avoid.
class SalahCategoryDetailScreen extends StatelessWidget {
  final String title;
  final SalahRuleCategory category;
  final List<SalahCategoryItem> items;

  const SalahCategoryDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.elevatedBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, MediaQuery.of(context).padding.bottom + 24.0),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return _CategoryItemTile(item: item)
              .animate()
              .fadeIn(delay: Duration(milliseconds: 50 * index), duration: 350.ms)
              .slideY(begin: 0.05, curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}

class _CategoryItemTile extends StatefulWidget {
  final SalahCategoryItem item;
  const _CategoryItemTile({required this.item});

  @override
  State<_CategoryItemTile> createState() => _CategoryItemTileState();
}

class _CategoryItemTileState extends State<_CategoryItemTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final item = widget.item;

    Color badgeColor;
    switch (item.category) {
      case SalahRuleCategory.pillar:
        badgeColor = const Color(0xFFD97706); // Warm Amber
        break;
      case SalahRuleCategory.obligation:
        badgeColor = const Color(0xFF0EA5E9); // Ocean Blue
        break;
      case SalahRuleCategory.sunnahVerbal:
      case SalahRuleCategory.sunnahAction:
        badgeColor = const Color(0xFF8B5CF6); // Royal Purple
        break;
      case SalahRuleCategory.errorToAvoid:
        badgeColor = const Color(0xFFEF4444); // Coral Red
        break;
      default:
        badgeColor = colors.primary;
    }

    return Material(
      color: colors.surface,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: _isExpanded ? badgeColor.withValues(alpha: 0.5) : colors.divider,
          width: _isExpanded ? 1.5 : 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostureAvatarWidget(
                    postureKey: item.postureKey,
                    width: 65,
                    height: 75,
                    primaryColor: badgeColor,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colors.textPrimary,
                                    ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _isExpanded ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 250),
                              child: Icon(Icons.keyboard_arrow_down_rounded, color: colors.textTertiary),
                            ),
                          ],
                        ),
                        if (item.arabicName.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            item.arabicName,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 14,
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.textSecondary,
                                height: 1.35,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 1, color: colors.divider),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: badgeColor.withValues(alpha: 0.1),
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline_rounded, size: 16, color: badgeColor),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item.consequenceIfOmitted,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item.references.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'HADITH & SCRIPTURAL PROOF:',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: colors.textSecondary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                        ),
                        const SizedBox(height: 6),
                        ...item.references.map(
                          (ref) => Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: ShapeDecoration(
                              color: colors.elevatedBackground,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: colors.divider, width: 1.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ref.citation,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ref.fullTextEnglish,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: colors.textPrimary,
                                        height: 1.4,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
