import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../home/presentation/widgets/daily_reflection_card.dart';
import '../../data/repositories/daily_content_repository.dart';
import '../../domain/models/daily_content.dart';

enum SavedCategory {
  all('All'),
  hadiths('Hadiths'),
  verses('Verses'),
  duas('Duas');

  final String label;
  const SavedCategory(this.label);
}

/// Screen displaying reverse-chronological list of saved [DailyContentItem]s.
class FavoritesScreen extends StatefulWidget {
  final DailyContentRepository? repository;
  final List<DailyContentItem>? initialItems;
  final Function(DailyContentItem item)? onUnfavorite;
  final Function(DailyContentItem item)? onShare;

  const FavoritesScreen({
    super.key,
    this.repository,
    this.initialItems,
    this.onUnfavorite,
    this.onShare,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<DailyContentItem>? _items;
  bool _isLoading = false;
  SavedCategory _selectedCategory = SavedCategory.all;

  @override
  void initState() {
    super.initState();
    if (widget.initialItems != null) {
      _items = List<DailyContentItem>.from(widget.initialItems!);
    } else if (widget.repository != null) {
      _loadFavorites();
    } else {
      _items = [];
    }
  }

  Future<void> _loadFavorites() async {
    if (widget.repository == null) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final list = await widget.repository!.getFavoritedContent();
      if (mounted) {
        setState(() {
          _items = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _items = [];
          _isLoading = false;
        });
      }
    }
  }

  void _onToggleFavorite(DailyContentItem item) async {
    if (_items == null) return;
    final index = _items!.indexWhere((element) => element.id == item.id);
    if (index == -1) return;

    // Optimistic update: remove item immediately
    setState(() {
      _items!.removeAt(index);
    });

    widget.onUnfavorite?.call(item);

    if (widget.repository != null) {
      try {
        await widget.repository!.toggleFavorite(item.id);
      } catch (_) {
        // Revert optimistic update on failure
        if (mounted) {
          setState(() {
            final safeIndex = index.clamp(0, _items!.length);
            _items!.insert(safeIndex, item);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update favorite status')),
          );
        }
      }
    }
  }

  List<DailyContentItem> get _filteredItems {
    final items = _items ?? [];
    switch (_selectedCategory) {
      case SavedCategory.all:
        return items;
      case SavedCategory.hadiths:
        return items.where((item) => item.type == DailyContentType.hadith).toList();
      case SavedCategory.verses:
        return items.where((item) => item.type == DailyContentType.ayah).toList();
      case SavedCategory.duas:
        return items.where((item) => item.type != DailyContentType.hadith && item.type != DailyContentType.ayah).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Hadiths, Verses & Duas',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Column(
        children: [
          // Segmented Category Filter Bar
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: SavedCategory.values.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = SavedCategory.values[index];
                final isSelected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category.label),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    }
                  },
                  selectedColor: colors.primary,
                  backgroundColor: colors.surface,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : colors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                  ),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isSelected ? colors.primary : colors.dividerStrong,
                      width: 1,
                    ),
                  ),
                  showCheckmark: false,
                );
              },
            ),
          ),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colors = context.appColors;

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: colors.primary,
        ),
      );
    }

    final items = _filteredItems;
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: ShapeDecoration(
                  color: colors.primarySoft,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Icon(
                  Icons.bookmark_rounded,
                  size: 36,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No saved items yet',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tap the bookmark icon on any content to save it here.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return DailyReflectionCard(
          key: ValueKey(item.id),
          content: item,
          isFavorited: true,
          onToggleFavorite: () => _onToggleFavorite(item),
          onShare: () {
            if (widget.onShare != null) {
              widget.onShare!(item);
            } else {
              DailyReflectionCard.shareContent(item);
            }
          },
        );
      },
    );
  }
}
