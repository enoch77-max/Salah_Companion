import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:salah_companion/app/theme/app_theme.dart';
import 'package:salah_companion/features/learn_salah/data/salah_guide_data.dart';
import 'package:salah_companion/features/learn_salah/domain/models/salah_learning_models.dart';
import 'package:salah_companion/features/learn_salah/presentation/widgets/posture_avatars.dart';
import 'salah_step_by_step_screen.dart';
import 'salah_category_detail_screen.dart';

/// Learn Salah Main Hub Screen (Apple-Design Aesthetic)
class LearnSalahHubScreen extends StatefulWidget {
  const LearnSalahHubScreen({super.key});

  @override
  State<LearnSalahHubScreen> createState() => _LearnSalahHubScreenState();
}

class _LearnSalahHubScreenState extends State<LearnSalahHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          'Learn Salah',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded, color: colors.primary),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Top Sheikh/Teacher Hero Illustration Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.15),
                      colors.primarySoft.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: BorderSide(
                      color: colors.primary.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.08),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: ShapeDecoration(
                              color: colors.primary.withValues(alpha: 0.15),
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'AUTHENTIC SUNNAH GUIDE',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Pray as the Prophet ﷺ Prayed',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: colors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            SalahGuideData.propheticHadithQuote,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 90,
                      height: 110,
                      decoration: ShapeDecoration(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: colors.primary.withValues(alpha: 0.3),
                            width: 1.0,
                          ),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/salah/sheikh_banner.png',
                        width: 90,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const PostureAvatarWidget(
                          postureKey: 'qiyam_chest',
                          width: 90,
                          height: 110,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08, curve: Curves.easeOutCubic),
            ),
          ),

          // 2. Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Container(
                decoration: ShapeDecoration(
                  color: colors.surface,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: colors.divider, width: 1.0),
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim().toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search posture, step, or Hadith proof...',
                    hintStyle: TextStyle(color: colors.textTertiary, fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded, color: colors.textSecondary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear_rounded, color: colors.textSecondary),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
          ),

          // 3. Category Grid Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'LEARNING MODULES',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
            ),
          ),

          // 4. Main Category Modules List
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, MediaQuery.of(context).padding.bottom + 32.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Module 1: Step-by-Step Guide
                  _ModuleCard(
                    title: 'Step-by-Step Prophetic Guide',
                    subtitle: '10 Sequential steps with 2D postures & proofs',
                    badgeText: 'FULL GUIDE',
                    icon: Icons.directions_walk_rounded,
                    accentColor: const Color(0xFF10B981), // Emerald Teal
                    postureKey: 'raf_al_yadayn',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalahStepByStepScreen(),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Module 2: The 14 Pillars
                  _ModuleCard(
                    title: 'The 14 Pillars of Salah (Arkan)',
                    subtitle: 'Must-do essential foundations of prayer',
                    badgeText: '14 PILLARS',
                    icon: Icons.account_balance_rounded,
                    accentColor: const Color(0xFFD97706), // Warm Amber
                    postureKey: 'ruku',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalahCategoryDetailScreen(
                            title: '14 Pillars of Salah (Arkan)',
                            category: SalahRuleCategory.pillar,
                            items: SalahGuideData.pillars,
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 150.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Module 3: The 8 Obligations
                  _ModuleCard(
                    title: 'The 8 Obligations (Waajibaat)',
                    subtitle: 'Mandatory acts compensated by Sujood as-Sahw',
                    badgeText: '8 OBLIGATIONS',
                    icon: Icons.task_alt_rounded,
                    accentColor: const Color(0xFF0EA5E9), // Ocean Blue
                    postureKey: 'sujood',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalahCategoryDetailScreen(
                            title: '8 Obligations of Salah (Waajibaat)',
                            category: SalahRuleCategory.obligation,
                            items: SalahGuideData.obligations,
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Module 4: Sunnah Practices
                  _ModuleCard(
                    title: 'Sunnah Practices (Sunan)',
                    subtitle: 'Verbal & action Sunnahs of Prophet Muhammad ﷺ',
                    badgeText: 'SUNNAH ACTS',
                    icon: Icons.auto_awesome_rounded,
                    accentColor: const Color(0xFF8B5CF6), // Royal Purple
                    postureKey: 'tashahhud_finger',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalahCategoryDetailScreen(
                            title: 'Sunnah Practices of Salah',
                            category: SalahRuleCategory.sunnahAction,
                            items: SalahGuideData.pillars, // Handled inside detail
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 250.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Module 5: Errors to Avoid
                  _ModuleCard(
                    title: 'Common Errors & Prohibited Actions',
                    subtitle: 'Pitfalls, Bid\'ah, & invalidating mistakes',
                    badgeText: 'ERRORS TO AVOID',
                    icon: Icons.warning_amber_rounded,
                    accentColor: const Color(0xFFEF4444), // Coral Red
                    postureKey: 'taslim',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalahCategoryDetailScreen(
                            title: 'Common Errors to Avoid',
                            category: SalahRuleCategory.errorToAvoid,
                            items: SalahGuideData.errorsToAvoid,
                          ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.verified_rounded, color: Color(0xFF10B981)),
            SizedBox(width: 8),
            Text('Authentic Sunnah Guide'),
          ],
        ),
        content: const Text(
          'This Learn Salah feature is compiled strictly from authentic Hadith (Sahih al-Bukhari, Sahih Muslim, Sunan Abi Dawud, Sunan an-Nasa\'i, Jami\' at-Tirmidhi) and Quranic ayat.\n\nAll Hadith and scriptural proofs are provided in full without truncation.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final IconData icon;
  final Color accentColor;
  final String postureKey;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.icon,
    required this.accentColor,
    required this.postureKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: colors.surface,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: colors.divider,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: accentColor.withValues(alpha: 0.1),
        highlightColor: accentColor.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              PostureAvatarWidget(
                postureKey: postureKey,
                width: 70,
                height: 80,
                primaryColor: accentColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: ShapeDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: 0.8,
                            ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
