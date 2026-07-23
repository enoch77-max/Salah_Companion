import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../home/presentation/widgets/daily_reflection_card.dart';
import '../../data/repositories/daily_content_repository.dart';
import '../../domain/models/daily_content.dart';

/// Screen displaying reverse-chronological list of favorited [DailyContentItem]s.
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
            _items!.insert(index, item);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: _buildBody(context),
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

    final items = _items;
    if (items == null || items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.star_rounded,
                  size: 32,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No favorites saved yet',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tap the star icon on any daily reflection to save it here.',
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
          onShare: widget.onShare != null ? () => widget.onShare!(item) : null,
        );
      },
    );
  }
}
